import 'package:flutter/material.dart';

class Task {
  String category;
  DateTime date;
  TimeOfDay time;
  String title;
  String details;

  Task({
    required this.category,
    required this.date,
    required this.time,
    required this.title,
    required this.details,
  });
}
