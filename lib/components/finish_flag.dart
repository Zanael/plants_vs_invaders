import 'dart:async';

import 'package:flame/components.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class FinishFlag extends SpriteComponent with HasGameRef<PlantsVsInvaders> {

  FinishFlag({
    required position,
    required size,
  }) : super(
    position: position,
    size: size,
  );

  @override
  FutureOr<void> onLoad() async {
    sprite = Sprite(game.images.fromCache('levels/flags/red.png'));

    return super.onLoad();
  }
}
