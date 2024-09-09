import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
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
  FutureOr<void> onLoad() async {
    final image = await Flame.images.load("levels/menu/menu_button.png");
    sprite = Sprite(image);

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    callback.call();
    super.onTapUp(event);
  }
}
