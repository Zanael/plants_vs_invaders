import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:plants_vs_invaders/components/tappable_region.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class LevelPreviewCarrot extends World with HasGameRef<PlantsVsInvaders> {
  late SpriteComponent backgroundImage;
  // late TiledComponent tiledLevel;

  @override
  FutureOr<void> onLoad() async {
    await _loadBackgroundImage();
    // await _loadTiledLevel();

    // Играть
    add(TappableRegion(
      position: Vector2(420, 718),
      size: Vector2(280, 64),
      callback: () {
        game.reloadLevelCarrot();
      },
    ));

    // Назад
    add(TappableRegion(
      position: Vector2(32, 34),
      size: Vector2(223, 62),
      callback: () {
        game.reloadLevelsMap();
      },
    ));

    return super.onLoad();
  }

  Future<void> _loadBackgroundImage() async {
    final image = await Flame.images.load("level_preview/carrot.png");
    backgroundImage = SpriteComponent(
      sprite: Sprite(
        image,
      ),
      position: Vector2(0, 0),
    );
    add(backgroundImage);
  }

  // Future<void> _loadTiledLevel() async {
  //   tiledLevel = await TiledComponent.load('level.tmx', Vector2.all(32));
  // }
}
