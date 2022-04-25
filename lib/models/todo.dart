import 'package:intl/intl.dart';

class Todo {
  Todo({
    required this.title,
    required this.dateTime,
    required this.length,
  });

  late String title;
  late DateTime dateTime;
  late String formatDate;
  late int length = 0;

  String getFormattedDate() {
    return DateFormat('dd/MM/yyyy - HH:mm').format(dateTime);
  }
}
