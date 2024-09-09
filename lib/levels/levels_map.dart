import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:plants_vs_invaders/components/tappable_region.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class LevelsMap extends World with HasGameRef<PlantsVsInvaders> {
  late SpriteComponent backgroundImage;
  late TiledComponent tiledLevel;

  @override
  FutureOr<void> onLoad() async {
    await _loadBackgroundImage();
    await _loadTiledLevel();

    // Уровень Картофель
    add(TappableRegion(
      position: Vector2(211, 372),
      size: Vector2(75, 102),
      callback: () {
        game.reloadLevelPreviewPotato();
      },
    ));

    // Уровень Морковь
    add(TappableRegion(
      position: Vector2(368, 407),
      size: Vector2(72, 102),
      callback: () {
        game.reloadLevelPreviewCarrot();
      },
    ));

    return super.onLoad();
  }

  Future<void> _loadBackgroundImage() async {
    final image = await Flame.images.load("levels_map.png");
    backgroundImage = SpriteComponent(
      sprite: Sprite(
        image,
      ),
      position: Vector2(0, 0),
    );
    add(backgroundImage);
  }

  Future<void> _loadTiledLevel() async {
    tiledLevel = await TiledComponent.load('level.tmx', Vector2.all(32));
  }
}
