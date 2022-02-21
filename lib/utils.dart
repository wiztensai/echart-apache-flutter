import 'package:intl/intl.dart';

class Formater {

  static final _format1 = new NumberFormat("#,###", "en_US");

  static String currencyFormat(int price) {
    var format = _format1.format(price);
    return "Rp $format";
  }

  static String thousandFormat(String num) {
    var format = _format1.format(int.parse(num));
    return "$format";
  }

  static String dateFormat(String date) {
    final f = new DateFormat('yyyy-MM-dd');
    final parse = f.parse(date);

    final f2 = new DateFormat('dd MMMM yyyy');
    return f2.format(parse);
  }
}