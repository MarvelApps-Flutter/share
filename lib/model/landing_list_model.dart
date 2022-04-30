import 'package:flutter/material.dart';

class ChooseListModel
{
  final Color? colors;
  final String? text;

  ChooseListModel({this.colors, this.text});

}

List<ChooseListModel> chooseList = [
  ChooseListModel(
      colors: Colors.blueAccent.shade700,
      text: "Share Text"),
  ChooseListModel(
      colors: Colors.blueAccent.shade700,
      text: "Share Image"),
  ChooseListModel(
      colors: Colors.blueAccent.shade700,
      text: "Share Image with Text"),

];
