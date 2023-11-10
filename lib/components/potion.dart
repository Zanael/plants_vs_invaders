import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class MenuButton extends SpriteComponent with HasGameRef<PlantsVsInvaders> {

  // SpellType spellType =

  MenuButton({
    required position,
    required size,
  }) : super(
    position: position,
    size: size,
  );

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('levels/menu/menu_button.png'));

    return super.onLoad();
  }
}
