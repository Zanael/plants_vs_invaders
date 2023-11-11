import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:plants_vs_invaders/animation_state_types/available_unit_types.dart';
import 'package:plants_vs_invaders/components/insects_types.dart';
import 'package:plants_vs_invaders/level.dart';

class InsectsSpawnTimer extends TimerComponent {
  final Level level;
  late final List<InsectsTypes> insectsTypes;

  InsectsSpawnTimer({
    required this.level,
  }) : super(
          period: 2,
          repeat: true,
        );

  @override
  FutureOr<void> onLoad() {
    insectsTypes = AvailableUnitTypes.insectsTypes(level.levelPlantBaseType);
    return super.onLoad();
  }

  @override
  void onTick() {
    final random = Random();

    // Индекс ячейки для появление насекомого.
    final spawnPointIndex = random.nextInt(level.insectsSpawnPoints.length);

    // Шанс появления насекомого.
    final chanceForSpawn = random.nextInt(2);
    if (chanceForSpawn == 0) {
      // Рандомно выбираются насекомые
      final insectTypeIndex = random.nextInt(insectsTypes.length);
      final insectType = insectsTypes[insectTypeIndex];

      level.spawnInsects(insectsType: insectType, spawnPoint: level.insectsSpawnPoints[spawnPointIndex]);
    }

    super.onTick();
  }
}
