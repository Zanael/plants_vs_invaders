import 'dart:ui';

import 'package:flame/components.dart';

class CharacterBar extends PositionComponent {
  double progress;
  final Color color;
  final Color backgroundColor;
  final double cornerRadius = 2;

  CharacterBar({
    required this.color,
    required this.backgroundColor,
    required position,
    required size,
    required this.progress,
  }) : super(
          position: position,
          size: size,
        );

  @override
  void render(Canvas canvas) {
    final paintBack = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final paintFront = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    RRect rectBack = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.x, size.y),
      Radius.circular(cornerRadius),
    );

    RRect rectFront = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.x * progress, size.y),
      Radius.circular(cornerRadius),
    );

    canvas.drawRRect(rectBack, paintBack);
    canvas.drawRRect(rectFront, paintFront);
  }
}
