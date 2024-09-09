import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
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
  FutureOr<void> onLoad() async {
    final image = await Flame.images.load("levels/resources/energy.png");
    sprite = Sprite(image);
    add(RectangleHitbox(
      position: Vector2(196, 88),
      size: Vector2(60, 60),
    ));
    return super.onLoad();
  }
}
