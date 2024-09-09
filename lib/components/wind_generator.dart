import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
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
  FutureOr<void> onLoad() async {
    final image = await Flame.images.load("levels/wind_generator/wind_generator_idle.png");
    animation = SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: animationStepTime,
        textureSize: Vector2(960, 540),
      ),
    );
    return super.onLoad();
  }
}
