Debugger Connection
===================

This repo was called "v8-debug-protocol", but since I split all the functional to a very simple vertical structure. This repo will only keeps the connection functional.

Usage
===================

### Methods

`TODO[return promise]: #connect`

```js
connection
  .connect(5858)
  .then(function(connection) {
    // do something
  });
```

`#request`

```js
connection.request('breakpoint', {
  arg1: 1,
  arg2: 2
}, function(err, originalResponse) {
  // do sth
});
```

`#disconnect`

```js
connection.disconnect().then(function() {

});
```

### Events

`break: from v8`

```js
connection.on('break', function(originalBreakpoint) {

});
```

`exception: from v8`

```js
connectin.on('exception', function(originalException) {

});
```

`error`

```js
connection.on('error', function(err) {

});
```

`TODO: change`

```js
connection.on('change', function() {
  // when new connection started
});
```
