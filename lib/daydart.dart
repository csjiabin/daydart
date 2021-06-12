library daydart;

import 'package:intl/intl.dart';

class DayDart {
  DayDart([Object? date]) {
    Intl.defaultLocale = DayDart.locale;
    _initDate(date);
    print(_date);
  }

  static String locale = 'en_US';

  DateTime _date = DateTime.now();

  _initDate([Object? date]) {
    try {
      /// 如果为null则默认是DateTime.now()
      if (date == null) return;
      int _len = date.toString().length;
      if (date is int) {
        if (_len == 13) {
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

  DateTime get $d => _date;

  int get $y => _date.year;

  int get $M => _date.month;

  int get $D => _date.day;

  int get $W => _date.weekday;

  int get $h => _date.hour;

  int get $m => _date.minute;

  int get $s => _date.second;

  int get $ms => _date.millisecond;

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
  DayDart add(int num, String unit) {
    if (['year', 'y'].contains(unit)) {
      year($y + num);
    }
    if (['month', 'M'].contains(unit)) {
      month($M + num);
    }

    if (['day', 'D'].contains(unit)) {
      day($D + num);
    }
    if (['hour', 'h'].contains(unit)) {
      hour($h + num);
    }
    if (['minute', 'm'].contains(unit)) {
      minute($m + num);
    }
    if (['second', 's'].contains(unit)) {
      second($s + num);
    }
    if (['millisecond', 'ms'].contains(unit)) {
      millisecond($ms + num);
    }
    return this;
  }

  ///  返回DayDart对象，并减去指定的时间。
  DayDart subtract(int num, String unit) {
    if (['year', 'y'].contains(unit)) {
      year($y - num);
    }
    if (['month', 'M'].contains(unit)) {
      month($M - num);
    }

    if (['day', 'D'].contains(unit)) {
      day($D - num);
    }
    if (['hour', 'h'].contains(unit)) {
      hour($h - num);
    }
    if (['minute', 'm'].contains(unit)) {
      minute($m - num);
    }
    if (['second', 's'].contains(unit)) {
      second($s - num);
    }
    if (['millisecond', 'ms'].contains(unit)) {
      millisecond($ms - num);
    }
    return this;
  }

  /// 根据传入的令牌字符串获取格式化的日期。
  /// 要对字符进行转义，请将它们括在方括号中(例如[MM])。
  String format([String? pattern = 'yyyy-MM-dd hh:mm:ss', String? locale]) {
    return DateFormat(pattern, locale).format(_date);
  }

  Duration diff(DayDart d) {
    Duration _diff = _date.difference(d.$d);
    return _diff;
  }

  /// 检测当前 Date 对象是一个有效的 DateTime
  bool isValid() => _date is DateTime;

  static bool isDayDart(Object d) => d is DayDart;

  /// 是否闰年
  bool isLeapYear() {
    return (($y % 4 == 0) && ($y % 100 != 0)) || ($y % 400 == 0);
  }

  /// 这指示Day对象是否与另一个提供的date-time相同。
  bool isSame(DayDart d, [String? unit]) {
    if (['year', 'y'].contains(unit)) {
      return isSameYear(d);
    }
    if (['month', 'M'].contains(unit)) {
      return isSameMonth(d);
    }
    if (['day', 'D'].contains(unit)) {
      return isSameDay(d);
    }
    if (['hour', 'h'].contains(unit)) {
      return isSameHour(d);
    }
    if (['minute', 'm'].contains(unit)) {
      return isSameMinute(d);
    }
    if (['second', 's'].contains(unit)) {
      return isSameSecond(d);
    }
    if (['millisecond', 'ms'].contains(unit)) {
      return isSameMillisecond(d);
    }
    return _date == d.$d;
  }

  ///  这指示Day对象是否在另一个提供的date-time之前。
  bool isBefore(DayDart d, [String? unit]) {
    if (['year', 'y'].contains(unit)) {
      return isBeforeYear(d);
    }
    if (['month', 'M'].contains(unit)) {
      return isBeforeMonth(d);
    }
    if (['day', 'D'].contains(unit)) {
      return isBeforeDay(d);
    }
    if (['hour', 'h'].contains(unit)) {
      return isBeforeHour(d);
    }
    if (['minute', 'm'].contains(unit)) {
      return isBeforeMinute(d);
    }
    if (['second', 's'].contains(unit)) {
      return isBeforeSecond(d);
    }
    if (['millisecond', 'ms'].contains(unit)) {
      return isBeforeMillisecond(d);
    }
    return _date.isBefore(d.$d);
  }

  ///  这指示Day对象是否在另一个提供的date-time之后。
  bool isAfter(DayDart d, [String? unit]) {
    if (['year', 'y'].contains(unit)) {
      return isAfterYear(d);
    }
    if (['month', 'M'].contains(unit)) {
      return isAfterMonth(d);
    }
    if (['day', 'D'].contains(unit)) {
      return isAfterDay(d);
    }
    if (['hour', 'h'].contains(unit)) {
      return isAfterHour(d);
    }
    if (['minute', 'm'].contains(unit)) {
      return isAfterMinute(d);
    }
    if (['second', 's'].contains(unit)) {
      return isAfterSecond(d);
    }
    if (['millisecond', 'ms'].contains(unit)) {
      return isAfterMillisecond(d);
    }
    return _date.isAfter(d.$d);
  }

  ///  相同或之前
  bool isSameOrBefore(DayDart d, [String? unit]) {
    return isSame(d, unit) || isBefore(d, unit);
  }

//  相同或之后
  bool isSameOrAfter(DayDart d, [String? unit]) {
    return isSame(d, unit) || isAfter(d, unit);
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
    return isSameOrBefore(d, 'y') && $M < d.$M;
  }

  bool isBeforeDay(DayDart d) {
    return isSameOrBefore(d, 'M') && $D < d.$D;
  }

  bool isBeforeHour(DayDart d) {
    return isSameOrBefore(d, 'D') && $h < d.$h;
  }

  bool isBeforeMinute(DayDart d) {
    return isSameOrBefore(d, 'h') && $m < d.$m;
  }

  bool isBeforeSecond(DayDart d) {
    return isSameOrBefore(d, 'm') && $s < d.$s;
  }

  bool isBeforeMillisecond(DayDart d) {
    return isSameOrBefore(d, 's') && $ms < d.$ms;
  }

  /// 之前 end

  /// 之后 start
  bool isAfterYear(DayDart d) {
    return $y > d.$y;
  }

  bool isAfterMonth(DayDart d) {
    return isSameOrAfter(d, 'y') && $M > d.$M;
  }

  bool isAfterDay(DayDart d) {
    return isSameOrAfter(d, 'M') && $D > d.$D;
  }

  bool isAfterHour(DayDart d) {
    return isSameOrAfter(d, 'D') && $h > d.$h;
  }

  bool isAfterMinute(DayDart d) {
    return isSameOrAfter(d, 'h') && $m > d.$m;
  }

  bool isAfterSecond(DayDart d) {
    return isSameOrAfter(d, 'm') && $s > d.$s;
  }

  bool isAfterMillisecond(DayDart d) {
    return isSameOrAfter(d, 's') && $ms > d.$ms;
  }

  /// 之后 end

  ///创建当前对象的一个克隆。
  DayDart clone() => DayDart(_date);

  ///  返回当前的 DateTime 对象
  DateTime toDate() => _date;

  /// 返回 ISO8601 格式的字符串
  String toISOString() => _date.toIso8601String();

  List<int> toArray() => [$y, $M, $D, $h, $m, $s, $ms];

  Map<String, int> toMap() => {
        'years': $y,
        'months': $M,
        'date': $D,
        'hours': $h,
        'minutes': $m,
        'seconds': $s,
        'milliseconds': $ms
      };

  @override
  String toString() {
    // TODO: implement toString
    return _date.toString();
  }
}
