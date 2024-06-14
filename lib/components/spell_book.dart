import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:plants_vs_invaders/components/tappable_region.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class SpellBook extends SpriteComponent with HasGameRef<PlantsVsInvaders> {

  VoidCallback onCircleBluePotion;
  VoidCallback onCircleYellowPotion;
  VoidCallback onCircleRedPotion;

  VoidCallback onRectBluePotion;
  VoidCallback onRectYellowPotion;
  VoidCallback onRectRedPotion;

  VoidCallback onClose;

  SpellBook({
    required position,
    required this.onCircleBluePotion,
    required this.onCircleYellowPotion,
    required this.onCircleRedPotion,
    required this.onRectBluePotion,
    required this.onRectYellowPotion,
    required this.onRectRedPotion,
    required this.onClose,
  }) : super(
          position: position,
        );

  @override
  FutureOr<void> onLoad() async {
    priority = 10000;
    sprite = Sprite(game.images.fromCache('levels/spell_book/spell_book.png'));

    // Закрыть
    add(TappableRegion(
      position: Vector2(480, 180),
      size: Vector2(27, 27),
      callback: () => onClose(),
    ));

    // Инсектициды

    // Замедляющий
    add(TappableRegion(
      position: Vector2(500, 300),
      size: Vector2(400, 120),
      callback: () => onCircleBluePotion(),
    ));

    // Ослабляющий
    add(TappableRegion(
      position: Vector2(500, 470),
      size: Vector2(400, 120),
      callback: () => onCircleYellowPotion(),
    ));

    // Убивающий
    add(TappableRegion(
      position: Vector2(500, 650),
      size: Vector2(400, 110),
      callback: () => onCircleRedPotion(),
    ));

    // Удобрения

    // Ускоряющее атаку
    add(TappableRegion(
      position: Vector2(1000, 300),
      size: Vector2(400, 140),
      callback: () => onRectBluePotion(),
    ));

    // Защищающее
    add(TappableRegion(
      position: Vector2(1000, 470),
      size: Vector2(400, 110),
      callback: () => onRectYellowPotion(),
    ));

    // Лечащее
    add(TappableRegion(
      position: Vector2(1000, 650),
      size: Vector2(400, 110),
      callback: () => onRectRedPotion(),
    ));

    return super.onLoad();
  }
}
