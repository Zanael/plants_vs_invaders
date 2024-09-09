import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class SunGenerator extends SpriteAnimationComponent with HasGameRef<PlantsVsInvaders> {
  double animationStepTime = 1;

  SunGenerator({
    required position,
    required size,
  }) : super(
    position: position,
    size: size,
  );

  @override
  FutureOr<void> onLoad() async {
    final image = await Flame.images.load("levels/sun_generator/sun_generator_idle.png");
    animation = SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: animationStepTime,
        textureSize: Vector2(960, 540),
      ),
    );
    return super.onLoad();
  }
}
