import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/text.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class EnergyCard extends SpriteComponent with HasGameRef<PlantsVsInvaders>, TapCallbacks {
  Function(int price) callback;
  final int price;

  EnergyCard({
    required this.price,
    required position,
    required size,
    required this.callback,
  }) : super(
    position: position,
    size: size,
  );

  @override
  FutureOr<void> onLoad() async {
    final image = await Flame.images.load("levels/energy_cards/plane.png");
    sprite = Sprite(image);
    _addPrice();
    return super.onLoad();
  }

  void _addPrice() {
    final regular = TextPaint(
        style: const TextStyle(
          fontFamily: 'RubikBubbles',
          fontSize: 20,
          color: Color(0xFF726C60),
        ));

    final textComponent = TextComponent(
      text: price.toString(),
      textRenderer: regular,
      anchor: Anchor.topLeft,
      position: Vector2(80, 180),
    );

    add(textComponent);
  }

  @override
  void onTapUp(TapUpEvent event) {
    callback.call(price);
    super.onTapUp(event);
  }
}
