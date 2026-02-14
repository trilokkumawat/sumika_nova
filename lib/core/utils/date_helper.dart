import 'package:intl/intl.dart';

class DateHelper {
  String formatFullDate({DateTime? date}) {
    final now = DateTime.now();
    return DateFormat('EEEE, dd MMMM').format(date ?? now);
  }

  num tempratureFormat(double? value) {
    if (value == null) {
      return 0;
    }
    return value.round();
  }
}
