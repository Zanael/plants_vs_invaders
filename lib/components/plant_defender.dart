import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:plants_vs_invaders/animation_state_types/bullet_damage.dart';
import 'package:plants_vs_invaders/animation_state_types/bullet_interval.dart';
import 'package:plants_vs_invaders/animation_state_types/bullet_speed.dart';
import 'package:plants_vs_invaders/animation_state_types/character_bar_colors.dart';
import 'package:plants_vs_invaders/animation_state_types/insect_animation_state_type.dart';
import 'package:plants_vs_invaders/animation_state_types/plant_animation_state_type.dart';
import 'package:plants_vs_invaders/animation_state_types/player_action_type.dart';
import 'package:plants_vs_invaders/animation_state_types/player_animation_state_type.dart';
import 'package:plants_vs_invaders/animation_state_types/player_direction.dart';
import 'package:plants_vs_invaders/animation_state_types/spell_type.dart';
import 'package:plants_vs_invaders/components/bullet.dart';
import 'package:plants_vs_invaders/components/character_bar.dart';
import 'package:plants_vs_invaders/components/collision_block.dart';
import 'package:plants_vs_invaders/components/end_game_block.dart';
import 'package:plants_vs_invaders/components/insects_types.dart';
import 'package:plants_vs_invaders/components/plane_cloud.dart';
import 'package:plants_vs_invaders/components/plant.dart';
import 'package:plants_vs_invaders/components/plant_defender_type.dart';
import 'package:plants_vs_invaders/components/potion.dart';
import 'package:plants_vs_invaders/level.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class PlantDefender extends Plant with HasGameRef<PlantsVsInvaders>, CollisionCallbacks {
  final Function(PlantDefender plantDefender, int rowOnBoard, int columnOnBoard) wasKilled;
  final Function(Bullet bullet) spawnBullet;

  PlantDefender({
    required this.plantDefenderType,
    required this.rowOnBoard,
    required this.columnOnBoard,
    required this.spawnBullet,
    required this.wasKilled,
    required position,
    required size,
  }) : super(
          isDefender: true,
          position: position,
          size: size,
        );

  late final RectangleHitbox hitbox;

  final PlantDefenderType plantDefenderType;
  final double animationStepTime = 0.5;

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation hitAnimation;

  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;

  Vector2 plantPosition = Vector2.zero();

  bool gotHit = false;
  double totalHealth = 100;
  double health = 100;
  double bulletSpeedCoefficient = 1;
  late CharacterBar characterBar;

  bool isInCloud = false;

  final int rowOnBoard;
  final int columnOnBoard;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    _addCharacterBar();
    hitbox = RectangleHitbox();
    add(hitbox);

    plantPosition.x = position.x;
    plantPosition.y = position.y;

    add(TimerComponent(
        period: BulletInterval.interval(plantDefenderType),
        repeat: true,
        autoStart: true,
        onTick: () {
          spawnBullet(Bullet(
            plantDefenderType: plantDefenderType,
            damage: BulletDamage.damage(plantDefenderType),
            moveSpeed: BulletSpeed.speed(plantDefenderType) * bulletSpeedCoefficient,
            position: Vector2(
              plantPosition.x + 45,
              plantPosition.y + 25,
            ),
          ));
        }));

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

      plantPosition.x = position.x;
      plantPosition.y = position.y;

      accumulatedTime -= fixedDeltaTime;
    }
    super.update(dt);
  }

  void _loadAllAnimations() {
    switch (plantDefenderType) {
      case PlantDefenderType.peas:
        idleAnimation = _spriteAnimation(PlantDefenderType.peas, 'idle', 3);
        hitAnimation = _spriteAnimation(PlantDefenderType.peas, 'hit', 1);
        break;
      case PlantDefenderType.oats:
        idleAnimation = _spriteAnimation(PlantDefenderType.oats, 'idle', 3);
        hitAnimation = _spriteAnimation(PlantDefenderType.oats, 'hit', 1);
        break;
      case PlantDefenderType.buckwheat:
        idleAnimation = _spriteAnimation(PlantDefenderType.buckwheat, 'idle', 3);
        hitAnimation = _spriteAnimation(PlantDefenderType.buckwheat, 'hit', 1);
        break;
      case PlantDefenderType.clover:
        idleAnimation = _spriteAnimation(PlantDefenderType.clover, 'idle', 3);
        hitAnimation = _spriteAnimation(PlantDefenderType.clover, 'hit', 1);
        break;
    }

    animations = {
      PlantAnimationStateType.idle: idleAnimation,
      PlantAnimationStateType.hit: hitAnimation,
    };

    current = PlantAnimationStateType.idle;
  }

  SpriteAnimation _spriteAnimation(PlantDefenderType plantDefenderType, String action, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('levels/plants/defenders/${plantDefenderType.name}/${plantDefenderType.name}_$action.png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: animationStepTime,
        textureSize: Vector2(70, 80),
      ),
    );
  }

  void _updateAnimationStateType() {
    current = PlantAnimationStateType.idle;
  }

  void _updateMovement(double dt) {
    // velocity.x = horizontalMovement * moveSpeed;
    // position.x += velocity.x * dt;
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
    if (other is PlaneCloud) {
      if (!isInCloud) {
        isInCloud = true;
        switch (other.spellType) {
          case SpellType.rectBluePotion:
            applyRectBluePotion(other.spellType);
            break;
          case SpellType.rectYellowPotion:
            applyRectYellowPotion(other.spellType);
            break;
          case SpellType.rectRedPotion:
            applyRectRedPotion(other.spellType);
            break;
          default:
            break;
        }
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is CollisionBlock) {}
    if (other is PlaneCloud) {
      isInCloud = false;
    }
    super.onCollisionEnd(other);
  }

  void hit(int damage) {
    const hitDuration = Duration(milliseconds: 150);
    const canMoveDuration = Duration(milliseconds: 200);
    gotHit = true;
    current = PlantAnimationStateType.hit;
    health -= damage;
    if (health <= 0) {
      gotHit = false;
      position = Vector2(-4000, -4000);
      hitbox.collisionType = CollisionType.inactive;
      removeFromParent();
      wasKilled(this, rowOnBoard, columnOnBoard);
    }
    _updateCharacterBar();

    Future.delayed(hitDuration, () {
      _updateAnimationStateType();
      Future.delayed(canMoveDuration, () => gotHit = false);
    });
  }

  void heal(int heal) {
    health += heal;
    if (health > totalHealth) health = 100;
    _updateCharacterBar();
  }

  void applyRectBluePotion(SpellType spellType) {
    bulletSpeedCoefficient = 1.5;
    _addPotionIcon(spellType);
  }

  void applyRectYellowPotion(SpellType spellType) {
    totalHealth += totalHealth * 0.2;
    health += health * 0.2;
    _updateCharacterBar();
    _addPotionIcon(spellType);
  }

  void applyRectRedPotion(SpellType spellType) {
    health = totalHealth;
    _updateCharacterBar();
    _addPotionIcon(spellType);
  }

  void _addPotionIcon(SpellType spellType) {
    add(Potion(
      spellType: spellType,
      position: Vector2(54, -16),
      size: Vector2.all(32),
    ));
  }
}
