library daydart;

import 'package:intl/intl.dart';

enum DayUnits { y, M, D, w, h, m, s, ms }

class DayDart {
  static String locale = 'en_US';

  DateTime _date = DateTime.now();

  DayDart([Object? date]) {
    Intl.defaultLocale = DayDart.locale;
    _initDate(date);
  }

  _initDate([Object? date]) {
    try {
      /// 如果为null则默认是DateTime.now()
      if (date == null) return;
      int _len = date.toString().length;
      if (date is int) {
        if (_len == 10) {
          _date = DateTime.fromMillisecondsSinceEpoch(date * 1000);
        } else if (_len == 13) {
          _date = DateTime.fromMillisecondsSinceEpoch(date);
        } else if (_len == 16) {
          _date = DateTime.fromMicrosecondsSinceEpoch(date);
        } else {
          throw new Exception('The timestamp length must be 13 or 16 bits');
        }
        return;
      }
      if (date is DayDart) {
        _date = date.$d;
        return;
      }
      if (date is DateTime) {
        _date = date;
        return;
      }
      if (date is String) {
        _date = DateTime.parse(date);
        return;
      }
      throw new Exception(
          'date type is not [DayDart, DateTime, int[13 || 16], String]');
    } on Exception catch (e) {
      throw e;
    }
  }

  DateTime get $d {
    return _date;
  }

  int get $y {
    return _date.year;
  }

  int get $M {
    return _date.month;
  }

  int get $D {
    return _date.day;
  }

  int get $W {
    return _date.weekday;
  }

  int get $h {
    return _date.hour;
  }

  int get $m {
    return _date.minute;
  }

  int get $s {
    return _date.second;
  }

  int get $ms {
    return _date.millisecond;
  }

  /// 获取或设置年份。
  int year([int? y]) {
    if (y != null) {
      _date = DateTime(y, $M, $D, $h, $m, $s, $ms);
    }
    return $y;
  }

  /// 获取或设置月份。
  /// 接受1到12的数字。如果超过这个范围，将一直持续到年底。
  int month([int? m]) {
    if (m != null) {
      _date = DateTime($y, m, $D, $h, $m, $s, $ms);
    }
    return $M;
  }

  /// 获取或设置月份的日期。
  /// 接受从1到31的数字。如果超过这个范围，将持续到日。
  int day([int? d]) {
    if (d != null) {
      _date = DateTime($y, $M, d, $h, $m, $s, $ms);
    }
    return $D;
  }

  /// 获取星期几。
  /// 接受0(星期日)到6(星期六)的数字。如果超过这个范围，将持续到几周。
  int week([int? d]) {
    if (d != null) {
      day((d - $W) * 7);
    }
    return $W;
  }

  ///  获取或设置季度。
  int quarter([int? q]) {
    if (q != null) {
      month($M % 3 + (q - 1) * 3);
    }
    return ($M / 3).ceil();
  }

  /// 获取或设置小时。
  /// 接受0到59的数字。如果超过这个范围，将持续到日。
  int hour([int? h]) {
    if (h != null) {
      _date = DateTime($y, $M, $D, h, $m, $s, $ms);
    }
    return $h;
  }

  /// 获取或设置分钟。
  /// 接受0到59的数字。如果超过这个范围，将持续到小时。
  int minute([int? m]) {
    if (m != null) {
      _date = DateTime($y, $M, $D, $h, m, $s, $ms);
    }
    return $m;
  }

  /// 获取或设置秒。
  /// 接受0到59的数字。如果超过这个范围，将持续到分钟。
  int second([int? s]) {
    if (s != null) {
      _date = DateTime($y, $M, $D, $h, $m, s, $ms);
    }
    return $s;
  }

  ///  获取或设置毫秒。
  ///  接受0到999的数字。如果超过这个范围，将持续到秒。
  int millisecond([int? ms]) {
    if (ms != null) {
      _date = DateTime($y, $M, $D, $h, $m, $s, ms);
    }
    return $ms;
  }

  ///  返回DayDart对象，并添加指定的时间。
  DayDart add(int num, DayUnits unit) {
    switch (unit) {
      case DayUnits.y:
        year($y + num);
        break;
      case DayUnits.M:
        month($M + num);
        break;
      case DayUnits.D:
        day($D + num);
        break;
      case DayUnits.h:
        hour($h + num);
        break;
      case DayUnits.m:
        minute($m + num);
        break;
      case DayUnits.s:
        second($s + num);
        break;
      case DayUnits.ms:
        millisecond($ms + num);
        break;
    }
    return clone();
  }

  ///  返回DayDart对象，并减去指定的时间。
  DayDart subtract(int num, DayUnits unit) {
    switch (unit) {
      case DayUnits.y:
        year($y - num);
        break;
      case DayUnits.M:
        month($M - num);
        break;
      case DayUnits.D:
        day($D - num);
        break;
      case DayUnits.h:
        hour($h - num);
        break;
      case DayUnits.m:
        minute($m - num);
        break;
      case DayUnits.s:
        second($s - num);
        break;
      case DayUnits.ms:
        millisecond($ms - num);
        break;
    }
    return clone();
  }

