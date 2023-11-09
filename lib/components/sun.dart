import 'dart:async';

import 'package:flame/components.dart';
import 'package:plants_vs_invaders/components/sun_type.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class Sun extends SpriteComponent with HasGameRef<PlantsVsInvaders> {
  SunType sunType;

  Sun({
    this.sunType = SunType.clean,
    required position,
    required size,
  }) : super(
          position: position,
          size: size,
        );

  @override
  FutureOr<void> onLoad() {
    _updateSunType(sunType: sunType);

    return super.onLoad();
  }

  void _updateSunType({required SunType sunType}) {
    sprite = Sprite(game.images.fromCache('levels/sun/sun_${sunType.name}.png'));
  }
}
