import 'package:plants_vs_invaders/components/collision_block.dart';
import 'package:plants_vs_invaders/components/sprite_frame.dart';

bool checkCollision(SpriteFrame frame, CollisionBlock block) {
  // return (block.position.x + block.size.x < frame.position.x &&
  //     frame.position.x + frame.size.x > block.position.x &&
  //     block.position.y < frame.position.y &&
  //     frame.position.y < block.position.y + block.size.y);

  return (frame.position.y < block.position.y + block.size.y &&
      frame.position.y + frame.size.y > block.position.y &&
      frame.position.x < block.size.x + block.size.x &&
      frame.position.x + frame.size.x > block.position.x);
}