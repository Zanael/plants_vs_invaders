import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:plants_vs_invaders/animation_state_types/character_bar_colors.dart';
import 'package:plants_vs_invaders/animation_state_types/insect_animation_state_type.dart';
import 'package:plants_vs_invaders/animation_state_types/player_action_type.dart';
import 'package:plants_vs_invaders/animation_state_types/player_animation_state_type.dart';
import 'package:plants_vs_invaders/animation_state_types/player_direction.dart';
import 'package:plants_vs_invaders/components/character_bar.dart';
import 'package:plants_vs_invaders/components/collision_block.dart';
import 'package:plants_vs_invaders/components/end_game_block.dart';
import 'package:plants_vs_invaders/components/insects_types.dart';
import 'package:plants_vs_invaders/components/plant_defender.dart';
import 'package:plants_vs_invaders/components/sprite_frame.dart';
import 'package:plants_vs_invaders/components/utils.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class Insect extends SpriteAnimationGroupComponent with HasGameRef<PlantsVsInvaders>, CollisionCallbacks {
  VoidCallback? endGameCallback;

  Insect({
    required this.insectsType,
    required position,
    required size,
    this.endGameCallback,
  }) : super(
          position: position,
          size: size,
        );

  final int damage = 20;
  bool gotHit = false;
  bool attackPlant = false;
  final int totalHealth = 100;
  int health = 100;
  late CharacterBar characterBar;

  final InsectsTypes insectsType;
  final double animationStepTime = 0.1;

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runAnimation;
  late final SpriteAnimation attackAnimation;
  late final SpriteAnimation hitAnimation;

  double horizontalMovement = -1;
  double moveSpeed = 50;
  Vector2 startingPosition = Vector2.zero();
  Vector2 velocity = Vector2.zero();

  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;

  late TimerComponent attackTimer;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    _addCharacterBar();
    startingPosition = Vector2(position.x, position.y);
    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    accumulatedTime += dt;

    while (accumulatedTime >= fixedDeltaTime) {
      if (!gotHit) {
        _updateMovement(fixedDeltaTime);
        _updateAnimationStateType();
      }

      accumulatedTime -= fixedDeltaTime;
    }
    super.update(dt);
  }

  void _loadAllAnimations() {
    switch (insectsType) {
      case InsectsTypes.colorado_beetle:
        idleAnimation = _spriteAnimation(InsectsTypes.colorado_beetle, 'idle', 1);
        runAnimation = _spriteAnimation(InsectsTypes.colorado_beetle, 'run', 3);
        attackAnimation = _spriteAnimation(InsectsTypes.colorado_beetle, 'attack', 3);
        hitAnimation = _spriteAnimation(InsectsTypes.colorado_beetle, 'hit', 1);
        break;
      case InsectsTypes.mole:
        idleAnimation = _spriteAnimation(InsectsTypes.mole, 'idle', 1);
        runAnimation = _spriteAnimation(InsectsTypes.mole, 'run', 3);
        attackAnimation = _spriteAnimation(InsectsTypes.mole, 'attack', 3);
        hitAnimation = _spriteAnimation(InsectsTypes.mole, 'hit', 1);
        break;
      case InsectsTypes.mole_cricket:
        idleAnimation = _spriteAnimation(InsectsTypes.mole_cricket, 'idle', 1);
        runAnimation = _spriteAnimation(InsectsTypes.mole_cricket, 'run', 3);
        attackAnimation = _spriteAnimation(InsectsTypes.mole_cricket, 'attack', 3);
        hitAnimation = _spriteAnimation(InsectsTypes.mole_cricket, 'hit', 1);
        break;
      case InsectsTypes.slug:
        idleAnimation = _spriteAnimation(InsectsTypes.slug, 'idle', 1);
        runAnimation = _spriteAnimation(InsectsTypes.slug, 'run', 3);
        attackAnimation = _spriteAnimation(InsectsTypes.slug, 'attack', 3);
        hitAnimation = _spriteAnimation(InsectsTypes.slug, 'hit', 1);
        break;
    }

    animations = {
      InsectAnimationStateType.idle: idleAnimation,
      InsectAnimationStateType.run: runAnimation,
      InsectAnimationStateType.attack: attackAnimation,
      InsectAnimationStateType.hit: hitAnimation,
    };

    current = InsectAnimationStateType.idle;
  }

  SpriteAnimation _spriteAnimation(InsectsTypes insectsType, String action, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('levels/insects/${insectsType.name}/${insectsType.name}_$action.png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: animationStepTime,
        textureSize: Vector2(70, 80),
      ),
    );
  }

  void _updateAnimationStateType() {
    if (attackPlant) {
      current = InsectAnimationStateType.attack;
    } else {
      current = InsectAnimationStateType.run;
    }
  }

  void _updateMovement(double dt) {
    if (!attackPlant) {
      velocity.x = horizontalMovement * moveSpeed;
      position.x += velocity.x * dt;
    }
  }

  void _addCharacterBar() {
    characterBar = CharacterBar(
      color: CharacterBarColors.greenFront,
      backgroundColor: CharacterBarColors.greenBack,
      position: Vector2(0, -10),
      size: Vector2(size.x, 7),
      progress: health / totalHealth,
    );
    add(characterBar);
  }

  void _updateCharacterBar() {
    characterBar.removeFromParent();
    characterBar = CharacterBar(
      color: CharacterBarColors.greenFront,
      backgroundColor: CharacterBarColors.greenBack,
      position: Vector2(0, -10),
      size: Vector2(size.x, 7),
      progress: health / totalHealth,
    );
    add(characterBar);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is CollisionBlock) {}
    if (other is EndGameBlock) {
      endGameCallback?.call();
    }
    if (other is PlantDefender) {
      if (!attackPlant) {
        attackPlant = true;
        attackTimer = TimerComponent(period: 2, repeat: true, autoStart: true, onTick: () {
          other.hit(damage);
        });
        add(attackTimer);
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is CollisionBlock) {}
    if (other is PlantDefender) {
      attackPlant = false;
      attackTimer.removeFromParent();
    }
    super.onCollisionEnd(other);
  }

  void hit(int damage) {
    const hitDuration = Duration(milliseconds: 150);
    const canMoveDuration = Duration(milliseconds: 200);
    gotHit = true;
    current = InsectAnimationStateType.hit;
    health -= damage;
    if (health <= 0) removeFromParent();
    _updateCharacterBar();

    Future.delayed(hitDuration, () {
      velocity = Vector2.zero();
      _updateAnimationStateType();
      Future.delayed(canMoveDuration, () => gotHit = false);
    });
  }
}
