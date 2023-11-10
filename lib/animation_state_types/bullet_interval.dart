import 'package:plants_vs_invaders/components/plant_defender_type.dart';

class BulletInterval {
  static double interval(PlantDefenderType plantDefenderType) {
    switch (plantDefenderType) {
      case PlantDefenderType.peas:
        return 2;
      case PlantDefenderType.oats:
        return 2;
      case PlantDefenderType.buckwheat:
        return 3;
      case PlantDefenderType.clover:
        return 3;
    }
  }
}