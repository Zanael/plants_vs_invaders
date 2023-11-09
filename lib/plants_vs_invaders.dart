import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:plants_vs_invaders/level.dart';

class PlantsVsInvaders extends FlameGame{
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late CameraComponent _camera;
  late World _currentLevel;

  @override
  FutureOr<void> onLoad() async {
    await _initialize();
    _loadLevel(levelNumber: 1);
    _prepareCamera();
    _assembly();

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
}
