import 'dart:async';

import 'package:flame/components.dart';
import 'package:plants_vs_invaders/animation_state_types/spell_type.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class Potion extends SpriteComponent with HasGameRef<PlantsVsInvaders> {

  final SpellType spellType;

  Potion({
    required this.spellType,
    required position,
    required size,
  }) : super(
    position: position,
    size: size,
  );

  @override
  FutureOr<void> onLoad() {
    sprite = _sprite(spellType, 32);

    return super.onLoad();
  }

  Sprite _sprite(SpellType spellType, int size) {
    switch (spellType) {
      case SpellType.circleBluePotion:
        return Sprite(game.images.fromCache('levels/potions/circle/circle_blue_potion_$size.png'));
      case SpellType.circleYellowPotion:
        return Sprite(game.images.fromCache('levels/potions/circle/circle_yellow_potion_$size.png'));
      case SpellType.circleRedPotion:
        return Sprite(game.images.fromCache('levels/potions/circle/circle_red_potion_$size.png'));
      case SpellType.rectBluePotion:
        return Sprite(game.images.fromCache('levels/potions/rect/rect_blue_potion_$size.png'));
      case SpellType.rectYellowPotion:
        return Sprite(game.images.fromCache('levels/potions/rect/rect_yellow_potion_$size.png'));
      case SpellType.rectRedPotion:
        return Sprite(game.images.fromCache('levels/potions/rect/rect_red_potion_$size.png'));
    }
  }
}
