import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:plants_vs_invaders/animation_state_types/available_unit_types.dart';
import 'package:plants_vs_invaders/components/plant_weed_type.dart';
import 'package:plants_vs_invaders/level.dart';

class PlantWeedsSpawnTimer extends TimerComponent {
  final Level level;
  late final List<PlantWeedType> plantWeedTypes;

  PlantWeedsSpawnTimer({
    required this.level,
  }) : super(
    period: 3,
    repeat: true,
  );

  @override
  FutureOr<void> onLoad() {
    plantWeedTypes = AvailableUnitTypes.plantWeedsTypes(level.levelPlantBaseType);
    return super.onLoad();
  }

  @override
  void onTick() {
    final random = Random();

    // Индекс ячейки для появления сорняка.
    int spawnPointRowIndex = 0;
    int spawnPointColumnIndex = 0;

    int trys = 45;
    while (trys > 0) {
      spawnPointRowIndex = random.nextInt(level.boardRows);
      spawnPointColumnIndex = random.nextInt(level.boardColumns);
      if (level.plantsBoard[spawnPointRowIndex][spawnPointColumnIndex] == null) {
        break;
      }
      trys -= 1;
    }
    if (trys < 0) return;

    // Шанс появления сорняка.
    final chanceForSpawn = random.nextInt(2);
    if (chanceForSpawn == 0) {
      // Рандомно выбираются сорняки
      final weedTypeIndex = random.nextInt(plantWeedTypes.length);
      final plantWeedType = plantWeedTypes[weedTypeIndex];

      level.spawnWeeds(plantWeedType: plantWeedType, spawnPointRowIndex: spawnPointRowIndex, spawnPointColumnIndex: spawnPointColumnIndex);
    }

    super.onTick();
  }
}
