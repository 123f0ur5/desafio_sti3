import 'package:intl/intl.dart';

String dateTimeToDate(String data) {
  return DateFormat('dd/MM/yyyy').format(DateTime.parse(data));
}

String dateTimeToTime(String data) {
  return DateFormat('HH:mm').format(DateTime.parse(data));
}

String dateTimeFormatada(String data) {
  return DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(data));
}
