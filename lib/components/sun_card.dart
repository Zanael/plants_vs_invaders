import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:plants_vs_invaders/components/plants_defenders.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class SunCard extends SpriteComponent with HasGameRef<PlantsVsInvaders> {
  final PlantDefenderType plantDefenderType;
  final int price;


  SunCard({
    required this.plantDefenderType,
    required this.price,
    required position,
    required size,
  }) : super(
          position: position,
          size: size,
        );

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('levels/sun_cards/${plantDefenderType.name}.png'));
    _addPrice();
    return super.onLoad();
  }

  void _addPrice() {
    final regular = TextPaint(
        style: const TextStyle(
      fontFamily: 'RubikBubbles',
      fontSize: 14,
      color: Color(0xFFAC590D),
    ));

    final textComponent = TextComponent(
      text: price.toString(),
      textRenderer: regular,
      anchor: Anchor.topLeft,
      position: Vector2(42, 98),
    );

    add(textComponent);
  }
}
