import 'package:intl/intl.dart';

String formatDate(DateTime  date){
  String formattedDate = DateFormat('d MMMM').format(date);
  return formattedDate;
}