import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:plants_vs_invaders/animation_state_types/character_bar_colors.dart';
import 'package:plants_vs_invaders/animation_state_types/player_action_type.dart';
import 'package:plants_vs_invaders/animation_state_types/player_animation_state_type.dart';
import 'package:plants_vs_invaders/animation_state_types/player_direction.dart';
import 'package:plants_vs_invaders/components/character_bar.dart';
import 'package:plants_vs_invaders/components/collision_block.dart';
import 'package:plants_vs_invaders/components/energy_resources.dart';
import 'package:plants_vs_invaders/components/insect.dart';
import 'package:plants_vs_invaders/components/plant_defender.dart';
import 'package:plants_vs_invaders/components/plant_weed.dart';
import 'package:plants_vs_invaders/components/sun_resources.dart';
import 'package:plants_vs_invaders/level.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PlantsVsInvaders>, KeyboardHandler, CollisionCallbacks {
  late final Level level;

  Player({
    required this.level,
    required position,
  }) : super(
          position: position,
          size: Vector2(433, 245),
        );

  final double animationStepTime = 0.07;

  late final SpriteAnimation idleLeftAnimation;
  late final SpriteAnimation idleUpAnimation;
  late final SpriteAnimation idleRightAnimation;
  late final SpriteAnimation idleDownAnimation;

  late final SpriteAnimation runLeftAnimation;
  late final SpriteAnimation runUpAnimation;
  late final SpriteAnimation runRightAnimation;
  late final SpriteAnimation runDownAnimation;

  late final SpriteAnimation healLeftAnimation;
  late final SpriteAnimation healUpAnimation;
  late final SpriteAnimation healRightAnimation;
  late final SpriteAnimation healDownAnimation;

  late final SpriteAnimation attackInsetsLeftAnimation;
  late final SpriteAnimation attackInsetsUpAnimation;
  late final SpriteAnimation attackInsetsRightAnimation;
  late final SpriteAnimation attackInsetsDownAnimation;

  late final SpriteAnimation attackPlantsLeftAnimation;
  late final SpriteAnimation attackPlantsUpAnimation;
  late final SpriteAnimation attackPlantsRightAnimation;
  late final SpriteAnimation attackPlantsDownAnimation;

  PlayerDirection playerDirection = PlayerDirection.right;
  PlayerActionType playerActionType = PlayerActionType.none;

  double horizontalMovement = 0;
  double verticalMovement = 0;
  double moveSpeed = 110;
  Vector2 startingPosition = Vector2.zero();
  Vector2 velocity = Vector2.zero();

  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;

  List<CollisionBlock> collisionBlocks = [];

  bool isLeftKeyPressed = false;
  bool isUpKeyPressed = false;
  bool isRightKeyPressed = false;
  bool isDownKeyPressed = false;
  bool isSpaceKeyPressed = false;

  bool isCollide = false;
  PlayerDirection collideDirection = PlayerDirection.right;

  final int damageCount = 10;
  final int healCount = 20;

  PlantWeed? targetWeedPlant;
  PlantDefender? targetDefenderPlant;
  Insect? targetInsect;

  @override
  FutureOr<void> onLoad() {
    priority = 1000;
    _loadAllAnimations();
    // _addCharacterBar();
    startingPosition = Vector2(position.x, position.y);
    _addHitBox();

    return super.onLoad();
  }

  late final RectangleHitbox hitbox;

  @override
  void update(double dt) {
    accumulatedTime += dt;

    while (accumulatedTime >= fixedDeltaTime) {
      _updatePlayerMovement(fixedDeltaTime);
      _updatePlayerAnimationStateType();

      accumulatedTime -= fixedDeltaTime;
    }
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;
    verticalMovement = 0;
    isLeftKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyA) || keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    isUpKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyW) || keysPressed.contains(LogicalKeyboardKey.arrowUp);
    isRightKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyD) || keysPressed.contains(LogicalKeyboardKey.arrowRight);
    isDownKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyS) || keysPressed.contains(LogicalKeyboardKey.arrowDown);

    if (isLeftKeyPressed) playerDirection = PlayerDirection.left;
    if (isUpKeyPressed) playerDirection = PlayerDirection.up;
    if (isRightKeyPressed) playerDirection = PlayerDirection.right;
    if (isDownKeyPressed) playerDirection = PlayerDirection.down;

    isSpaceKeyPressed = keysPressed.contains(LogicalKeyboardKey.space);

    if (isSpaceKeyPressed) {
      targetWeedPlant?.hit(damageCount);
      targetInsect?.hit(damageCount);
      targetDefenderPlant?.heal(healCount);
    }

    horizontalMovement += isLeftKeyPressed ? -1 : 0;
    horizontalMovement += isRightKeyPressed ? 1 : 0;
    verticalMovement += isUpKeyPressed ? -1 : 0;
    verticalMovement += isDownKeyPressed ? 1 : 0;

    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAllAnimations() {
    idleLeftAnimation = _spriteAnimation('idle', 'left', 1);
    idleUpAnimation = _spriteAnimation('idle', 'up', 1);
    idleRightAnimation = _spriteAnimation('idle', 'right', 1);
    idleDownAnimation = _spriteAnimation('idle', 'down', 1);

    runLeftAnimation = _spriteAnimation('run', 'left', 13);
    runUpAnimation = _spriteAnimation('run', 'up', 14);
    runRightAnimation = _spriteAnimation('run', 'right', 14);
    runDownAnimation = _spriteAnimation('run', 'down', 14);

    healLeftAnimation = _spriteAnimation('heal', 'left', 17);
    healUpAnimation = _spriteAnimation('heal', 'up', 17);
    healRightAnimation = _spriteAnimation('heal', 'right', 17);
    healDownAnimation = _spriteAnimation('heal', 'down', 17);

    attackInsetsLeftAnimation = _spriteAnimation('attack/insects', 'left', 10);
    attackInsetsUpAnimation = _spriteAnimation('attack/insects', 'up', 11);
    attackInsetsRightAnimation = _spriteAnimation('attack/insects', 'right', 11);
    attackInsetsDownAnimation = _spriteAnimation('attack/insects', 'down', 11);

    attackPlantsLeftAnimation = _spriteAnimation('attack/plants', 'left', 10);
    attackPlantsUpAnimation = _spriteAnimation('attack/plants', 'up', 11);
    attackPlantsRightAnimation = _spriteAnimation('attack/plants', 'right', 11);
    attackPlantsDownAnimation = _spriteAnimation('attack/plants', 'down', 11);

    animations = {
      PlayerAnimationStateType.idleLeft: idleLeftAnimation,
      PlayerAnimationStateType.idleUp: idleUpAnimation,
      PlayerAnimationStateType.idleRight: idleRightAnimation,
      PlayerAnimationStateType.idleDown: idleDownAnimation,
      PlayerAnimationStateType.runLeft: runLeftAnimation,
      PlayerAnimationStateType.runUp: runUpAnimation,
      PlayerAnimationStateType.runRight: runRightAnimation,
      PlayerAnimationStateType.runDown: runDownAnimation,
      PlayerAnimationStateType.healLeft: healLeftAnimation,
      PlayerAnimationStateType.healUp: healUpAnimation,
      PlayerAnimationStateType.healRight: healRightAnimation,
      PlayerAnimationStateType.healDown: healDownAnimation,
      PlayerAnimationStateType.attackInsectsLeft: attackInsetsLeftAnimation,
      PlayerAnimationStateType.attackInsectsUp: attackInsetsUpAnimation,
      PlayerAnimationStateType.attackInsectsRight: attackInsetsRightAnimation,
      PlayerAnimationStateType.attackInsectsDown: attackInsetsDownAnimation,
      PlayerAnimationStateType.attackPlantsLeft: attackPlantsLeftAnimation,
      PlayerAnimationStateType.attackPlantsUp: attackPlantsUpAnimation,
      PlayerAnimationStateType.attackPlantsRight: attackPlantsRightAnimation,
      PlayerAnimationStateType.attackPlantsDown: attackPlantsDownAnimation,
    };

    current = PlayerAnimationStateType.idleRight;
  }

  SpriteAnimation _spriteAnimation(String actionPath, String direction, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('levels/player/$actionPath/player_${actionPath.replaceAll('/', '_')}_$direction.png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: animationStepTime,
        textureSize: Vector2(960, 540),
      ),
    );
  }

  void _addHitBox() {
    hitbox = RectangleHitbox(
      position: Vector2(150, 95),
      size: Vector2(125, 130),
    );
    add(hitbox);
  }

  void _updatePlayerAnimationStateType() {
    PlayerAnimationStateType playerStateType = PlayerAnimationStateType.idleRight;

    if (velocity.x < 0) playerStateType = PlayerAnimationStateType.runLeft;
    if (velocity.x > 0) playerStateType = PlayerAnimationStateType.runRight;

    if (velocity.y > 0) playerStateType = PlayerAnimationStateType.runDown;
    if (velocity.y < 0) playerStateType = PlayerAnimationStateType.runUp;

    if (velocity.x == 0 && velocity.y == 0) {
      switch (playerDirection) {
        case PlayerDirection.left:
          playerStateType = PlayerAnimationStateType.idleLeft;
          break;
        case PlayerDirection.up:
          playerStateType = PlayerAnimationStateType.idleUp;
          break;
        case PlayerDirection.right:
          playerStateType = PlayerAnimationStateType.idleRight;
          break;
        case PlayerDirection.down:
          playerStateType = PlayerAnimationStateType.idleDown;
          break;
        default:
          break;
      }
    }

    if (isSpaceKeyPressed) {
      switch (playerDirection) {
        case PlayerDirection.left:
          switch (playerActionType) {
            case PlayerActionType.heal:
              playerStateType = PlayerAnimationStateType.healLeft;
              break;
            case PlayerActionType.attackInsects:
              playerStateType = PlayerAnimationStateType.attackInsectsLeft;
              break;
            case PlayerActionType.attackPlants:
              playerStateType = PlayerAnimationStateType.attackPlantsLeft;
              break;
            case PlayerActionType.none:
              playerStateType = PlayerAnimationStateType.idleLeft;
            default:
              break;
          }
          break;
        case PlayerDirection.up:
          switch (playerActionType) {
            case PlayerActionType.heal:
              playerStateType = PlayerAnimationStateType.healUp;
              break;
            case PlayerActionType.attackInsects:
              playerStateType = PlayerAnimationStateType.attackInsectsUp;
              break;
            case PlayerActionType.attackPlants:
              playerStateType = PlayerAnimationStateType.attackPlantsUp;
              break;
            case PlayerActionType.none:
              playerStateType = PlayerAnimationStateType.idleUp;
            default:
              break;
          }
          break;
        case PlayerDirection.right:
          switch (playerActionType) {
            case PlayerActionType.heal:
              playerStateType = PlayerAnimationStateType.healRight;
              break;
            case PlayerActionType.attackInsects:
              playerStateType = PlayerAnimationStateType.attackInsectsRight;
              break;
            case PlayerActionType.attackPlants:
              playerStateType = PlayerAnimationStateType.attackPlantsRight;
              break;
            case PlayerActionType.none:
              playerStateType = PlayerAnimationStateType.idleRight;
            default:
              break;
          }
          break;
        case PlayerDirection.down:
          switch (playerActionType) {
            case PlayerActionType.heal:
              playerStateType = PlayerAnimationStateType.healDown;
              break;
            case PlayerActionType.attackInsects:
              playerStateType = PlayerAnimationStateType.attackInsectsDown;
              break;
            case PlayerActionType.attackPlants:
              playerStateType = PlayerAnimationStateType.attackPlantsDown;
              break;
            case PlayerActionType.none:
              playerStateType = PlayerAnimationStateType.idleDown;
            default:
              break;
          }
          break;
        default:
          break;
      }
    }

    current = playerStateType;
  }

  void _updatePlayerMovement(double dt) {
    if (!isSpaceKeyPressed) {
      velocity.x = horizontalMovement * moveSpeed;
      position.x += velocity.x * dt;

      velocity.y = verticalMovement * moveSpeed;
      position.y += velocity.y * dt;
    }
  }

  void _addCharacterBar() {
    final characterBar = CharacterBar(
      color: CharacterBarColors.orangeFront,
      backgroundColor: CharacterBarColors.orangeBack,
      position: Vector2(0, -10),
      size: Vector2(size.x, 7),
      progress: 0.6,
    );
    add(characterBar);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is CollisionBlock) {}
    if (other is PlantWeed) {
      playerActionType = PlayerActionType.attackPlants;
      targetWeedPlant = other;
    }
    if (other is PlantDefender) {
      playerActionType = PlayerActionType.heal;
      targetDefenderPlant = other;
    }
    if (other is Insect) {
      playerActionType = PlayerActionType.attackInsects;
       targetInsect = other;
     }
    if (other is SunResources) {
      other.removeFromParent();
      level.collectSunResources(50);
    }
    if (other is EnergyResources) {
      other.removeFromParent();
      level.collectEnergyResources(50);
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is PlantWeed) {
      playerActionType = PlayerActionType.none;
      targetWeedPlant = null;
    }
    if (other is PlantWeed) {
      playerActionType = PlayerActionType.none;
      targetDefenderPlant = null;
    }
    if (other is Insect) {
      playerActionType = PlayerActionType.none;
      targetInsect = null;
    }
    super.onCollisionEnd(other);
  }
}
