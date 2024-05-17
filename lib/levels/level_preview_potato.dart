import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:plants_vs_invaders/components/tappable_region.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class LevelPreviewPotato extends World with HasGameRef<PlantsVsInvaders> {
  late SpriteComponent backgroundImage;
  late TiledComponent tiledLevel;

  @override
  FutureOr<void> onLoad() async {
    _loadBackgroundImage();
    await _loadTiledLevel();

    // Играть
    add(TappableRegion(
      position: Vector2(421, 718),
      size: Vector2(280, 64),
      callback: () {
        game.reloadLevelPotato();
      },
    ));

    // Назад
    add(TappableRegion(
      position: Vector2(49, 35),
      size: Vector2(211, 62),
      callback: () {
        // game.reloadLevelsMap();

        final Map<String, dynamic> data = {
          "action": "failed"
        };
        const jsonEncoder = JsonEncoder();
        final json = jsonEncoder.convert(data);
        html.window.parent?.postMessage(json, "*");
      },
    ));

    return super.onLoad();
  }

  void _loadBackgroundImage() {
    backgroundImage = SpriteComponent(
      sprite: Sprite(
        game.images.fromCache('level_preview/potato.png'),
      ),
      position: Vector2(0, 0),
    );
    add(backgroundImage);
  }

  Future<void> _loadTiledLevel() async {
    tiledLevel = await TiledComponent.load('level.tmx', Vector2.all(32));
  }
}
