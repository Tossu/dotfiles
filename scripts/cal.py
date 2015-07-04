#!/usr/bin/env python
# -*- coding: utf-8 -*-

import datetime
from holidays import finnish_holidays
from color_print import color_string, GREEN, RED


today = datetime.date.today()
finnish_holidays = finnish_holidays(today.year)
week_header = "MO TU WE TH FR SA SU"
months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
]


def month_days(year, month):
    firstweekday = 0  # 0 = monday, 6 = sunday
    date = datetime.date(year, month, 1)
    days = (date.weekday() - firstweekday) % 7  # offset
    date -= datetime.timedelta(days=days)
    oneday = datetime.timedelta(days=1)
    while True:
        if date.month == month:
            yield date
        else:
            yield None
        try:
            date += oneday
        except OverflowError:
            # Adding one day could fail after datetime.MAXYEAR
            break
        if date.month != month and date.weekday() == firstweekday:
            break


def month_weeks(year, month):
    days = list(month_days(year, month))
    return [days[i:i+7] for i in range(0, len(days), 7)]


def format_day(date):
    if not date:
        return '  '

    s = "%2i" % date.day
    if date == today:
        s = ' X'
    if date in finnish_holidays:
        return color_string(s, RED)
    return s


def format_month(
        year, month, day_format=format_day, months=months,
        week_header=week_header):

    s = ("%s %r/%r" % (months[month-1], month, year)).center(20)
    s += "\n%s\n" % week_header
    for week in month_weeks(year, month):
        s += ' '.join(day_format(date) for date in week)
        s += '\n'
    return s


if __name__ == "__main__":
    print(format_month(today.year, today.month))
