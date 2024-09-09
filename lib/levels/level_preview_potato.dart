import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:plants_vs_invaders/components/tappable_region.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class LevelPreviewPotato extends World with HasGameRef<PlantsVsInvaders> {
  late SpriteComponent backgroundImage;
  // late TiledComponent tiledLevel;

  @override
  FutureOr<void> onLoad() async {
    await _loadBackgroundImage();
    // await _loadTiledLevel();

    // Играть
    add(TappableRegion(
      position: Vector2(760, 930),
      size: Vector2(430, 120),
      callback: () {
        game.reloadLevelPotato();
      },
    ));

    // Назад
    add(TappableRegion(
      position: Vector2(45, 35),
      size: Vector2(250, 70),
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

  Future<void> _loadBackgroundImage() async {
    final image = await Flame.images.load("level_preview/potato.png");
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
