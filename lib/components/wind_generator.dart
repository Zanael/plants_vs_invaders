import 'dart:async';

import 'package:flame/components.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class WindGenerator extends SpriteAnimationComponent with HasGameRef<PlantsVsInvaders> {
  double animationStepTime = 0.1;

  WindGenerator({
    required position,
    required size,
  }) : super(
    position: position,
    size: size,
  );

  @override
  FutureOr<void> onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('levels/wind_generator/wind_generator_idle.png'),
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: animationStepTime,
        textureSize: Vector2(70, 80),
      ),
    );
    return super.onLoad();
  }
}
