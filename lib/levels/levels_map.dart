import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:plants_vs_invaders/components/tappable_region.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class LevelsMap extends World with HasGameRef<PlantsVsInvaders> {
  late SpriteComponent backgroundImage;
  // late TiledComponent tiledLevel;

  @override
  FutureOr<void> onLoad() async {
    _loadBackgroundImage();
    // await _loadTiledLevel();

    // Уровень Картофель
    add(TappableRegion(
      position: Vector2(480, 390),
      size: Vector2(150, 180),
      callback: () {
        game.reloadLevelPreviewPotato();
      },
    ));

    // Уровень Морковь
    add(TappableRegion(
      position: Vector2(710, 400),
      size: Vector2(150, 180),
      callback: () {
        game.reloadLevelPreviewCarrot();
      },
    ));

    return super.onLoad();
  }

  void _loadBackgroundImage() {
    backgroundImage = SpriteComponent(
      sprite: Sprite(
        game.images.fromCache('levels_map.png'),
      ),
      position: Vector2(0, 0),
    );
    add(backgroundImage);
  }

  // Future<void> _loadTiledLevel() async {
  //   tiledLevel = await TiledComponent.load('level.tmx', Vector2.all(32));
  // }
}
