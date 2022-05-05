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

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      dateTime: DateTime.parse(json['datetime']),
      length: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'datetime': dateTime.toIso8601String(),
      'size': length,
    };
  }

  String getFormattedDate() {
    return DateFormat('dd/MM/yyyy - HH:mm').format(dateTime);
  }
}
