library daydart;

import 'package:intl/intl.dart';

enum Units { y, M, D, w, h, m, s, ms }

class DayUnits {
  static List<String> year = ['years', 'year', 'y'];
  static List<String> month = ['months', 'month', 'M'];
  static List<String> day = ['days', 'day', 'D'];
  static List<String> hour = ['hours', 'hour', 'h'];
  static List<String> minute = ['minutes', 'minute', 'm'];
  static List<String> second = ['seconds', 'second', 's'];
  static List<String> millisecond = ['milliseconds', 'millisecond', 'ms'];
}

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
    String _unit = unit.toLowerCase();
    if (DayUnits.year.contains(_unit)) {
      year($y + num);
    }
    if (DayUnits.month.contains(_unit)) {
      month($M + num);
    }

    if (DayUnits.day.contains(_unit)) {
      day($D + num);
    }
    if (DayUnits.hour.contains(_unit)) {
      hour($h + num);
    }
    if (DayUnits.minute.contains(_unit)) {
      minute($m + num);
    }
    if (DayUnits.second.contains(_unit)) {
      second($s + num);
    }
    if (DayUnits.millisecond.contains(_unit)) {
      millisecond($ms + num);
    }
    return clone();
  }

  ///  返回DayDart对象，并减去指定的时间。
  DayDart subtract(int num, String unit) {
    String _unit = unit.toLowerCase();

    if (DayUnits.year.contains(_unit)) {
      year($y - num);
    }
    if (DayUnits.month.contains(_unit)) {
      month($M - num);
    }

    if (DayUnits.day.contains(_unit)) {
      day($D - num);
    }
    if (DayUnits.hour.contains(_unit)) {
      hour($h - num);
    }
    if (DayUnits.minute.contains(_unit)) {
      minute($m - num);
    }
    if (DayUnits.second.contains(_unit)) {
      second($s - num);
    }
    if (DayUnits.millisecond.contains(_unit)) {
      millisecond($ms - num);
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
  bool isValid() => _date is DateTime;

  static bool isDayDart(Object d) => d is DayDart;

  /// 是否闰年
  bool isLeapYear() {
    return (($y % 4 == 0) && ($y % 100 != 0)) || ($y % 400 == 0);
  }

  /// 这指示Day对象是否与另一个提供的date-time相同。
  bool isSame(Object date, [String unit = 'ms']) {
    DayDart d = DayDart(date);
    String _unit = unit.toLowerCase();

    if (DayUnits.year.contains(_unit)) {
      return isSameYear(d);
    }
    if (DayUnits.month.contains(_unit)) {
      return isSameMonth(d);
    }
    if (DayUnits.day.contains(_unit)) {
      return isSameDay(d);
    }
    if (DayUnits.hour.contains(_unit)) {
      return isSameHour(d);
    }
    if (DayUnits.minute.contains(_unit)) {
      return isSameMinute(d);
    }
    if (DayUnits.second.contains(_unit)) {
      return isSameSecond(d);
    }
    if (DayUnits.millisecond.contains(_unit)) {
      return isSameMillisecond(d);
    }
    return _date == d.$d;
  }

  ///  这指示Day对象是否在另一个提供的date-time之前。
  bool isBefore(Object date, [String unit = 'ms']) {
    DayDart d = DayDart(date);
    String _unit = unit.toLowerCase();

    if (DayUnits.year.contains(_unit)) {
      return isBeforeYear(d);
    }
    if (DayUnits.month.contains(_unit)) {
      return isBeforeMonth(d);
    }
    if (DayUnits.day.contains(_unit)) {
      return isBeforeDay(d);
    }
    if (DayUnits.hour.contains(_unit)) {
      return isBeforeHour(d);
    }
    if (DayUnits.minute.contains(_unit)) {
      return isBeforeMinute(d);
    }
    if (DayUnits.second.contains(_unit)) {
      return isBeforeSecond(d);
    }
    if (DayUnits.millisecond.contains(_unit)) {
      return isBeforeMillisecond(d);
    }
    return _date.isBefore(d.$d);
  }

  ///  这指示Day对象是否在另一个提供的date-time之后。
  bool isAfter(Object date, [String unit = 'ms']) {
    DayDart d = DayDart(date);
    String _unit = unit.toLowerCase();

    if (DayUnits.year.contains(_unit)) {
      return isAfterYear(d);
    }
    if (DayUnits.month.contains(_unit)) {
      return isAfterMonth(d);
    }
    if (DayUnits.day.contains(_unit)) {
      return isAfterDay(d);
    }
    if (DayUnits.hour.contains(_unit)) {
      return isAfterHour(d);
    }
    if (DayUnits.minute.contains(_unit)) {
      return isAfterMinute(d);
    }
    if (DayUnits.second.contains(_unit)) {
      return isAfterSecond(d);
    }
    if (DayUnits.millisecond.contains(_unit)) {
      return isAfterMillisecond(d);
    }
    return _date.isAfter(d.$d);
  }

  ///  相同或之前
  bool isSameOrBefore(Object d, [String unit = 'ms']) {
    return isSame(d, unit) || isBefore(d, unit);
  }

  ///  相同或之后
  bool isSameOrAfter(Object d, [String unit = 'ms']) {
    return isSame(d, unit) || isAfter(d, unit);
  }

  ///之间
  bool isBetween(Object start, Object end, [String unit = 'ms']) {
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

  /// 转List
  List<int> toList() => [$y, $M, $D, $h, $m, $s, $ms];

  /// 转Map
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
