import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class EnergyResources extends SpriteComponent with HasGameRef<PlantsVsInvaders> {

  EnergyResources({
    required position,
    required size,
  }) : super(
    position: position,
    size: size,
  );

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('levels/resources/energy.png'));
    add(RectangleHitbox(
      position: Vector2(110, 50),
      size: Vector2(40, 40),
    ));
    return super.onLoad();
  }
}
