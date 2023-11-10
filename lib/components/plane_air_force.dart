import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:plants_vs_invaders/animation_state_types/plane_animation_state_type.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class PlaneAirForce extends SpriteAnimationGroupComponent with HasGameRef<PlantsVsInvaders> {

  PlaneAirForce({
    required position,
    // required size,
  }) : super(
    position: position,
    size: Vector2(150, 80),
  );

  final double animationStepTime = 1;

  late final SpriteAnimation idleAnimation;

  double horizontalMovement = 1;
  double moveSpeed = 500;
  Vector2 startingPosition = Vector2.zero();
  Vector2 velocity = Vector2.zero();

  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    startingPosition = Vector2(position.x, position.y);
    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    accumulatedTime += dt;

    while (accumulatedTime >= fixedDeltaTime) {
      _updateMovement(fixedDeltaTime);
      _updateAnimationStateType();

      accumulatedTime -= fixedDeltaTime;
    }
    super.update(dt);
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('plane', 1);

    animations = {
      PlaneAnimationStateType.idle: idleAnimation,
    };

    current = PlaneAnimationStateType.idle;
  }

  SpriteAnimation _spriteAnimation(String name, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('levels/plane/$name.png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: animationStepTime,
        textureSize: Vector2(150, 80),
      ),
    );
  }

  void _updateAnimationStateType() {
    current = PlaneAnimationStateType.idle;
  }

  void _updateMovement(double dt) {
    velocity.x = horizontalMovement * moveSpeed;
    position.x += velocity.x * dt;

    if (position.x > game.camera.viewport.size.x) {
      removeFromParent();
    }
  }
}
