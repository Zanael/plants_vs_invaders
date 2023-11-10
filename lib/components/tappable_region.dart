import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

class TappableRegion extends PositionComponent with TapCallbacks {
  VoidCallback? callback;

  TappableRegion({
    required position,
    required size,
    required this.callback,
  }) : super(
          position: position,
          size: size,
        );

  @override
  FutureOr<void> onLoad() {
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    callback?.call();
    super.onTapUp(event);
  }
}
