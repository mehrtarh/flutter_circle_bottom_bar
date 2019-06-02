import 'package:flutter/material.dart';

class TabItem {
  final IconData icon;
  final Color normalColor;
  final Color selectedColor;
  final Color shadowColor;
  final bool showShadow;

  TabItem(this.icon,
      {this.normalColor = Colors.white,
      this.selectedColor = Colors.cyanAccent,
      this.shadowColor = Colors.cyanAccent,
      this.showShadow = true});
}
