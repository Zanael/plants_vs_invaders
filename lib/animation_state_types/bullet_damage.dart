import 'package:plants_vs_invaders/components/plant_defender_type.dart';

class BulletDamage {
  static int damage(PlantDefenderType plantDefenderType) {
    switch (plantDefenderType) {
      case PlantDefenderType.peas:
        return 20;
      case PlantDefenderType.oats:
        return 25;
      case PlantDefenderType.buckwheat:
        return 30;
      case PlantDefenderType.clover:
        return 100;
    }
  }
}