  /// 根据传入的令牌字符串获取格式化的日期。
  /// 要对字符进行转义，请将它们括在方括号中(例如'MM')。
  ///      --------                   --------
  ///      DAY                          d
  ///      ABBR_WEEKDAY                 E
  ///      WEEKDAY                      EEEE
  ///      ABBR_STANDALONE_MONTH        LLL
  ///      STANDALONE_MONTH             LLLL
  ///      NUM_MONTH                    M
  ///      NUM_MONTH_DAY                Md
  ///      NUM_MONTH_WEEKDAY_DAY        MEd
  ///      ABBR_MONTH                   MMM
  ///      ABBR_MONTH_DAY               MMMd
  ///      ABBR_MONTH_WEEKDAY_DAY       MMMEd
  ///      MONTH                        MMMM
  ///      MONTH_DAY                    MMMMd
  ///      MONTH_WEEKDAY_DAY            MMMMEEEEd
  ///      ABBR_QUARTER                 QQQ
  ///      QUARTER                      QQQQ
  ///      YEAR                         y
  ///      YEAR_NUM_MONTH               yM
  ///      YEAR_NUM_MONTH_DAY           yMd
  ///      YEAR_NUM_MONTH_WEEKDAY_DAY   yMEd
  ///      YEAR_ABBR_MONTH              yMMM
  ///      YEAR_ABBR_MONTH_DAY          yMMMd
  ///      YEAR_ABBR_MONTH_WEEKDAY_DAY  yMMMEd
  ///      YEAR_MONTH                   yMMMM
  ///      YEAR_MONTH_DAY               yMMMMd
  ///      YEAR_MONTH_WEEKDAY_DAY       yMMMMEEEEd
  ///      YEAR_ABBR_QUARTER            yQQQ
  ///      YEAR_QUARTER                 yQQQQ
  ///      HOUR24                       H
  ///      HOUR24_MINUTE                Hm
  ///      HOUR24_MINUTE_SECOND         Hms
  ///      HOUR                         j
  ///      HOUR_MINUTE                  jm
  ///      HOUR_MINUTE_SECOND           jms
  ///      HOUR_MINUTE_GENERIC_TZ       jmv   (not yet implemented)
  ///      HOUR_MINUTE_TZ               jmz   (not yet implemented)
  ///      HOUR_GENERIC_TZ              jv    (not yet implemented)
  ///      HOUR_TZ                      jz    (not yet implemented)
  ///      MINUTE                       m
  ///      MINUTE_SECOND                ms
  ///      SECOND                       s
  /// Examples Using the US Locale:
  ///
  ///      Pattern                           Result
  ///      ----------------                  -------
  ///      DayDart().format('yMd')                -> 7/10/1996
  ///      DayDart().format('yMMMMd','en_US')       -> July 10, 1996
  ///      DayDart().format('jm')                  -> 5:08 PM
  ///      DayDart().format('Hm')                 -> 17:08 // force 24 hour time
  String format([String? pattern = 'yyyy-MM-dd HH:mm:ss', String? locale]) {
    return DateFormat(pattern, locale).format(_date);
  }

  Duration diff(DayDart d) {
    Duration _diff = _date.difference(d.$d);
    return _diff;
  }

  /// 检测当前 Date 对象是一个有效的 DateTime
  bool isValid() {
    return _date is DateTime;
  }

  static bool isDayDart(Object d) {
    return d is DayDart;
  }

  /// 是否闰年
  bool isLeapYear() {
    return (($y % 4 == 0) && ($y % 100 != 0)) || ($y % 400 == 0);
  }

  /// 这指示Day对象是否与另一个提供的date-time相同。
  bool isSame(Object date, [DayUnits unit = DayUnits.ms]) {
    DayDart d = DayDart(date);
    bool valid = isSameMillisecond(d);
    switch (unit) {
      case DayUnits.y:
        valid = isSameYear(d);
        break;
      case DayUnits.M:
        valid = isSameMonth(d);
        break;
      case DayUnits.D:
        valid = isSameDay(d);
        break;
      case DayUnits.h:
        valid = isSameHour(d);
        break;
      case DayUnits.m:
        valid = isSameMinute(d);
        break;
      case DayUnits.s:
        valid = isSameSecond(d);
        break;
      case DayUnits.ms:
        valid = isSameMillisecond(d);
        break;
    }
    return valid;
  }

  ///  这指示Day对象是否在另一个提供的date-time之前。
  bool isBefore(Object date, [DayUnits unit = DayUnits.ms]) {
    DayDart d = DayDart(date);
    bool valid = isBeforeMillisecond(d);
    switch (unit) {
      case DayUnits.y:
        valid = isBeforeYear(d);
        break;
      case DayUnits.M:
        valid = isBeforeMonth(d);
        break;
      case DayUnits.D:
        valid = isBeforeDay(d);
        break;
      case DayUnits.h:
        valid = isBeforeHour(d);
        break;
      case DayUnits.m:
        valid = isBeforeMinute(d);
        break;
      case DayUnits.s:
        valid = isBeforeSecond(d);
        break;
      case DayUnits.ms:
        valid = isBeforeMillisecond(d);
        break;
    }
    return valid;
  }

