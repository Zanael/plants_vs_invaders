import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';
import 'package:plants_vs_invaders/components/plant_defender_type.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class SunCard extends SpriteComponent with HasGameRef<PlantsVsInvaders>, DragCallbacks {
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
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('levels/sun_cards/${plantDefenderType.name}.png'));
    _addPrice();
    return super.onLoad();
  }

  void _addPrice() {
    final regular = TextPaint(
        style: const TextStyle(
      fontFamily: 'RubikBubbles',
      fontSize: 14,
      color: Color(0xFFAC590D),
    ));

    final textComponent = TextComponent(
      text: price.toString(),
      textRenderer: regular,
      anchor: Anchor.topLeft,
      position: Vector2(42, 98),
    );

    add(textComponent);
  }

  @override
  void onDragStart(DragStartEvent event) {
    // print('onDragStart: ${event.canvasPosition}');
    dragStartPosition.x = position.x;
    dragStartPosition.y = position.y;
    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    // print('onDragUpdate: ${event.parentPosition}');
    position.x += event.delta.x;
    position.y += event.delta.y;
    super.onDragUpdate(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    // print('onDragEnd - position:$position, dragStartPosition: $dragStartPosition}');
    checkNewPlantPosition.call(plantDefenderType, position);
    position.x = dragStartPosition.x;
    position.y = dragStartPosition.y;
    super.onDragEnd(event);
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    // print('onDragCancel');
    position.x = dragStartPosition.x;
    position.y = dragStartPosition.y;
    super.onDragCancel(event);
  }
}
