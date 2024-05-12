import 'package:intl/intl.dart';

extension IntExtensions on int {
  String get formatCount {
    if (this >= 1000000) {
      return NumberFormat.compact().format(this);
    } else if (this >= 1000) {
      return NumberFormat.compact().format(this);
    } else {
      return NumberFormat("#,###").format(this);
    }
  }
}
