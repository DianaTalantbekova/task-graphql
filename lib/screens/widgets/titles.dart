import 'package:flutter/material.dart';
import 'package:test_task2/commons/text_helper.dart';
import 'package:test_task2/commons/theme_helper.dart';

class Titles extends StatelessWidget {
  final String title;
  const Titles({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextHelper.fontSize12w400.copyWith(color: ThemeHelper.grey),
    );
  }
}