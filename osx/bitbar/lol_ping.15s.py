#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
lol-ping main script.

This script displays in sorted table the ping to the following League of
Legends regions: Europe West (EUW), Europe North East (EUNE), Latin America
(LAN) and Oceania (OCE). The script is intended to within Bitbar so it includes
inside the strings its custom tags for improving the display. This scripts runs
both on Python 2 and Python 3.
"""

# Assures compatibility in both Python 2 and Python 3.
from __future__ import print_function
from __future__ import unicode_literals
from __future__ import absolute_import
from __future__ import division
from platform import system

import subprocess
import sys
import re

# Extracted from
# https://www.reddit.com/r/leagueoflegends/comments/4efy17/how_to_check_your_ping_without_getting_into_the/d20167p
SERVER = {
    'NA': '104.160.131.3',
    'EUW': '104.160.141.3',
    'EUNE': '104.160.142.3',
    'OCE': '104.160.156.1',
    'LAN': '104.160.136.3',
    # For testing purposes.
    'INV': '0.0.0.0',
    'LOC': '127.0.0.1'
}


def ping(reg):
    """
    Calls the native ping function of OS X to extract the average time, the
    maximum time and the unit of the connection to the given server.

    :param host: str IP of the server.
    :return: dictionary average time, maximum time
    """

    # If the region does not exist in our server list.
    if reg not in SERVER:
        return [reg]

    host = SERVER[reg]

    # We call the native ping command from OS X.
    cmd = subprocess.Popen(
        ['ping', '-c', '4', host],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )

    out, err = cmd.communicate()

    # Invalid host
    if err:
        return [reg]

    else:
        # Grabs the average, max and the unit
        regexp = re.compile(r'round-trip min/avg/max/stddev ='
                            r' \d+.\d+/(\d+.\d+)/(\d+.\d+)/\d+.\d+ (\w+)$')
        match = re.search(regexp, out.decode('utf-8'))

        return [reg] + list(match.group(1, 2, 3)) if match else [reg]


def region_builder(data):
    """
    Takes an instance of a ping result and builds a dictionary ready to
    display.

    The ping result returns the raw results. This function returns a dictionary
    with all the sections formatted.

    :param data: dic Result of ping call.
    :return dic Result of the ping ready to display.
    """
    if len(data) == 1:
        return {'index': -1, 'region': data[0].ljust(4), 'average': '',
                'maximum': '', 'color': '| color=#444'}

    index = float(data[1])
    region_initials = '{region}:'.format(region=data[0].ljust(4))
    average = '{average} {unit}'.format(average=data[1], unit=data[3])
    maximum = '(max {maximum} {unit})'.format(maximum=data[2], unit=data[3])

    if index < 100:
        color = '|color=#0A640C'  # Green
    elif index < 150:
        color = '|color=#FEC041'  # Yellow
    else:
        color = '|color=#FC645F'  # Red

    return {'index': index, 'region': region_initials, 'average': average,
            'maximum': maximum, 'color': color}


def display(data):
    """
    Displays the interface.

    Takes a list of dictionaries which contains the information from the ping
    operations ready to display and prints them after appliying the proper
    padding to align the blocks. It also adds the button on the navbar and the
    reload.

    :param data: list List with dictionaries of pings ready to display.
    """
    average_max_len = max([len(x['average']) for x in data] + [0])
    maximum_max_len = max([len(x['maximum']) for x in data] + [0])
    # Fixes an encoding issue with Bitbar. Usually this would not be needed
    # due to the import of unicode literals from future.
    if sys.version[0] == 3:
        print('𝐋')
    else:
        print('𝐋'.encode('utf-8'))

    print(u'---')
    for item in data:

        region_initials = item['region']
        color = item['color']

        if item['index'] == -1:
            row = '{region} is not reacheable at the moment.{clr}'
            row = row.format(region=region_initials.strip(), clr=color)

        else:

            average = item['average'].rjust(average_max_len)
            maximum = item['maximum'].rjust(maximum_max_len)

            row = '{region} {average} {maximum} {clr} font=Menlo'
            row = row.format(region=region_initials, average=average,
                             maximum=maximum, clr=color)

        print(row)
    print('Update now | color=#444 refresh=true')


if __name__ == '__main__':

    if system().lower() == 'darwin':

        # For every region, calculates the ping and orders it speed.
        PINGS = []
        for region in SERVER:
            if region != 'LOC' and region != 'INV':
                region_data = region_builder(ping(region))
                PINGS.append(region_data)

        PINGS.sort(key=lambda x: (1/float(x['index'])), reverse=True)
        display(PINGS)

    else:
        print(system().lower())
