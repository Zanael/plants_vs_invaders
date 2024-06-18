import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:plants_vs_invaders/components/level_loading_background.dart';
import 'package:plants_vs_invaders/components/plants_base_type.dart';
import 'package:plants_vs_invaders/level.dart';
import 'package:plants_vs_invaders/levels/level_preview_carrot.dart';
import 'package:plants_vs_invaders/levels/level_preview_potato.dart';
import 'package:plants_vs_invaders/levels/levels_map.dart';
import 'package:plants_vs_invaders/levels/main_menu.dart';

class PlantsVsInvaders extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  @override
  Color backgroundColor() => const Color(0xFF162C30);
  late CameraComponent _camera;
  late World _currentLevel;
  late LevelLoadingBackground _levelLoadingBackground;

  final double gameWidth = 1920;
  final double gameHeight = 1080;

  @override
  FutureOr<void> onLoad() async {
    await _initializeLoadingBackground();

    await _showLoadingAnimation();
    _initialize().whenComplete(() async {
      await _hideLoadingAnimation();
      // reloadMainMenu();
      reloadLevelPreviewPotato();
    });

    return super.onLoad();
  }

  Future<void> _initialize() async {
    await images.loadAllImages();
  }

  Future<void> _initializeLoadingBackground() async {
    _levelLoadingBackground = LevelLoadingBackground();
  }

  void _loadLevel({required PlantBaseType levelPlantBaseType}) {
    _currentLevel = Level(levelPlantBaseType: levelPlantBaseType);
  }

  void _prepareCamera() {
    _camera = CameraComponent.withFixedResolution(
      width: gameWidth,
      height: gameHeight,
      world: _currentLevel,
    );
    _camera.viewfinder.anchor = Anchor.topLeft;
  }

  void _assembly() {
    _camera.removeFromParent();
    _currentLevel.removeFromParent();
    addAll([
      _camera,
      _currentLevel,
    ]);
  }

  Future<void> _showLoadingAnimation() async {
    addAll([
      _levelLoadingBackground
    ]);
  }

  Future<void> _hideLoadingAnimation() async {
    removeAll([
      _levelLoadingBackground
    ]);
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

  void reloadLevelPotato() {
    _loadLevel(levelPlantBaseType: PlantBaseType.potato);
    _prepareCamera();
    _assembly();
  }

  void reloadLevelCarrot() {
    _loadLevel(levelPlantBaseType: PlantBaseType.carrot);
    _prepareCamera();
    _assembly();
  }
}
