import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class EnergyResources extends SpriteComponent with HasGameRef<PlantsVsInvaders>, TapCallbacks {

  final VoidCallback callback;

  EnergyResources({
    required this.callback,
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
      position: Vector2(196, 88),
      size: Vector2(60, 60),
    ));
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    callback.call();
    super.onTapUp(event);
  }
}
