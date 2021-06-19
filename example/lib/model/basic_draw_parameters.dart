import 'dart:ui';

class BasicDrawParameters {
  final Color color;
  final String text;
  final int size;
  final int left;
  final int right;
  final int top;
  final int bottom;

  const BasicDrawParameters(
    this.text,
    this.color,
    this.size,
    this.left,
    this.right,
    this.top,
    this.bottom,
  );
}