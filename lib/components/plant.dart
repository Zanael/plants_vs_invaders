import 'package:flame/components.dart';

class Plant extends SpriteAnimationGroupComponent {
  final bool isDefender;

  Plant({
    required this.isDefender,
    required position,
    required size,
  }) : super(
          key: ComponentKey.unique(),
          position: position,
          size: size,
        );
}
