import 'package:plants_vs_invaders/components/insects_types.dart';
import 'package:plants_vs_invaders/components/plant_defender_type.dart';
import 'package:plants_vs_invaders/components/plant_weed_type.dart';
import 'package:plants_vs_invaders/components/plants_base_type.dart';

class AvailableUnitTypes {
  static List<InsectsTypes> insectsTypes(PlantBaseType plantBaseType) {
    switch (plantBaseType) {
      case PlantBaseType.potato:
        return [InsectsTypes.colorado_beetle, InsectsTypes.mole_cricket, InsectsTypes.mole];
      case PlantBaseType.carrot:
      default:
      return [InsectsTypes.mole_cricket, InsectsTypes.mole, InsectsTypes.slug];
    }
  }

  static List<PlantDefenderType> plantDefendersTypes(PlantBaseType plantBaseType) {
    switch (plantBaseType) {
      case PlantBaseType.potato:
        return [PlantDefenderType.peas, PlantDefenderType.oats, PlantDefenderType.buckwheat];
      case PlantBaseType.carrot:
      default:
      return [PlantDefenderType.peas, PlantDefenderType.oats, PlantDefenderType.clover];
    }
  }

  static List<PlantWeedType> plantWeedsTypes(PlantBaseType plantBaseType) {
    switch (plantBaseType) {
      case PlantBaseType.potato:
        return [PlantWeedType.bindweed, PlantWeedType.shepherds_purse, PlantWeedType.wheatgrass];
      case PlantBaseType.carrot:
      default:
      return [PlantWeedType.hogweed, PlantWeedType.shepherds_purse, PlantWeedType.dandelion];
    }
  }
}