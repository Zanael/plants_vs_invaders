import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class EnergyCard extends SpriteComponent with HasGameRef<PlantsVsInvaders> {
  final int price;


  EnergyCard({
    required this.price,
    required position,
    required size,
  }) : super(
    position: position,
    size: size,
  );

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('levels/energy_cards/plane.png'));
    _addPrice();
    return super.onLoad();
  }

  void _addPrice() {
    final regular = TextPaint(
        style: const TextStyle(
          fontFamily: 'RubikBubbles',
          fontSize: 14,
          color: Color(0xFF726C60),
        ));

    final textComponent = TextComponent(
      text: price.toString(),
      textRenderer: regular,
      anchor: Anchor.topLeft,
      position: Vector2(35, 100),
    );

    add(textComponent);
  }
}
