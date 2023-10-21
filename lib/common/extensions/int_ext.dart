import 'package:intl/intl.dart';

extension StringExt on int {
  String get currencyFormatIdr => NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp ',
        decimalDigits: 0,
      ).format(this);
}
