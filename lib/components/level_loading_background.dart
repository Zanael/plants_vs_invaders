import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class LevelLoadingBackground extends SpriteAnimationComponent with HasGameRef<PlantsVsInvaders> {
// class LevelLoadingBackground extends SpriteComponent with HasGameRef<PlantsVsInvaders> {
  double animationStepTime = 0.1;

  LevelLoadingBackground() : super(
    position: Vector2(0, 0),
  );

  @override
  FutureOr<void> onLoad() async {
    size = gameRef.size;

    final image = await Flame.images.load("levels/level_loading_background/level_loading_background_idle.png");
    animation = SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: animationStepTime,
        textureSize: Vector2(1920, 1080),
      ),
    );

    return super.onLoad();
  }

  // @override
  // FutureOr<void> onLoad() async {
  //   size = gameRef.size;
  //
  //   final image = await Flame.images.load("levels/level_loading_background/level_loading_background_idle.png");
  //   sprite = Sprite(image);
  //
  //   return super.onLoad();
  // }

  @override
  void onGameResize(Vector2 size) {
    this.size = size;
    super.onGameResize(size);
  }
}
