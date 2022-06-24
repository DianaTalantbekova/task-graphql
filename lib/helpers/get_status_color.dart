

import 'package:test_task2/commons/theme_helper.dart';

getStatusColor(String status) {
  switch (status) {
    case 'Alive':
      return ThemeHelper.green;

    case 'Dead':
      return ThemeHelper.red;

    default:
      return ThemeHelper.black;
  }
}