  ///  这指示Day对象是否在另一个提供的date-time之后。
  bool isAfter(Object date, [DayUnits unit = DayUnits.ms]) {
    DayDart d = DayDart(date);
    bool valid = isAfterMillisecond(d);
    switch (unit) {
      case DayUnits.y:
        valid = isAfterYear(d);
        break;
      case DayUnits.M:
        valid = isAfterMonth(d);
        break;
      case DayUnits.D:
        valid = isAfterDay(d);
        break;
      case DayUnits.h:
        valid = isAfterHour(d);
        break;
      case DayUnits.m:
        valid = isAfterMinute(d);
        break;
      case DayUnits.s:
        valid = isAfterSecond(d);
        break;
      case DayUnits.ms:
        valid = isAfterMillisecond(d);
        break;
    }
    return valid;
  }

  ///  相同或之前
  bool isSameOrBefore(Object d, [DayUnits unit = DayUnits.ms]) {
    return isSame(d, unit) || isBefore(d, unit);
  }

  ///  相同或之后
  bool isSameOrAfter(Object d, [DayUnits unit = DayUnits.ms]) {
    return isSame(d, unit) || isAfter(d, unit);
  }

  ///之间
  bool isBetween(Object start, Object end, [DayUnits unit = DayUnits.ms]) {
    return isBefore(start, unit) && isAfter(end, unit);
  }

  /// 相同 start
  bool isSameYear(DayDart d) {
    return $y == d.$y;
  }

  bool isSameMonth(DayDart d) {
    return isSameYear(d) && $M == d.$M;
  }

  bool isSameDay(DayDart d) {
    return isSameMonth(d) && $D == d.$D;
  }

  bool isSameHour(DayDart d) {
    return isSameDay(d) && $h == d.$h;
  }

  bool isSameMinute(DayDart d) {
    return isSameHour(d) && $m == d.$m;
  }

  bool isSameSecond(DayDart d) {
    return isSameMinute(d) && $s == d.$s;
  }

  bool isSameMillisecond(DayDart d) {
    return isSameSecond(d) && $ms == d.$ms;
  }

  /// 相同 end

  /// 之前 start
  bool isBeforeYear(DayDart d) {
    return $y < d.$y;
  }

  bool isBeforeMonth(DayDart d) {
    return isSameOrBefore(d, DayUnits.y) && $M < d.$M;
  }

  bool isBeforeDay(DayDart d) {
    return isSameOrBefore(d, DayUnits.M) && $D < d.$D;
  }

  bool isBeforeHour(DayDart d) {
    return isSameOrBefore(d, DayUnits.D) && $h < d.$h;
  }

  bool isBeforeMinute(DayDart d) {
    return isSameOrBefore(d, DayUnits.h) && $m < d.$m;
  }

  bool isBeforeSecond(DayDart d) {
    return isSameOrBefore(d, DayUnits.m) && $s < d.$s;
  }

  bool isBeforeMillisecond(DayDart d) {
    return isSameOrBefore(d, DayUnits.s) && $ms < d.$ms;
  }

  /// 之前 end

  /// 之后 start
  bool isAfterYear(DayDart d) {
    return $y > d.$y;
  }

  bool isAfterMonth(DayDart d) {
    return isSameOrAfter(d, DayUnits.y) && $M > d.$M;
  }

  bool isAfterDay(DayDart d) {
    return isSameOrAfter(d, DayUnits.M) && $D > d.$D;
  }

  bool isAfterHour(DayDart d) {
    return isSameOrAfter(d, DayUnits.D) && $h > d.$h;
  }

  bool isAfterMinute(DayDart d) {
    return isSameOrAfter(d, DayUnits.h) && $m > d.$m;
  }

  bool isAfterSecond(DayDart d) {
    return isSameOrAfter(d, DayUnits.m) && $s > d.$s;
  }

  bool isAfterMillisecond(DayDart d) {
    return isSameOrAfter(d, DayUnits.s) && $ms > d.$ms;
  }

  /// 之后 end

  ///创建当前对象的一个克隆。
  DayDart clone() {
    return DayDart(_date);
  }

  ///  返回当前的 DateTime 对象
  DateTime toDate() {
    return _date;
  }

  /// 返回 ISO8601 格式的字符串
  String toISOString() {
    return _date.toIso8601String();
  }

  /// 转List
  List<int> toList() {
    return [$y, $M, $D, $h, $m, $s, $ms];
  }

  /// 转Map
  Map<String, int> toMap() {
    return {
      'years': $y,
      'months': $M,
      'date': $D,
      'hours': $h,
      'minutes': $m,
      'seconds': $s,
      'milliseconds': $ms
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return _date.toString();
  }
}
