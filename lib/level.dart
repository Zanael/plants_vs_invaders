import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:plants_vs_invaders/components/energy_card.dart';
import 'package:plants_vs_invaders/components/energy_resources.dart';
import 'package:plants_vs_invaders/components/field.dart';
import 'package:plants_vs_invaders/components/menu_button.dart';
import 'package:plants_vs_invaders/components/plants_base.dart';
import 'package:plants_vs_invaders/components/plants_defenders.dart';
import 'package:plants_vs_invaders/components/score_table.dart';
import 'package:plants_vs_invaders/components/sprite_frame.dart';
import 'package:plants_vs_invaders/components/sun.dart';
import 'package:plants_vs_invaders/components/sun_card.dart';
import 'package:plants_vs_invaders/components/sun_generator.dart';
import 'package:plants_vs_invaders/components/sun_resources.dart';
import 'package:plants_vs_invaders/components/sun_type.dart';
import 'package:plants_vs_invaders/components/wind_generator.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class Level extends World with HasGameRef<PlantsVsInvaders> {
  late SpriteComponent backgroundImage;
  late TiledComponent tiledLevel;
  final int levelNumber;
  final int boardRows = 5;
  final int boardColumns = 9;

  late final List<List<SpriteFrame>> boardMapSpawnPoint;
  late final SpriteFrame playerSpawnPoint;
  late final List<SpriteFrame> planeSpawnPoints = List<SpriteFrame>.generate(
    5,
    (index) => SpriteFrame(
      position: Vector2.zero(),
      size: Vector2.zero(),
    ),
  );

  late final List<SpriteFrame> insectsSpawnPoints = List<SpriteFrame>.generate(
    5,
    (index) => SpriteFrame(
      position: Vector2.zero(),
      size: Vector2.zero(),
    ),
  );
  late final SpriteFrame scoreTableSpawnPoint;
  late final SpriteFrame menuButtonSpawnPoint;
  late final SpriteFrame fieldSpawnPoint;
  late final List<SpriteFrame> sunCardSpawnPoints = List<SpriteFrame>.generate(
    4,
    (index) => SpriteFrame(
      position: Vector2.zero(),
      size: Vector2.zero(),
    ),
  );
  late final List<SpriteFrame> energyCardSpawnPoints = List<SpriteFrame>.generate(
    1,
    (index) => SpriteFrame(
      position: Vector2.zero(),
      size: Vector2.zero(),
    ),
  );
  late final SpriteFrame sunSpawnPoint;
  late final SpriteFrame sunGeneratorSpawnPoint;
  late final SpriteFrame sunResourceSpawnPoint;
  late final SpriteFrame windGeneratorSpawnPoint;
  late final SpriteFrame windResourceSpawnPoint;

  final List<PlantDefenderType> plantDefenderTypes = [
    PlantDefenderType.peas,
    PlantDefenderType.oats,
    PlantDefenderType.buckwheat,
  ];
  final List<int> plantDefenderCost = [
    100,
    150,
    200,
  ];
  late final List<SunCard> sunCards = [];
  late final List<EnergyCard> energyCards = [];
  final planeCost = 100;
  int sunResourcesCount = 200;
  int energyResourcesCount = 100;
  late final ScoreTable scoreTable;
  late final MenuButton menuButton;
  late final Field field;
  final PlantBaseType fieldType = PlantBaseType.potato;
  SunType sunType = SunType.clouds;
  late final Sun sun;
  late final SunGenerator sunGenerator;
  late final WindGenerator windGenerator;
  late final SunResources sunResources;
  late final EnergyResources energyResources;

  Level({
    required this.levelNumber,
  });

  @override
  FutureOr<void> onLoad() async {
    _loadBackgroundImage();
    await _loadTiledLevel();
    _loadBoardMapPoints();
    _loadSpawnPoints();
    _loadInterfacePoints();
    _loadGameObjectsPoints();

    _addSunCards();
    _addEnergyCards();
    _addScoreTable();
    _addMenuButton();
    _addField();
    _addSun(sunType: sunType);
    _addSunGenerator();
    _addWindGenerator();
    _addSunResources();
    _addEnergyResources();

    return super.onLoad();
  }

  void _loadBackgroundImage() {
    backgroundImage = SpriteComponent(
      sprite: Sprite(
        game.images.fromCache('levels/background/level_background.png'),
      ),
      position: Vector2(0, 0),
    );
    add(backgroundImage);
  }

  Future<void> _loadTiledLevel() async {
    tiledLevel = await TiledComponent.load('level.tmx', Vector2.all(32));
    boardMapSpawnPoint = List<List<SpriteFrame>>.generate(
        boardRows,
        (index) => List<SpriteFrame>.generate(
            boardColumns,
            (index) => SpriteFrame(
                  position: Vector2.zero(),
                  size: Vector2.zero(),
                ),
            growable: false),
        growable: false);
  }

  void _loadBoardMapPoints() {
    final boardLayer = tiledLevel.tileMap.getLayer<ObjectGroup>('board');

    if (boardLayer != null) {
      for (final cell in boardLayer.objects) {
        switch (cell.class_) {
          case 'cell':
            final position = Vector2(cell.x, cell.y);
            final size = Vector2(cell.width, cell.height);
            final row = cell.properties.getValue('row') as int;
            final column = cell.properties.getValue('column') as int;
            boardMapSpawnPoint[row][column] = SpriteFrame(
              position: position,
              size: size,
            );
            break;
          default:
            break;
        }
      }
    }
  }

  void _loadSpawnPoints() {
    final spawnPointsLayer = tiledLevel.tileMap.getLayer<ObjectGroup>('spawn_points');

    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
        switch (spawnPoint.class_) {
          case 'Insects':
            final position = Vector2(spawnPoint.x, spawnPoint.y);
            final size = Vector2(spawnPoint.width, spawnPoint.height);
            final row = spawnPoint.properties.getValue('row') as int;
            insectsSpawnPoints[row] = SpriteFrame(
              position: position,
              size: size,
            );
            break;
          case 'Plane':
            final position = Vector2(spawnPoint.x, spawnPoint.y);
            final size = Vector2(spawnPoint.width, spawnPoint.height);
            final row = spawnPoint.properties.getValue('row') as int;
            planeSpawnPoints[row] = SpriteFrame(
              position: position,
              size: size,
            );
            break;
          case 'Player':
            final position = Vector2(spawnPoint.x, spawnPoint.y);
            final size = Vector2(spawnPoint.width, spawnPoint.height);
            playerSpawnPoint = SpriteFrame(position: position, size: size);
            break;
          default:
            break;
        }
      }
    }
  }

  void _loadInterfacePoints() {
    final interfacePointsLayer = tiledLevel.tileMap.getLayer<ObjectGroup>('interface');

    if (interfacePointsLayer != null) {
      for (final interfacePoint in interfacePointsLayer.objects) {
        switch (interfacePoint.class_) {
          case 'ScoreTable':
            final position = Vector2(interfacePoint.x, interfacePoint.y);
            final size = Vector2(interfacePoint.width, interfacePoint.height);
            scoreTableSpawnPoint = SpriteFrame(
              position: position,
              size: size,
            );
            break;
          case 'MenuButton':
            final position = Vector2(interfacePoint.x, interfacePoint.y);
            final size = Vector2(interfacePoint.width, interfacePoint.height);
            menuButtonSpawnPoint = SpriteFrame(
              position: position,
              size: size,
            );
            break;
          case 'Field':
            final position = Vector2(interfacePoint.x, interfacePoint.y);
            final size = Vector2(interfacePoint.width, interfacePoint.height);
            fieldSpawnPoint = SpriteFrame(
              position: position,
              size: size,
            );
            break;
          case 'SunCard':
            final position = Vector2(interfacePoint.x, interfacePoint.y);
            final size = Vector2(interfacePoint.width, interfacePoint.height);
            final order = interfacePoint.properties.getValue('order') as int;
            sunCardSpawnPoints[order] = SpriteFrame(
              position: position,
              size: size,
            );
            break;
          case 'EnergyCard':
            final position = Vector2(interfacePoint.x, interfacePoint.y);
            final size = Vector2(interfacePoint.width, interfacePoint.height);
            final order = interfacePoint.properties.getValue('order') as int;
            energyCardSpawnPoints[order] = SpriteFrame(
              position: position,
              size: size,
            );
            break;
          default:
            break;
        }
      }
    }
  }

  void _loadGameObjectsPoints() {
    final gameObjectsPointsLayer = tiledLevel.tileMap.getLayer<ObjectGroup>('game_objects');

    if (gameObjectsPointsLayer != null) {
      for (final gameObjectPoint in gameObjectsPointsLayer.objects) {
        switch (gameObjectPoint.class_) {
          case 'Sun':
            final position = Vector2(gameObjectPoint.x, gameObjectPoint.y);
            final size = Vector2(gameObjectPoint.width, gameObjectPoint.height);
            sunSpawnPoint = SpriteFrame(
              position: position,
              size: size,
            );
            break;
          case 'SunGenerator':
            final position = Vector2(gameObjectPoint.x, gameObjectPoint.y);
            final size = Vector2(gameObjectPoint.width, gameObjectPoint.height);
            sunGeneratorSpawnPoint = SpriteFrame(
              position: position,
              size: size,
            );
            break;
          case 'WindGenerator':
            final position = Vector2(gameObjectPoint.x, gameObjectPoint.y);
            final size = Vector2(gameObjectPoint.width, gameObjectPoint.height);
            windGeneratorSpawnPoint = SpriteFrame(
              position: position,
              size: size,
            );
            break;
          case 'SunResource':
            final position = Vector2(gameObjectPoint.x, gameObjectPoint.y);
            final size = Vector2(gameObjectPoint.width, gameObjectPoint.height);
            sunResourceSpawnPoint = SpriteFrame(
              position: position,
              size: size,
            );
            break;
          case 'EnergyResource':
            final position = Vector2(gameObjectPoint.x, gameObjectPoint.y);
            final size = Vector2(gameObjectPoint.width, gameObjectPoint.height);
            windResourceSpawnPoint = SpriteFrame(
              position: position,
              size: size,
            );
            break;
          default:
            break;
        }
      }
    }
  }

  void _addSunCards() {
    for (int i = 0; i < plantDefenderTypes.length; i++) {
      final sunCard = SunCard(
        plantDefenderType: plantDefenderTypes[i],
        price: plantDefenderCost[i],
        position: sunCardSpawnPoints[i].position,
        size: sunCardSpawnPoints[i].size,
      );
      sunCards.add(sunCard);
      add(sunCard);
    }
  }

  void _addEnergyCards() {
    final energyCard = EnergyCard(
      price: planeCost,
      position: energyCardSpawnPoints[0].position,
      size: energyCardSpawnPoints[0].size,
    );
    energyCards.add(energyCard);
    add(energyCard);
  }

  void _addScoreTable() {
    scoreTable = ScoreTable(
      sunResources: sunResourcesCount,
      energyResources: energyResourcesCount,
      position: scoreTableSpawnPoint.position,
      size: scoreTableSpawnPoint.size,
    );
    add(scoreTable);
  }

  void _addMenuButton() {
    menuButton = MenuButton(
      position: menuButtonSpawnPoint.position,
      size: menuButtonSpawnPoint.size,
    );
    add(menuButton);
  }

  void _addField() {
    field = Field(
      plantBaseType: fieldType,
      position: fieldSpawnPoint.position,
      size: fieldSpawnPoint.size,
    );
    add(field);
  }

  void _addSun({required SunType sunType}) {
    sun = Sun(
      sunType: sunType,
      position: sunSpawnPoint.position,
      size: sunSpawnPoint.size,
    );
    add(sun);
  }

  void _addSunGenerator() {
    sunGenerator = SunGenerator(
      position: sunGeneratorSpawnPoint.position,
      size: sunGeneratorSpawnPoint.size,
    );
    add(sunGenerator);
  }

  void _addWindGenerator() {
    windGenerator = WindGenerator(
      position: windGeneratorSpawnPoint.position,
      size: windGeneratorSpawnPoint.size,
    );
    add(windGenerator);
  }

  void _addSunResources() {
    sunResources = SunResources(
      position: sunResourceSpawnPoint.position,
      size: sunResourceSpawnPoint.size,
    );
    add(sunResources);
  }

  void _addEnergyResources() {
    energyResources = EnergyResources(
      position: windResourceSpawnPoint.position,
      size: windResourceSpawnPoint.size,
    );
    add(energyResources);
  }
}
