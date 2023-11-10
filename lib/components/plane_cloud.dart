import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:plants_vs_invaders/animation_state_types/spell_type.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class PlaneCloud extends SpriteComponent with HasGameRef<PlantsVsInvaders> {

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
  );

  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;

  @override
  FutureOr<void> onLoad() async {
    sprite = Sprite(game.images.fromCache('levels/plane_cloud/plane_cloud.png'));
    add(RectangleHitbox());
    hideTimer = Timer(hideTimerSeconds);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    accumulatedTime += dt;

    while (accumulatedTime >= fixedDeltaTime) {
      hideTimer.update(fixedDeltaTime);
      if (hideTimer.finished) {
        removeFromParent();
      }

      accumulatedTime -= fixedDeltaTime;
    }

    super.update(dt);
  }
}
