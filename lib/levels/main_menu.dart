import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:plants_vs_invaders/components/tappable_region.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class MainMenu extends World with HasGameRef<PlantsVsInvaders> {
  late SpriteComponent backgroundImage;
  // late TiledComponent tiledLevel;

  @override
  FutureOr<void> onLoad() async {
    _loadBackgroundImage();
    // await _loadTiledLevel();

    // Играть
    add(TappableRegion(
      position: Vector2(770, 30),
      size: Vector2(300, 180),
      callback: () {
        game.reloadLevelsMap();
      },
    ));

    return super.onLoad();
  }

  void _loadBackgroundImage() {
    backgroundImage = SpriteComponent(
      sprite: Sprite(
        game.images.fromCache('main_menu.png'),
      ),
      position: Vector2(0, 0),
    );
    add(backgroundImage);
  }

  // Future<void> _loadTiledLevel() async {
  //   tiledLevel = await TiledComponent.load('level.tmx', Vector2.all(32));
  // }
}
