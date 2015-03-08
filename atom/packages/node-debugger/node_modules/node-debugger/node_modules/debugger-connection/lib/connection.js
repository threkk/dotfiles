var EventEmitter = require('events').EventEmitter
  , inherits = require('util').inherits
  , net = require('net')
  , q = require('q')
  , Protocol = require('_debugger').Protocol


/**
 *  @author kiddkai kiddkai@gmail.com
 *
 *  @class Connection
 *
 *  debugger connection connection for atom debugger
 */
inherits(Connection, EventEmitter)
function Connection(runner) {
  EventEmitter.call(this);

  var self = this;

  this._reqCallbacks = [];
  this.runner = runner;

  this.runner.on('change', function() {
    if (!self.runner.proc) {
      return onexit();
    }
    self.connect(self.runner.port);
  });

  this.runner.on('error', onexit);

  function onexit() {
    self.socket = null;
    self._connected = false;
    self.emit('change');
  }
}

function _doResponse(res) {
  var cb,
      index = -1;

  this._reqCallbacks.some(function(fn, i) {
    if (fn.request_seq == res.body.request_seq) {
      cb = fn;
      index = i;
      return true;
    }
  });

  var self = this;
  var handled = false;

  if (res.headers.Type == 'connect') {
    // Request a list of scripts for our own storage.
    self.emit('ready');
    handled = true;

  } else if (res.body && res.body.event == 'break') {
    this.emit('break', res.body);
    handled = true;

  } else if (res.body && res.body.event == 'exception') {
    this.emit('exception', res.body);
    handled = true;

  } else if (res.body && res.body.event == 'afterCompile') {
    this.emit('afterCompile', res.body.body.script);
    handled = true;

  } else if (res.body && res.body.event == 'scriptCollected') {
    // ???
    handled = true;

  }

  if (cb) {
    this._reqCallbacks.splice(index, 1);
    handled = true;

    var err = res.success === false && (res.message || true) ||
              res.body.success === false && (res.body.message || true);
    cb(err, res.body && res.body.body || res.body, res);
  }

  if (!handled) this.emit('unhandledResponse', res.body);
}

var connection = Connection.prototype;


/**
 * Connect to the specific debugger in the `port`
 *
 * If the connection of port is already being established, then it
 * will just return the connection directly
 *
 * ### Examples:
 *
 *  ```js
 *    connection.connect(port).then(...)
 *  ```
 *
 * @param {Number} port to connect to debug server
 *
 * @return {Promise} promise object, call `then` callback when success
 */
connection.connect = function(port) {
  var socket
    , self = this
    , deferred
    , protocol = new Protocol();

  self._reqCallbacks = [];
  self._connectTimes = self._connectTimes || 0;
  self.protocol = protocol;
  if (this._connected && this.port === port) {
    return q(this.socket);
  }

  socket = net.connect({ port: port })
  this.port = port;
  self.socket = socket;
  deferred = q.defer();
  self.socket.setEncoding('utf8');
  self.socket.on('connect', onconnect);
  self.socket.on('error', onerror);
  self.socket.on('data', function(d) {
    self.protocol.execute(d);
  });

  function onconnect() {
    self._connectTimes = 0;
    self._connected = true;
    self.emit('change');
    deferred.resolve(self);
  }

  function onerror(err) {
    self._connected = false;
    self.socket = null;
    self._connectTimes += 1;

    if (self._connectTimes === 10) {
      self.emit('error', err);
    }

    setTimeout(function() {
      self.connect(port);
    }, 500);
  }

  protocol.onResponse = _doResponse.bind(this);

  return deferred.promise;
}


/**
 * Send the request to debugger server
 *
 * Example:
 *
 *   ```js
 *     socket.request('breakpoint', {
 *       arg1: 1,
 *       arg2: 2
 *     }, function(err, originalResponse) {
 *       // do sth
 *     });
 *   ```
 *
 * @param {String} command
 * @param {Object} request data to server
 * @param {Function} callback with param (err, result)
 */
connection.request = function(command, args, cb) {
  var req = {
    command: command,
    type: 'request'
  };

  if (args) {
    req.arguments = args;
  }

  if (!this.socket) {
    return;
  }

  this.socket.write(this.protocol.serialize(req));
  cb.request_seq = req.seq;
  this._reqCallbacks.push(cb);
};


/**
 * Loopup the refer for objects
 * @param  {Array} reference array
 * @return {Promise} which contains the response body
 */
connection.lookup = function(refs) {
  var self = this;

  return q.Promise(function(resolve, reject) {
    if (!self._connected) {
      return reject(new Error('Client is not connected'));
    }

    self.request('lookup', {
      handles: refs,
      includeSource: true
    }, function(err, body) {
      if (err) {
        return reject(err);
      }
      resolve(body);
    });
  });
};


/**
 * Disconnect the socket
 *
 * Example:
 *
 * ```js
 * connection
 * .disconnect().then(function() {
 * 	 // sth
 * })
 * ```
 *
 */
connection.disconnect = function() {
  var deferred = q.defer()
    , self = this;

  this.request('disconnect', {}, deferred.makeNodeResolver());

  deferred.promise.then(function() {
    self.socket = null;
    self._connected = false;
    self.emit('change');
  });

  return deferred.promise
}


module.exports = Connection;
