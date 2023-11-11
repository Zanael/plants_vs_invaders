import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:plants_vs_invaders/components/finish_flag.dart';

class VictoryTimerBar extends PositionComponent {
  double progress;
  final Color color;
  final Color backgroundColor;
  final Color borderColor;
  final double innerCornerRadius = 2;
  final double outerCornerRadius = 2;

  VictoryTimerBar({
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
    required position,
    required size,
    required this.progress,
  }) : super(
    position: position,
    size: size,
  );
  
  @override
  FutureOr<void> onLoad() {
    add(FinishFlag(position: Vector2(243, -24), size: Vector2(29, 43)));
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    final paintBack = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final paintBorder = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke;

    final paintFront = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    RRect rectBack = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.x, size.y),
      Radius.circular(outerCornerRadius),
    );

    RRect rectBorder = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.x, size.y),
      Radius.circular(outerCornerRadius),
    );

    RRect rectFront = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.x * progress, size.y),
      Radius.circular(innerCornerRadius),
    );

    canvas.drawRRect(rectBack, paintBack);
    canvas.drawRRect(rectBorder, paintBorder);
    canvas.drawRRect(rectFront, paintFront);
  }
}
