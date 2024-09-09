import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class SunResources extends SpriteComponent with HasGameRef<PlantsVsInvaders> {

  SunResources({
    required position,
    required size,
  }) : super(
    position: position,
    size: size,
  );

  @override
  FutureOr<void> onLoad() async {
    final image = await Flame.images.load("levels/resources/sun.png");
    sprite = Sprite(image);
    add(RectangleHitbox(
      position: Vector2(100, 45),
      size: Vector2(60, 60),
    ));
    return super.onLoad();
  }
}
