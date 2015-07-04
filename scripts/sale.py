#!/usr/bin/env python
# -*- coding: utf-8 -*-
import requests
import json
import datetime
from color_print import print_color, GREEN, RED


def get_store_opening_times(store_id):
    url = "https://karttapalvelu.s-kanava.net/" +\
            "map/serviceapi/search.html?tpid=%d"
    try:
        response = requests.get(url % store_id)
    except Exception:
        return []
    j = json.loads(response.text)

    today = datetime.date.today()
    for o in j['pobs'][0]['opening_times']:
        date = datetime.date(
                *reversed([int(x) for x in o['day'].split('.')]))

        is_today = date == today
        start_time = o['start_time']
        end_time = o['end_time']
        is_closed = start_time == end_time

        yield (is_today, is_closed, date, start_time, end_time)


if __name__ == "__main__":
    store_id = 653574384
    opening_times = get_store_opening_times(store_id)

    for time in opening_times:
        is_today, is_closed, date, start_time, end_time = time

        date = "%9s" % "Today" if is_today else date.strftime("%a %d.%m")
        time = "%s-%s" % (start_time, end_time)

        if is_closed:
            print_color("%s" % date, RED)
        else:
            print_color("%s %s" % (date, time), GREEN)
