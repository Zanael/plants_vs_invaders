import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  PlantsVsInvaders game = PlantsVsInvaders();
  runApp(GameWidget(game: kDebugMode ? PlantsVsInvaders() : game));
}

// https://docs.flutter.dev/perf/impeller#ios
// <key>FLTEnableImpeller</key>
// <false />