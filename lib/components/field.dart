import 'dart:async';

import 'package:flame/components.dart';
import 'package:plants_vs_invaders/components/plants_base_type.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class Field extends SpriteComponent with HasGameRef<PlantsVsInvaders> {
  final PlantBaseType plantBaseType;

  Field({
    required this.plantBaseType,
    required position,
    required size,
  }) : super(
    position: position,
    size: size,
  );

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('levels/fields/${plantBaseType.name}.png'));

    return super.onLoad();
  }
}
