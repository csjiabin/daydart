[English](https://github.com/csjiabin/daydart/blob/main/README.md) | [Chinese](https://github.com/csjiabin/daydart/blob/main/README.zh-CN.md)

# DayDart

Time-handling library with day.js API.

![https://img.shields.io/github/license/csjiabin/daydart.svg](https://img.shields.io/github/license/csjiabin/daydart.svg)
![https://img.shields.io/github/issues/csjiabin/daydart.svg](https://img.shields.io/github/issues/csjiabin/daydart.svg)

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.io/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our
[online documentation](https://flutter.io/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Install

Run this command under your project

```sh
dart pub add daydart
# or
flutter pub add daydart
```

## API

The `DayDart` object is immutable, and all calls will return a new `DayDart` object.

- [Parsing](#parsing)
  - [Now Time](#now-time)
  - [String](#string)
  - [DateTime](#datetime)
  - [Timestamp](#timestamp)
  - [Clone](#clone)
  - [Valid](#valid)
- [Get](#get)
  - [Year](#year)
  - [Month](#month)
  - [Quarter](#quarter)
  - [Day](#day)
  - [Week](#week)
  - [Hour](#hour)
  - [Minute](#minute)
  - [Second](#second)
  - [Millisecond](#millisecond)
- [Operation](#operation)
  - [Add](#add)
  - [Subtract](#subtract)
- [Query](#query)
  - [isBefore](#isbefore)
  - [isSame](#issame)
  - [isAfter](#isafter)
  - [isSameOrBefore](#issameorbefore)
  - [isSameOrAfter](#issameorafter)
  - [isBetween](#isbetween)
  - [isDayDart](#isdaydart)
  - [isLeapYear](#isleapyear)
- [Display](#display)
  - [Format](#format)
  - [To DateTime](#to-datetime)
  - [To List](#to-list)
  - [To Map](#to-map)
  - [To IOS 8601 String](#to-ios-8601-string)
  - [To String](#to-string)

---

### Parsing

Passing in the supported format in `DayDart`.

#### Now Time

Calling DayDart() with no arguments returns a new `DayDart` object containing the current date and time

```dart
DayDart now = DayDart()
```

#### String

Parses the given string in `ISO 8601` format and returns an instance of the `DayDart` object.

```dart
DayDart('2018-04-04')
```

#### DateTime

A DateTime object passed in.

```dart
DayDart(DateTime.now());
```

#### Timestamp

Create `DayDart` with an integer value of milliseconds

```dart
DayDart(1623484401193);
```

#### Clone

All `DayDart` objects are immutable. Dayart#clone can still create a clone of the current object if needed.

```dart
DayDart a = DayDart()
DayDart b = a.clone()
```

Calling `DayDart()` on the `DayDart` object also clones it.

```dart
DayDart a = DayDart()
DayDart b = DayDart(a)
```

#### Valid

Returns a Boolean indicating whether the `DayDart` object contains an expiration date.

```dart
DayDart().isValid()
```

### Get

#### Year

Gets or sets the year.

```dart
DayDart().year();
DayDart().year(2000);
```

#### Month

Gets or sets the month.

Accept numbers from 1 to 12. If it exceeds that range, it will continue until the end of the year.

```dart
DayDart().month();
DayDart().month(1);
```

#### Quarter

Gets or sets the quarter.

```dart
DayDart('2010-04-01').quarter() // 2
DayDart('2010-04-01').quarter(2)
```

#### Day

Gets or sets the date of the month.

Accept numbers from 1 to 31. If this range is exceeded, it will last until the day.

```dart
DayDart().day()
DayDart().day(1)
```

#### Week

For weeks

```dart
DayDart().week()
```

#### Hour

Gets or sets the hour.

Accept the numbers from 0 to 59. If this range is exceeded, it will last until the day.

```dart
DayDart().hour()
DayDart().hour(12)
```

#### Minute

Gets or sets the minutes.

Accept the numbers from 0 to 59. If this range is exceeded, it will last until hours

```dart
DayDart().minute()
DayDart().minute(12)
```

#### Second

Gets or sets the seconds.

Accept the numbers from 0 to 59. If this range is exceeded, it will last up to minutes.

```dart
DayDart().second()
DayDart().second(12)
```

#### Millisecond

Gets or sets milliseconds.

Accepts numbers from 0 to 999. If this range is exceeded, it will last up to seconds.

```dart
DayDart().millisecond()
DayDart().millisecond(12)
```

### Operation

Once you have a `DayDart` object, you might want to manipulate it in some way.

DayDart supports method links like this:

```dart
DayDart('2019-01-25')..add(1, DayUnits.D)..subtract(1, DayUnits.y)..year(2009)..toString()
```

List of all available units

| uni | desc        |
| --- | ----------- |
| D   | day (1-31)  |
| M   | month(1-12) |
| y   | year        |
| h   | hour        |
| m   | minutes     |
| s   | seconds     |
| ms  | millisecond |

#### Add

Returns a cloned `DayDart` object, adding the specified time.

```dart
DayDart().add(7, DayUnits.D)
```

#### Subtract

Returns the cloned 'DayDart' object, subtracting the specified time.

```dart
DayDart().subtract(7, DayUnits.D)
```

### Query

List of all available units

| unit | desc        |
| ---- | ----------- |
| D    | day         |
| M    | month       |
| y    | year        |
| h    | hour        |
| m    | minutes     |
| s    | seconds     |
| ms   | millisecond |

#### isBefore

This indicates whether the `DayDart` object is before another supplied date-time.

```dart
DayDart().isBefore(DayDart('2011-01-01')) // default milliseconds
```

If you want to limit granularity to units rather than milliseconds, pass it as a second argument.

```dart
DayDart().isBefore('2011-01-01', DayUnits.y)
```

#### isSame

This indicates whether the `DayDart` object is the same as the date-time provided by another.

```dart
DayDart().isSame(DayDart('2011-01-01')) // default milliseconds
```

If you want to limit granularity to units rather than milliseconds, pass it as a second argument.

```dart
DayDart().isSame('2011-01-01', DayUnits.y)
```

#### isAfter

This indicates whether the `DayDart` object is after another supplied date-time.

```dart
DayDart().isAfter(DayDart('2011-01-01')) // default milliseconds
```

If you want to limit granularity to units rather than milliseconds, pass it as a second argument.。

```dart
DayDart().isAfter('2011-01-01', DayUnits.y)
```

#### isSameOrBefore

This indicates whether the `DayDart` object is the same or before another provided date-time.

```dart
DayDart().isSameOrBefore(DayDart('2011-01-01')) // default milliseconds
```

If you want to limit granularity to units rather than milliseconds, pass it as a second argument.

```dart
DayDart().isSameOrBefore('2011-01-01', DayUnits.y)
```

#### isSameOrAfter

This indicates whether the `DayDart` object is the same or after another supplied date-time.

```dart
DayDart().isSameOrAfter(DayDart('2011-01-01')) // default milliseconds
```

If you want to limit granularity to units rather than milliseconds, pass it as a second argument.

```dart
DayDart().isSameOrAfter('2011-01-01', DayUnits.y)
```

#### isBetween

This indicates whether the `DayDart` object is between the other two supplied date-times.

```dart
DayDart('2010-10-20').isBetween('2010-10-19', DayDart('2010-10-25'))// default milliseconds
```

If you want to limit granularity to units rather than milliseconds, pass it as a third parameter.

```dart
DayDart().isBetween('2010-10-19', '2010-10-25', DayUnits.y)
```

#### isDayDart

This indicates whether the variable is a `DayDart` object.

```dart
DayDart.isDayDart(DayDart()) // true
DayDart.isDayDart(DateTime.now()) // false
```

You can also use the `is` operator:

```dart
DayDart() is DayDart // true
```

#### isLeapYear

This indicates whether the year of the `DayDart` object is a leap year.

```dart
DayDart('2000-01-01').isLeapYear() // true
```

### Display

#### Format

Gets the formatted date based on the passed token string.

To escape characters, enclose them in square brackets (for example, 'MM').

```dart
DayDart().format()

DayDart('2019-01-25').format('dd/MM/yyyy') // '25/01/2019'
```

A list of all available parse tags

| arg        | desc                        |
| ---------- | --------------------------- |
| d          | DAY                         |
| E          | ABBR_WEEKDAY                |
| EEEE       | WEEKDAY                     |
| LLL        | ABBR_STANDALONE_MONTH       |
| LLLL       | STANDALONE_MONTH            |
| M          | NUM_MONTH                   |
| Md         | NUM_MONTH_DAY               |
| MEd        | NUM_MONTH_WEEKDAY_DAY       |
| MMM        | ABBR_MONTH                  |
| MMMd       | ABBR_MONTH_DAY              |
| MMMEd      | ABBR_MONTH_WEEKDAY_DAY      |
| MMMM       | MONTH                       |
| MMMMd      | MONTH_DAY                   |
| MMMMEEEEd  | MONTH_WEEKDAY_DAY           |
| QQQ        | ABBR_QUARTER                |
| QQQQ       | QUARTER                     |
| y          | YEAR                        |
| yM         | YEAR_NUM_MONTH              |
| yMd        | YEAR_NUM_MONTH_DAY          |
| yMEd       | YEAR_NUM_MONTH_WEEKDAY_DAY  |
| yMMM       | YEAR_ABBR_MONTH             |
| yMMMd      | YEAR_ABBR_MONTH_DAY         |
| yMMMEd     | YEAR_ABBR_MONTH_WEEKDAY_DAY |
| yMMMM      | YEAR_MONTH                  |
| yMMMMd     | YEAR_MONTH_DAY              |
| yMMMMEEEEd | YEAR_MONTH_WEEKDAY_DAY      |
| yQQQ       | YEAR_ABBR_QUARTER           |
| yQQQQ      | YEAR_QUARTER                |
| H          | HOUR24                      |
| Hm         | HOUR24_MINUTE               |
| Hms        | HOUR24_MINUTE_SECOND        |
| j          | HOUR                        |
| jm         | HOUR_MINUTE                 |
| jms        | HOUR_MINUTE_SECOND          |
| m          | MINUTE                      |
| ms         | MINUTE_SECOND               |
| s          | SECOND                      |

#### To DateTime

To get a copy of the local date object parsed from the 'dayDart' object, use dayDart #toDate.

```dart
DayDart('2019-01-25').toDate()
```

#### To List

```dart
DayDart('2019-01-25').toList() // [ 2019, 0, 25, 0, 0, 0, 0 ]
```

#### To Map

Returns `Map` with date property.

```dart
DayDart('2019-01-25').toMap()
/*
{
  years: 2019,
  months: 0,
  date: 25,
  hours: 0,
  minutes: 0,
  seconds: 0,
  milliseconds: 0
}
*/
```

#### To IOS 8601 String

Formatted as an ISO 8601 string.

```dart
DayDart('2019-01-25').toISOString() // 2019-01-25T00:00:00.000
```

#### To String

Returns a string representation of the date.

```dart
DayDart('2019-01-25').toString() // 2019-01-25 00:00:00.000
```
