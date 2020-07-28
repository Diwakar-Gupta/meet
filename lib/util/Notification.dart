import 'package:flutter/material.dart';

class ChangeTheme extends Notification {
  final ThemeData theme;
  ChangeTheme(this.theme);
}
