import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:plants_vs_invaders/animation_state_types/available_unit_types.dart';
import 'package:plants_vs_invaders/animation_state_types/spell_type.dart';
import 'package:plants_vs_invaders/components/collision_block.dart';
import 'package:plants_vs_invaders/components/end_game_block.dart';
import 'package:plants_vs_invaders/components/energy_card.dart';
import 'package:plants_vs_invaders/components/energy_resources.dart';
import 'package:plants_vs_invaders/components/field.dart';
import 'package:plants_vs_invaders/components/game_over_banner.dart';
import 'package:plants_vs_invaders/components/game_over_type.dart';
import 'package:plants_vs_invaders/components/insect.dart';
import 'package:plants_vs_invaders/components/insects_types.dart';
import 'package:plants_vs_invaders/components/insects_spawn_timer.dart';
import 'package:plants_vs_invaders/components/menu_button.dart';
import 'package:plants_vs_invaders/components/plane_air_force.dart';
import 'package:plants_vs_invaders/components/plane_cloud.dart';
import 'package:plants_vs_invaders/components/plant.dart';
import 'package:plants_vs_invaders/components/plant_defender.dart';
import 'package:plants_vs_invaders/components/plant_defender_type.dart';
import 'package:plants_vs_invaders/components/plant_weed.dart';
import 'package:plants_vs_invaders/components/plant_weed_type.dart';
import 'package:plants_vs_invaders/components/plant_weeds_spawn_timer.dart';
import 'package:plants_vs_invaders/components/plants_base_type.dart';
import 'package:plants_vs_invaders/components/player.dart';
import 'package:plants_vs_invaders/components/score_table.dart';
import 'package:plants_vs_invaders/components/spell_book.dart';
import 'package:plants_vs_invaders/components/sprite_frame.dart';
import 'package:plants_vs_invaders/components/sun.dart';
import 'package:plants_vs_invaders/components/sun_card.dart';
import 'package:plants_vs_invaders/components/sun_card_cost.dart';
import 'package:plants_vs_invaders/components/sun_generator.dart';
import 'package:plants_vs_invaders/components/sun_resources.dart';
import 'package:plants_vs_invaders/components/sun_type.dart';
import 'package:plants_vs_invaders/components/wind_generator.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class Level extends World with HasGameRef<PlantsVsInvaders>, TapCallbacks {
  late Player player;
  late SpriteComponent backgroundImage;
  late TiledComponent tiledLevel;
  final PlantBaseType levelPlantBaseType;
  final int boardRows = 5;
  final int boardColumns = 9;

  late final List<List<Plant?>> plantsBoard;
  late final List<List<SpriteFrame>> boardMapSpawnPoint;
  late final SpriteFrame playerSpawnPoint;
  final List<SpriteFrame> planeSpawnPoints = List<SpriteFrame>.generate(
    5,
    (index) => SpriteFrame(
      position: Vector2.zero(),
      size: Vector2.zero(),
    ),
  );

  final List<SpriteFrame> insectsSpawnPoints = List<SpriteFrame>.generate(
    5,
    (index) => SpriteFrame(
      position: Vector2.zero(),
      size: Vector2.zero(),
    ),
  );
  late final SpriteFrame scoreTableSpawnPoint;
  late final SpriteFrame menuButtonSpawnPoint;
  late final SpriteFrame fieldSpawnPoint;
  final List<SpriteFrame> sunCardSpawnPoints = List<SpriteFrame>.generate(
    4,
    (index) => SpriteFrame(
      position: Vector2.zero(),
      size: Vector2.zero(),
    ),
  );
  final List<SpriteFrame> energyCardSpawnPoints = List<SpriteFrame>.generate(
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

  late final List<PlantDefenderType> plantDefenderTypes;
  final List<SunCard> sunCards = [];
  final List<EnergyCard> energyCards = [];
  final planeCost = 100;
  int sunResourcesCount = 200;
  int energyResourcesCount = 100;
  late ScoreTable? scoreTable;
  late final MenuButton menuButton;
  late final Field field;
  late final PlantBaseType fieldType;
  SunType sunType = SunType.clouds;
  late final Sun sun;
  late final SunGenerator sunGenerator;
  late final WindGenerator windGenerator;
  late SunResources? sunResources;
  late EnergyResources? energyResources;
  final List<CollisionBlock> collisionBlocks = [];
  late final EndGameBlock endGameBlock;
  late final InsectsSpawnTimer insectsSpawnTimer;
  late final PlantWeedsSpawnTimer plantWeedsSpawnTimer;
  late final Timer victoryTimer;
  late final double victoryTimerSeconds = 60;
  SpellBook? spellBook;
  SpellType? selectedSpellType;

  bool isGameOver = false;

  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;

  Level({
    required this.levelPlantBaseType,
  });

  @override
  FutureOr<void> onLoad() async {
    player = Player(level: this, position: Vector2.zero());
    fieldType = levelPlantBaseType;
    _loadBackgroundImage();
    await _loadTiledLevel();
    _loadBoardMapPoints();
    _loadSpawnPoints();
    _loadInterfacePoints();
    _loadGameObjectsPoints();
    _loadAndAddCollisionBlocks();

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
    _addPlayer();

    _addInsectsSpawnTimer();
    _addPlantWeedsSpawnTimer();
    _addVictoryTimer();

    add(TimerComponent(
        period: 5,
        repeat: true,
        autoStart: true,
        onTick: () {
          _updateSunResources();
          _updateEnergyResources();
        }));

    return super.onLoad();
  }

  @override
  void update(double dt) {
    accumulatedTime += dt;

    while (accumulatedTime >= fixedDeltaTime) {
      victoryTimer.update(fixedDeltaTime);
      if (victoryTimer.finished) {
        gameOver(GameOverType.victory);
      }

      accumulatedTime -= fixedDeltaTime;
    }

    super.update(dt);
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
    plantsBoard = List<List<Plant?>>.generate(
      boardRows,
      (index) => List<Plant?>.generate(
        boardColumns,
        (index) => null,
        growable: false,
      ),
      growable: false,
    );
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

  void _loadAndAddCollisionBlocks() {
    final collisionsLayer = tiledLevel.tileMap.getLayer<ObjectGroup>('collisions');

    if (collisionsLayer != null) {
      for (final collision in collisionsLayer.objects) {
        final position = Vector2(collision.x, collision.y);
        final size = Vector2(collision.width, collision.height);
        if (collision.class_ == 'EndGame') {
          final block = EndGameBlock(
            position: position,
            size: size,
          );
          endGameBlock = block;
          add(endGameBlock);
        } else {
          final block = CollisionBlock(
            position: position,
            size: size,
          );
          collisionBlocks.add(block);
          add(block);
        }
      }
    }
  }

  void _addSunCards() {
    plantDefenderTypes = AvailableUnitTypes.plantDefendersTypes(levelPlantBaseType);
    for (int i = 0; i < plantDefenderTypes.length; i++) {
      int cost = 0;
      switch (plantDefenderTypes[i]) {
        case PlantDefenderType.peas:
          cost = SunCardCost.peas;
          break;
        case PlantDefenderType.oats:
          cost = SunCardCost.oats;
          break;
        case PlantDefenderType.clover:
          cost = SunCardCost.clover;
          break;
        case PlantDefenderType.buckwheat:
          cost = SunCardCost.buckwheat;
          break;
      }

      final sunCard = SunCard(
        plantDefenderType: plantDefenderTypes[i],
        price: cost,
        position: sunCardSpawnPoints[i].position,
        size: sunCardSpawnPoints[i].size,
        checkNewPlantPosition: (plantDefenderType, position) {
          if (sunResourcesCount - cost < 0) return;

          for (int rowIndex = 0; rowIndex < boardMapSpawnPoint.length; rowIndex++) {
            for (int columnIndex = 0; columnIndex < boardMapSpawnPoint[rowIndex].length; columnIndex++) {
              if (Rect.fromLTWH(
                boardMapSpawnPoint[rowIndex][columnIndex].position.x,
                boardMapSpawnPoint[rowIndex][columnIndex].position.y,
                boardMapSpawnPoint[rowIndex][columnIndex].size.x,
                boardMapSpawnPoint[rowIndex][columnIndex].size.y,
              ).containsPoint(position)) {
                if (plantsBoard[rowIndex][columnIndex] == null) {
                  PlantDefender plantDefender = PlantDefender(
                    level: this,
                    plantDefenderType: plantDefenderType,
                    position: Vector2(
                      boardMapSpawnPoint[rowIndex][columnIndex].position.x + 20,
                      boardMapSpawnPoint[rowIndex][columnIndex].position.y + 30,
                    ),
                    size: Vector2(70, 80),
                  );
                  plantsBoard[rowIndex][columnIndex] = plantDefender;
                  add(plantDefender);

                  paySunResources(cost);
                }
                break;
              }
            }
          }
        },
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
      callback: (price) {
        if (energyResourcesCount - price < 0) return;
        _openSpellBook();
      },
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
    add(scoreTable!);
  }

  void _updateScoreTable() {
    if (scoreTable != null) remove(scoreTable!);
    scoreTable = null;
    scoreTable = ScoreTable(
      sunResources: sunResourcesCount,
      energyResources: energyResourcesCount,
      position: scoreTableSpawnPoint.position,
      size: scoreTableSpawnPoint.size,
    );
    add(scoreTable!);
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
    add(sunResources!);
  }

  void _addEnergyResources() {
    energyResources = EnergyResources(
      position: windResourceSpawnPoint.position,
      size: windResourceSpawnPoint.size,
    );
    add(energyResources!);
  }

  void _updateSunResources() {
    if (sunResources != null) {
      if (sunResources!.parent != null) {
        remove(sunResources!);
      }
    }
    sunResources = null;
    sunResources = SunResources(
      position: sunResourceSpawnPoint.position,
      size: sunResourceSpawnPoint.size,
    );
    add(sunResources!);
  }

  void _updateEnergyResources() {
    if (energyResources != null) {
      if (energyResources!.parent != null) {
        remove(energyResources!);
      }
    }
    energyResources = null;
    energyResources = EnergyResources(
      position: windResourceSpawnPoint.position,
      size: windResourceSpawnPoint.size,
    );
    add(energyResources!);
  }

  void _addPlayer() {
    player.position = playerSpawnPoint.position;
    player.collisionBlocks = collisionBlocks;
    add(player);
  }

  void spawnInsects({required InsectsTypes insectsType, required SpriteFrame spawnPoint}) {
    Insect insect = Insect(
        insectsType: insectsType,
        position: spawnPoint.position,
        size: spawnPoint.size,
        endGameCallback: () {
          gameOver(GameOverType.defeat);
        });
    add(insect);
  }

  void spawnWeeds(
      {required PlantWeedType plantWeedType, required int spawnPointRowIndex, required int spawnPointColumnIndex}) {
    final spawnPoint = boardMapSpawnPoint[spawnPointRowIndex][spawnPointColumnIndex];
    PlantWeed plantWeed = PlantWeed(
      plantWeedType: plantWeedType,
      position: Vector2(
        spawnPoint.position.x + 20,
        spawnPoint.position.y + 30,
      ),
      size: Vector2(70, 80),
    );
    plantsBoard[spawnPointRowIndex][spawnPointColumnIndex] = plantWeed;
    add(plantWeed);
  }

  void _addInsectsSpawnTimer() {
    insectsSpawnTimer = InsectsSpawnTimer(level: this);
    add(insectsSpawnTimer);
  }

  void _addPlantWeedsSpawnTimer() {
    plantWeedsSpawnTimer = PlantWeedsSpawnTimer(level: this);
    add(plantWeedsSpawnTimer);
  }

  void _addVictoryTimer() {
    victoryTimer = Timer(victoryTimerSeconds);
  }

  void gameOver(GameOverType gameOverType) {
    if (!isGameOver) {
      isGameOver = true;

      final gameOverBanner = GameOverBanner(
        gameOverType: gameOverType,
        position: backgroundImage.position,
        size: backgroundImage.size,
      );
      add(gameOverBanner);
    }
  }

  void collectSunResources(int count) {
    sunResources = null;
    sunResourcesCount += count;
    _updateScoreTable();
  }

  void paySunResources(int count) {
    sunResourcesCount -= count;
    _updateScoreTable();
  }

  void collectEnergyResources(int count) {
    energyResourcesCount += count;
    _updateScoreTable();
  }

  void payEnergyResources(int count) {
    energyResourcesCount -= count;
    _updateScoreTable();
  }

  void _openSpellBook() {
    if (spellBook != null) {
      if (spellBook!.parent != null) {
        remove(spellBook!);
      }
    }

    spellBook = null;
    spellBook = SpellBook(
      position: Vector2(248, 181),
      onCircleBluePotion: () {
        _closeSpellBook();
        selectedSpellType = SpellType.circleBluePotion;
      },
      onCircleYellowPotion: () {
        _closeSpellBook();
        selectedSpellType = SpellType.circleYellowPotion;
      },
      onCircleRedPotion: () {
        _closeSpellBook();
        selectedSpellType = SpellType.circleRedPotion;
      },
      onRectBluePotion: () {
        _closeSpellBook();
        selectedSpellType = SpellType.rectBluePotion;
      },
      onRectYellowPotion: () {
        _closeSpellBook();
        selectedSpellType = SpellType.rectYellowPotion;
      },
      onRectRedPotion: () {
        _closeSpellBook();
        selectedSpellType = SpellType.rectRedPotion;
      },
      onClose: () => _closeSpellBook(),
    );
    add(spellBook!);
  }

  _closeSpellBook() {
    if (spellBook != null) {
      if (spellBook!.parent != null) {
        remove(spellBook!);
        spellBook = null;
      }
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (selectedSpellType != null) {
      for (int rowIndex = 0; rowIndex < boardMapSpawnPoint.length; rowIndex++) {
        for (int columnIndex = 0; columnIndex < boardMapSpawnPoint[rowIndex].length; columnIndex++) {
          if (Rect.fromLTWH(
            boardMapSpawnPoint[rowIndex][columnIndex].position.x,
            boardMapSpawnPoint[rowIndex][columnIndex].position.y,
            boardMapSpawnPoint[rowIndex][columnIndex].size.x,
            boardMapSpawnPoint[rowIndex][columnIndex].size.y,
          ).containsPoint(event.localPosition)) {
            final plane = PlaneAirForce(
                position: Vector2(
                  planeSpawnPoints[rowIndex].position.x,
                  planeSpawnPoints[rowIndex].position.y,
                ));
            add(plane);

            final planeCloud = PlaneCloud(
              position: Vector2(
                boardMapSpawnPoint[rowIndex][columnIndex].position.x + 20,
                boardMapSpawnPoint[rowIndex][columnIndex].position.y + 30,
              ),
              size: Vector2(70, 80),
              spellType: selectedSpellType!,
              onClose: () {},
            );
            add(planeCloud);
            payEnergyResources(100);

            break;
          }
        }
      }
      selectedSpellType = null;
    }
    super.onTapUp(event);
  }
}
