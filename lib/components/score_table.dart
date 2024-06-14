import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class ScoreTable extends SpriteComponent with HasGameRef<PlantsVsInvaders> {
  final int sunResources;
  final int energyResources;

  ScoreTable({
    required this.sunResources,
    required this.energyResources,
    required position,
    required size,
  }) : super(
    position: position,
    size: size,
  );

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('levels/score_table/score_table.png'));
    _addResources(sun: 200, energy: 100);
    return super.onLoad();
  }

  void _addResources({required int sun, required int energy}) {
    final sunTextStyle = TextPaint(
        style: const TextStyle(
          fontFamily: 'RubikBubbles',
          fontSize: 24,
          color: Color(0xFFAC590D),
        ));

    final energyTextStyle = TextPaint(
        style: const TextStyle(
          fontFamily: 'RubikBubbles',
          fontSize: 24,
          color: Color(0xFF726C60),
        ));

    final sunTextComponent = TextComponent(
      text: sunResources.toString(),
      textRenderer: sunTextStyle,
      anchor: Anchor.topLeft,
      position: Vector2(160, 70),
    );

    final energyTextComponent = TextComponent(
      text: energyResources.toString(),
      textRenderer: energyTextStyle,
      anchor: Anchor.topLeft,
      position: Vector2(160, 105),
    );

    add(sunTextComponent);
    add(energyTextComponent);
  }
}
