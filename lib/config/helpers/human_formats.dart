import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number) {
    final formatter = NumberFormat.compactCurrency(locale: 'en', decimalDigits: 0, symbol: '');
    final formatted = formatter.format(number); 

    return formatted;

  }
}