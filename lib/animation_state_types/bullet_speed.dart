import 'package:plants_vs_invaders/components/plant_defender_type.dart';

class BulletSpeed {
  static double speed(PlantDefenderType plantDefenderType) {
    switch (plantDefenderType) {
      case PlantDefenderType.peas:
        return 150;
      case PlantDefenderType.oats:
        return 130;
      case PlantDefenderType.buckwheat:
        return 110;
      case PlantDefenderType.clover:
        return 100;
    }
  }
}