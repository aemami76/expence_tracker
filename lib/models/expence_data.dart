import 'package:flutter/material.dart';

enum Category {
  hobby,
  food,
  travel,
  work,
}

const categoryIcon = {
  Category.food: Icon(Icons.fastfood),
  Category.travel: Icon(Icons.flight),
  Category.hobby: Icon(Icons.games_outlined),
  Category.work: Icon(Icons.work),
};

class ExpenceData {
  String title;
  double amount;
  DateTime dateTime;
  Category category;

  ExpenceData(
      {required this.title,
      required this.amount,
      required this.dateTime,
      required this.category});
}
