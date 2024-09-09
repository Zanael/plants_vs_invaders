import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:plants_vs_invaders/animation_state_types/plane_cloud_animation_state_type.dart';
import 'package:plants_vs_invaders/animation_state_types/spell_type.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class PlaneCloud extends SpriteAnimationGroupComponent with HasGameRef<PlantsVsInvaders> {

  VoidCallback onClose;
  SpellType spellType;

  late final Timer hideTimer;
  late final double hideTimerSeconds = 5;

  PlaneCloud({
    required position,
    required size,
    required this.spellType,
    required this.onClose,
  }) : super(
    position: position,
    size: size,
    priority: 999,
  );

  final double animationStepTime = 0.1;

  late final SpriteAnimation idleAnimation;

  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;

  @override
  FutureOr<void> onLoad() async {
    await _loadAllAnimations();
    add(RectangleHitbox(
      position: Vector2(55, 10),
      size: Vector2(150, 130),
    ));
    hideTimer = Timer(hideTimerSeconds);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    accumulatedTime += dt;

    while (accumulatedTime >= fixedDeltaTime) {
      _updateAnimationStateType();
      hideTimer.update(fixedDeltaTime);
      if (hideTimer.finished) {
        removeFromParent();
      }

      accumulatedTime -= fixedDeltaTime;
    }

    super.update(dt);
  }

  Future<void> _loadAllAnimations() async {
    idleAnimation = await _spriteAnimation('plane_cloud', 6);

    animations = {
      PlaneCloudAnimationStateType.idle: idleAnimation,
    };

    current = PlaneCloudAnimationStateType.idle;
  }

  Future<SpriteAnimation> _spriteAnimation(String name, int amount) async {
    final image = await Flame.images.load("levels/plane_cloud/$name.png");
    return SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: animationStepTime,
        textureSize: Vector2(960, 540),
        loop: false,
      ),
    );
  }

  void _updateAnimationStateType() {
    current = PlaneCloudAnimationStateType.idle;
  }
}
