import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:plants_vs_invaders/level.dart';
import 'package:plants_vs_invaders/levels/level_preview_carrot.dart';
import 'package:plants_vs_invaders/levels/level_preview_potato.dart';
import 'package:plants_vs_invaders/levels/levels_map.dart';
import 'package:plants_vs_invaders/levels/main_menu.dart';

class PlantsVsInvaders extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late CameraComponent _camera;
  late World _currentLevel;

  @override
  FutureOr<void> onLoad() async {
    await _initialize();

    // reloadLevel1();
    reloadMainMenu();

    return super.onLoad();
  }

  Future<void> _initialize() async {
    await images.loadAllImages();
  }

  void _loadLevel({required int levelNumber}) {
    _currentLevel = Level(levelNumber: levelNumber);
  }

  void _prepareCamera() {
    _camera = CameraComponent.withFixedResolution(
      width: 1120,
      height: 832,
      world: _currentLevel,
    );
    _camera.viewfinder.anchor = Anchor.topLeft;
  }

  void _assembly() {
    addAll([
      _camera,
      _currentLevel,
    ]);
  }

  void reloadLevelPotato() {
    _loadLevel(levelNumber: 1);
    _prepareCamera();
    _assembly();
  }

  void reloadLevelCarrot() {
    _loadLevel(levelNumber: 1);
    _prepareCamera();
    _assembly();
  }

  void reloadMainMenu() {
    _currentLevel = MainMenu();
    _prepareCamera();
    _assembly();
  }

  void reloadLevelsMap() {
    _currentLevel = LevelsMap();
    _prepareCamera();
    _assembly();
  }

  void reloadLevelPreviewPotato() {
    _currentLevel = LevelPreviewPotato();
    _prepareCamera();
    _assembly();
  }

  void reloadLevelPreviewCarrot() {
    _currentLevel = LevelPreviewCarrot();
    _prepareCamera();
    _assembly();
  }
}
