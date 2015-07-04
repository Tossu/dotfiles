#!/usr/bin/env python
# -*- coding: utf-8 -*-

from datetime import date, timedelta


MONDAY = 0
TUESDAY = 1
WEDNESDAY = 2
THURSDAY = 3
FRIDAY = 4
SATURDAY = 5
SUNDAY = 6


def is_weekend():
    weekday = date.today().weekday()
    return weekday == SATURDAY or weekday == SUNDAY


def previous_weekday(date, weekday):
    offset = weekday - date.weekday()
    if 0 <= offset:
        offset -= 7
    return date + timedelta(days=offset)


def next_weekday(date, weekday):
    offset = weekday - date.weekday()
    if offset <= 0:
        offset += 7
    return date + timedelta(days=offset)


def easter(year):
    # Pääsiäinen / Pääsiäissunnuntai
    a = year % 19
    b = year // 100
    c = year % 100
    d = (19 * a + b - b // 4 - ((b - (b + 8) // 25 + 1) // 3) + 15) % 30
    e = (32 + 2 * (b % 4) + 2 * (c // 4) - d - (c % 4)) % 7
    f = d + e - 7 * ((a + 11 * d + 22 * e) // 451) + 114
    month = f // 31
    day = f % 31 + 1
    return date(year, month, day)


def good_friday(easter):
    # Pitkäperjantai
    return previous_weekday(easter, FRIDAY)


def second_easter_day(easter):
    # Toinen pääsiäispäivä
    return next_weekday(easter, MONDAY)


def ascension_day(easter):
    # Helatorstai
    return easter + timedelta(days=39)


def pentecost(easter):
    # Helluntai
    return easter + timedelta(days=49)


def mid_summer(year):
    # Juhannus
    return next_weekday(date(year, 6, 19), SATURDAY)


def saints_day(year):
    # Pyhäinpäivä
    return previous_weekday(date(year, 11, 6), SATURDAY)


def finnish_holidays(year):
    e = easter(year)
    return [
        date(year, 1, 1),
        date(year, 1, 6),
        good_friday(e),
        e,
        second_easter_day(e),
        date(year, 5, 1),
        ascension_day(e),
        pentecost(e),
        mid_summer(year),
        saints_day(year),
        date(year, 12, 6),
        date(year, 12, 25),
        date(year, 12, 26)
    ]


def run_test():
    days = [date(2015, 1, 1),  date(2015, 1, 6),
            date(2015, 4, 3),  date(2015, 4, 5),
            date(2015, 4, 6),  date(2015, 5, 1),
            date(2015, 5, 14), date(2015, 5, 24),
            date(2015, 6, 20), date(2015, 10, 31),
            date(2015, 12, 6), date(2015, 12, 25),
            date(2015, 12, 26)]

    assert(finnish_holidays(2015) == days)

    days = [date(2016, 1, 1),  date(2016, 1, 6),
            date(2016, 3, 25), date(2016, 3, 27),
            date(2016, 3, 28), date(2016, 5, 1),
            date(2016, 5, 5),  date(2016, 5, 15),
            date(2016, 6, 25), date(2016, 11, 5),
            date(2016, 12, 6), date(2016, 12, 25),
            date(2016, 12, 26)]

    assert(finnish_holidays(2016) == days)

if __name__ == "__main__":
    run_test()
    print(finnish_holidays(date.today().year))
