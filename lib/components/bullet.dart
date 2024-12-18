import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:plants_vs_invaders/animation_state_types/bullet_animation_state_type.dart';
import 'package:plants_vs_invaders/animation_state_types/character_bar_colors.dart';
import 'package:plants_vs_invaders/animation_state_types/insect_animation_state_type.dart';
import 'package:plants_vs_invaders/animation_state_types/player_action_type.dart';
import 'package:plants_vs_invaders/animation_state_types/player_animation_state_type.dart';
import 'package:plants_vs_invaders/animation_state_types/player_direction.dart';
import 'package:plants_vs_invaders/components/character_bar.dart';
import 'package:plants_vs_invaders/components/collision_block.dart';
import 'package:plants_vs_invaders/components/end_game_block.dart';
import 'package:plants_vs_invaders/components/insect.dart';
import 'package:plants_vs_invaders/components/insects_types.dart';
import 'package:plants_vs_invaders/components/plant_defender_type.dart';
import 'package:plants_vs_invaders/components/sprite_frame.dart';
import 'package:plants_vs_invaders/components/utils.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class Bullet extends SpriteAnimationGroupComponent with HasGameRef<PlantsVsInvaders>, CollisionCallbacks {

  Bullet({
    required this.plantDefenderType,
    required this.damage,
    required this.moveSpeed,
    required position,
    // required size,
  }) : super(
    key: ComponentKey.unique(),
    position: position,
    size: Vector2(349, 197),
  );

  late final RectangleHitbox hitbox;

  final int damage;
  final PlantDefenderType plantDefenderType;
  final double animationStepTime = 1;

  late final SpriteAnimation idleAnimation;

  double horizontalMovement = 1;
  double moveSpeed = 150;
  Vector2 startingPosition = Vector2.zero();
  Vector2 velocity = Vector2.zero();

  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    startingPosition = Vector2(position.x, position.y);
    hitbox = RectangleHitbox(
      position: Vector2(145, 55),
      size: Vector2(60, 60),
    );
    add(hitbox);

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
    switch (plantDefenderType) {
      case PlantDefenderType.peas:
        idleAnimation = _spriteAnimation(PlantDefenderType.peas, 1);
        break;
      case PlantDefenderType.oats:
        idleAnimation = _spriteAnimation(PlantDefenderType.oats, 1);
        break;
      case PlantDefenderType.clover:
        idleAnimation = _spriteAnimation(PlantDefenderType.clover, 1);
        break;
      case PlantDefenderType.buckwheat:
        idleAnimation = _spriteAnimation(PlantDefenderType.buckwheat, 1);
        break;
    }

    animations = {
      BulletAnimationStateType.idle: idleAnimation,
    };

    current = BulletAnimationStateType.idle;
  }

  SpriteAnimation _spriteAnimation(PlantDefenderType plantDefenderType, int amount) {
    final spriteSheet = SpriteSheet.fromColumnsAndRows(
        image: game.images.fromCache('levels/bullets/${plantDefenderType.name}/${plantDefenderType.name}.png'),
        columns: amount,
        rows: 1);
    return spriteSheet.createAnimation(row: 0, stepTime: animationStepTime, from: 0, to: amount);

    // Некорректно работает на iOS.
    // return SpriteAnimation.fromFrameData(
    //   game.images.fromCache('levels/bullets/${plantDefenderType.name}/${plantDefenderType.name}.png'),
    //   SpriteAnimationData.sequenced(
    //     amount: amount,
    //     stepTime: animationStepTime,
    //     textureSize: Vector2(1920, 1080),
    //   ),
    // );
  }

  void _updateAnimationStateType() {
    BulletAnimationStateType animationStateType = BulletAnimationStateType.idle;
    current = animationStateType;
  }

  void _updateMovement(double dt) {
    velocity.x = horizontalMovement * moveSpeed;
    position.x += velocity.x * dt;

    if (position.x > game.gameWidth) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Insect) {
      other.hit(damage);
      position = Vector2(-5000, -5000);
      hitbox.collisionType = CollisionType.inactive;
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is CollisionBlock) {}
    super.onCollisionEnd(other);
  }
}
