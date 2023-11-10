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
      position: Vector2(28, 16),
      size: Vector2(27, 27),
      callback: () => onClose(),
    ));

    // Инсектициды

    // Замедляющий
    add(TappableRegion(
      position: Vector2(63, 127),
      size: Vector2(232, 64),
      callback: () => onCircleBluePotion(),
    ));

    // Ослабляющий
    add(TappableRegion(
      position: Vector2(63, 236),
      size: Vector2(227, 64),
      callback: () => onCircleYellowPotion(),
    ));

    // Убивающий
    add(TappableRegion(
      position: Vector2(63, 334),
      size: Vector2(203, 64),
      callback: () => onCircleRedPotion(),
    ));

    // Удобрения

    // Ускоряющее атаку
    add(TappableRegion(
      position: Vector2(369, 127),
      size: Vector2(208, 64),
      callback: () => onRectBluePotion(),
    ));

    // Защищающее
    add(TappableRegion(
      position: Vector2(369, 263),
      size: Vector2(221, 64),
      callback: () => onRectYellowPotion(),
    ));

    // Лечащее
    add(TappableRegion(
      position: Vector2(369, 342),
      size: Vector2(170, 64),
      callback: () => onRectRedPotion(),
    ));

    return super.onLoad();
  }
}
