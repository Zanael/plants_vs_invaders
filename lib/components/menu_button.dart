import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class MenuButton extends SpriteComponent with HasGameRef<PlantsVsInvaders>, TapCallbacks {

  final VoidCallback callback;

  MenuButton({
    required this.callback,
    required position,
    required size,
  }) : super(
    position: position,
    size: size,
  );

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('levels/menu/menu_button.png'));

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    callback.call();
    super.onTapUp(event);
  }
}
