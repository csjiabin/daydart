[English](https://github.com/csjiabin/daydart/blob/main/README.md) | [简体中文](https://github.com/csjiabin/daydart/blob/main/README.zh-CN.md)

# DayDart

具备 Day.js 一样 API 的时间处理库.

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

在项目下运行此命令

```sh
dart pub add daydart
# or
flutter pub add daydart
```

## API

`DayDart` 对象是不可变的，所有的调用都将返回一个新的 `DayDart` 对象。

- [解析](#解析)
  - [当前时间](#默认值)
  - [时间字符串](#字符串)
  - [DateTime 对象](#DateTime-对象)
  - [时间戳](#时间戳)
  - [克隆](#克隆)
  - [验证](#验证)
- [获取](#获取)
  - [年](#年)
  - [月](#月)
  - [季度](#季度)
  - [日](#日)
  - [月总天数](#月总天数)
  - [日期到年初总天数](#日期到年初总天数)
  - [日期到年初总星期数](#日期到年初总星期数)
  - [星期](#星期)
  - [小时](#小时)
  - [分钟](#分钟)
  - [秒](#秒)
  - [毫秒](#毫秒)
- [操作](#操作)
  - [增加](#增加)
  - [减少](#减少)
- [查询](#查询)
  - [是否之前](#是否之前)
  - [是否相同](#是否相同)
  - [是否之后](#是否之后)
  - [是否相同或之前](#是否相同或之前)
  - [是否相同或之后](#是否相同或之后)
  - [是否之间](#是否之间)
  - [判断是否为 DayDart](#判断是否为-DayDart)
  - [是否闰年](#是否闰年)
- [显示](#显示)
  - [格式化](#格式化)
  - [转 DateTime 对象](#转-DateTime-对象)
  - [转 List](#转-List)
  - [转 Map](#转-Map)
  - [转 IOS 8601 字符串](#转-IOS-8601-字符串)
  - [转字符串](#转字符串)

---

### 解析

在 `DayDart` 中传入支持的格式。

#### 默认值

不带参数调用 DayDart()将返回一个新的`DayDart`对象，其中包含当前日期和时间

```dart
DayDart now = DayDart()
```

#### 字符串

以 `ISO 8601` 格式解析给定字符串并返回`DayDart`对象实例。

```dart
DayDart('2018-04-04')
```

#### DateTime 对象

传入的一个 DateTime 对象。

```dart
DayDart(DateTime.now());
```

#### 时间戳(毫秒)

通过一个毫秒的整数值来创建`DayDart`

```dart
DayDart(1623484401193);
```

#### 克隆

所有 DayDart 对象是不可变的。如果需要的话，DayDart#clone 仍然可以创建当前对象的一个克隆。

```dart
DayDart a = DayDart()
DayDart b = a.clone()
```

在`DayDart`对象上调用 DayDart()也会克隆它。

```dart
DayDart a = DayDart()
DayDart b = DayDart(a)
```

#### 验证

返回一个布尔值，指示`DayDart`对象是否包含有效日期。

```dart
DayDart().isValid()
```

### 获取

#### 年

获取或设置年份。

```dart
DayDart().year();
DayDart().year(2000);
```

#### 月

获取或设置月份。

接受 1 到 12 的数字。如果超过这个范围，将一直持续到年底。

```dart
DayDart().month();
DayDart().month(1);
```

#### 季度

获取或设置季度。

```dart
DayDart('2010-04-01').quarter() // 2
DayDart('2010-04-01').quarter(2)
```

#### 日

获取或设置月份的日期。

接受从 1 到 31 的数字。如果超过这个范围，将持续到日。

```dart
DayDart().day()
DayDart().day(1)
```

#### 月总天数

获取月份总天数

```dart
DayDart().days()
```

#### 日期到年初总天数

获取日期到年初总天数

```dart
DayDart().dayOfYear()
```

#### 日期到年初总星期数

获取日期到年初总星期数

```dart
DayDart().weeks()
```

#### 星期

获取星期

```dart
DayDart().week()
```

#### 小时

获取或设置小时。

接受 0 到 59 的数字。如果超过这个范围，将持续到日。

```dart
DayDart().hour()
DayDart().hour(12)
```

#### 分钟

获取或设置分钟。

接受 0 到 59 的数字。如果超过这个范围，将持续到小时

```dart
DayDart().minute()
DayDart().minute(12)
```

#### 秒

获取或设置秒。

接受 0 到 59 的数字。如果超过这个范围，将持续到分钟。

```dart
DayDart().second()
DayDart().second(12)
```

#### 毫秒

获取或设置毫秒。

接受 0 到 999 的数字。如果超过这个范围，将持续到秒。

```dart
DayDart().millisecond()
DayDart().millisecond(12)
```

### 操作

一旦有了 DayDart 对象，您可能希望以某种方式对其进行操作。

DayDart 支持这样的方法链接:

```dart
DayDart('2019-01-25')..add(1, DayUnits.D)..subtract(1, DayUnits.y)..year(2009)..toString()
```

所有可用单位列表

| 单位 | 描述        |
| ---- | ----------- |
| D    | 天(1 到 31) |
| M    | 月份(1-12)  |
| y    | 年          |
| h    | 小时        |
| m    | 分钟        |
| s    | 秒          |
| ms   | 毫秒        |

#### 增加

返回一个克隆的 `DayDart` 对象，并添加指定的时间。

```dart
DayDart().add(7, DayUnits.D)
```

#### 减少

返回克隆的`DayDart`对象，并减去指定的时间。

```dart
DayDart().subtract(7, DayUnits.D)
```

### 查询

所有可用单位列表

| 单位 | 描述 |
| ---- | ---- |
| D    | 天   |
| M    | 月份 |
| y    | 年   |
| h    | 小时 |
| m    | 分钟 |
| s    | 秒   |
| ms   | 毫秒 |

#### 是否之前

这指示`DayDart`对象是否在另一个提供的 date-time 之前。

```dart
DayDart().isBefore(DayDart('2011-01-01')) // default milliseconds
```

如果希望将粒度限制为单位而不是毫秒，则将其作为第二个参数传递。

```dart
DayDart().isBefore('2011-01-01', DayUnits.y)
```

#### 是否相同

这指示`DayDart`对象是否与另一个提供的 date-time 相同。

```dart
DayDart().isSame(DayDart('2011-01-01')) // default milliseconds
```

如果希望将粒度限制为单位而不是毫秒，则将其作为第二个参数传递。

```dart
DayDart().isSame('2011-01-01', DayUnits.y)
```

#### 是否之后

这指示`DayDart`对象是否在另一个提供的 date-time 之后。

```dart
DayDart().isAfter(DayDart('2011-01-01')) // default milliseconds
```

如果希望将粒度限制为单位而不是毫秒，则将其作为第二个参数传递。

```dart
DayDart().isAfter('2011-01-01', DayUnits.y)
```

#### 是否相同或之前

这表明`DayDart`对象是相同的还是在另一个提供的 date-time 之前。

```dart
DayDart().isSameOrBefore(DayDart('2011-01-01')) // default milliseconds
```

如果希望将粒度限制为单位而不是毫秒，则将其作为第二个参数传递。

```dart
DayDart().isSameOrBefore('2011-01-01', DayUnits.y)
```

#### 是否相同或之后

这指示`DayDart`对象是相同的还是在另一个提供的 date-time 之后。

```dart
DayDart().isSameOrAfter(DayDart('2011-01-01')) // default milliseconds
```

如果希望将粒度限制为单位而不是毫秒，则将其作为第二个参数传递。

```dart
DayDart().isSameOrAfter('2011-01-01', DayUnits.y)
```

#### 是否之间

这指示`DayDart`对象是否位于另外两个提供的 date-time 之间。

```dart
DayDart('2010-10-20').isBetween('2010-10-19', DayDart('2010-10-25'))// default milliseconds
```

如果希望将粒度限制为单位而不是毫秒，则将其作为第三个参数传递。

```dart
DayDart().isBetween('2010-10-19', '2010-10-25', DayUnits.y)
```

#### 判断是否为 DayDart

这指示变量是否为 `DayDart` 对象。

```dart
DayDart.isDayDart(DayDart()) // true
DayDart.isDayDart(DateTime.now()) // false
```

也可以使用 `is` 操作符:

```dart
DayDart() is DayDart // true
```

#### 是否闰年

这表明 `DayDart` 对象的年份是否为闰年。

```dart
DayDart('2000-01-01').isLeapYear() // true
```

### 显示

#### 格式化

根据传入的令牌字符串获取格式化的日期。

要对字符进行转义，请将它们括在方括号中(例如'MM')。

```dart
DayDart().format()

DayDart('2019-01-25').format('dd/MM/yyyy') // '25/01/2019'
```

所有可用解析标记的列表

| 标识       | 描述                        |
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

#### 转 DateTime 对象

要获得从`DayDart`对象解析的本地日期对象的副本，请使用 DayDart#toDate。

```dart
DayDart('2019-01-25').toDate()
```

#### 转 List

```dart
DayDart('2019-01-25').toList() // [ 2019, 1, 25, 0, 0, 0, 0 ]
```

#### 转 Map

返回具有日期属性的`Map`。

```dart
DayDart('2019-01-25').toMap()
/*
{
  years: 2019,
  months: 1,
  date: 25,
  hours: 0,
  minutes: 0,
  seconds: 0,
  milliseconds: 0
}
*/
```

#### 转 IOS 8601 字符串

格式化为 ISO 8601 字符串。

```dart
DayDart('2019-01-25').toISOString() // 2019-01-25T00:00:00.000
```

#### 转字符串

返回日期的字符串表示形式。

```dart
DayDart('2019-01-25').toString() // 2019-01-25 00:00:00.000
```
