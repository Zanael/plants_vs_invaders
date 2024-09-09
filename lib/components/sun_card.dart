import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/text.dart';
import 'package:plants_vs_invaders/components/plant_defender_type.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class SunCard extends SpriteComponent with HasGameRef<PlantsVsInvaders> {
  final PlantDefenderType plantDefenderType;
  final int price;
  Function(PlantDefenderType plantDefenderType, Vector2 position) checkNewPlantPosition;

  SunCard({
    required this.plantDefenderType,
    required this.price,
    required this.checkNewPlantPosition,
    required position,
    required size,
  }) : super(
          position: position,
          size: size,
        );

  Vector2 dragStartPosition = Vector2.zero();

  @override
  FutureOr<void> onLoad() async {
    priority = 100;
    final image = await Flame.images.load("levels/sun_cards/${plantDefenderType.name}.png");
    sprite = Sprite(image);
    _addPrice();
    return super.onLoad();
  }

  void _addPrice() {
    final regular = TextPaint(
        style: const TextStyle(
      fontFamily: 'RubikBubbles',
      fontSize: 20,
      color: Color(0xFFAC590D),
    ));

    final textComponent = TextComponent(
      text: price.toString(),
      textRenderer: regular,
      anchor: Anchor.topLeft,
      position: Vector2(80, 180),
    );

    add(textComponent);
  }

  void dragStart() {
    dragStartPosition.x = position.x;
    dragStartPosition.y = position.y;
  }

  void dragUpdate(Vector2 delta) {
    position.x = dragStartPosition.x + delta.x;
    position.y = dragStartPosition.y + delta.y;
  }

  void dragEnd() {
    checkNewPlantPosition.call(plantDefenderType, position);
    position.x = dragStartPosition.x;
    position.y = dragStartPosition.y;
  }

  void dragCancel() {
    position.x = dragStartPosition.x;
    position.y = dragStartPosition.y;
  }
}
