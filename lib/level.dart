import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:plants_vs_invaders/animation_state_types/available_unit_types.dart';
import 'package:plants_vs_invaders/animation_state_types/spell_type.dart';
import 'package:plants_vs_invaders/animation_state_types/victory_timer_bar_colors.dart';
import 'package:plants_vs_invaders/components/collision_block.dart';
import 'package:plants_vs_invaders/components/custom_tiled_object.dart';
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
import 'package:plants_vs_invaders/components/victory_timer_bar.dart';
import 'package:plants_vs_invaders/components/wind_generator.dart';
import 'package:plants_vs_invaders/plants_vs_invaders.dart';

class Level extends World
    with HasGameRef<PlantsVsInvaders>, TapCallbacks, DragCallbacks {
  late Player player;
  late SpriteComponent backgroundImage;

  // late TiledComponent tiledLevel;
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
  late final double victoryTimerSeconds = 120;
  late VictoryTimerBar victoryTimerBar;
  SpellBook? spellBook;
  SpellType? selectedSpellType;

  bool isGameOver = false;

  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;

  SunCard? sunCardToDrag;
  Vector2 dragStartPosition = Vector2.zero();

  Level({
    required this.levelPlantBaseType,
  });

  @override
  FutureOr<void> onLoad() async {
    player = Player(level: this, position: Vector2(-1000, -1000));
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
    // _addField();
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

    _addVictoryTimerBar();

    return super.onLoad();
  }

  @override
  void update(double dt) {
    accumulatedTime += dt;

    while (accumulatedTime >= fixedDeltaTime) {
      victoryTimer.update(fixedDeltaTime);
      _updateVictoryTimerBar();
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
    // tiledLevel = await TiledComponent.load('level.tmx', Vector2.all(32));
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
    final boardLayerObjects = CustomTiledObject.generateBoard();

    for (final cell in boardLayerObjects) {
      final position = Vector2(cell.x, cell.y);
      final size = Vector2(cell.width, cell.height);
      final row = cell.row;
      final column = cell.column;
      boardMapSpawnPoint[row][column] = SpriteFrame(
        position: position,
        size: size,
      );
    }
  }

  void _loadSpawnPoints() {
    final playerObject = CustomTiledObject.generatePlayerObject();
    final planeObjects = CustomTiledObject.generatePlaneObjects();
    final insectObjects = CustomTiledObject.generateInsectObjects();

    playerSpawnPoint = SpriteFrame(
      position: Vector2(playerObject.x, playerObject.y),
      size: Vector2(playerObject.width, playerObject.height),
    );

    for (final planeObject in planeObjects) {
      final position = Vector2(planeObject.x, planeObject.y);
      final size = Vector2(planeObject.width, planeObject.height);
      final row = planeObject.row;
      planeSpawnPoints[row] = SpriteFrame(
        position: position,
        size: size,
      );
    }

    for (final insectObject in insectObjects) {
      final position = Vector2(insectObject.x, insectObject.y);
      final size = Vector2(insectObject.width, insectObject.height);
      final row = insectObject.row;
      insectsSpawnPoints[row] = SpriteFrame(
        position: position,
        size: size,
      );
    }
  }

  void _loadInterfacePoints() {
    final scoreTableObject = CustomTiledObject.generateScoreTableObject();
    final menuButtonObject = CustomTiledObject.generateMenuButtonObject();
    final fieldObject = CustomTiledObject.generateFieldObject();
    final sunCardObjects = CustomTiledObject.generateSunCardObjects();
    final energyCardObjects = CustomTiledObject.generateEnergyCardObjects();

    scoreTableSpawnPoint = SpriteFrame(
      position: Vector2(scoreTableObject.x, scoreTableObject.y),
      size: Vector2(scoreTableObject.width, scoreTableObject.height),
    );

    menuButtonSpawnPoint = SpriteFrame(
      position: Vector2(menuButtonObject.x, menuButtonObject.y),
      size: Vector2(menuButtonObject.width, menuButtonObject.height),
    );

    fieldSpawnPoint = SpriteFrame(
      position: Vector2(fieldObject.x, fieldObject.y),
      size: Vector2(fieldObject.width, fieldObject.height),
    );

    for (int order = 0; order < sunCardObjects.length; order++) {
      sunCardSpawnPoints[order] = SpriteFrame(
        position: Vector2(sunCardObjects[order].x, sunCardObjects[order].y),
        size: Vector2(sunCardObjects[order].width, sunCardObjects[order].height),
      );
    }

    for (int order = 0; order < energyCardObjects.length; order++) {
      energyCardSpawnPoints[order] = SpriteFrame(
        position: Vector2(energyCardObjects[order].x, energyCardObjects[order].y),
        size: Vector2(energyCardObjects[order].width, energyCardObjects[order].height),
      );
    }
  }

  void _loadGameObjectsPoints() {
    final sunObject = CustomTiledObject.generateSunObject();
    final sunGeneratorObject = CustomTiledObject.generateSunGeneratorObject();
    final windGeneratorObject = CustomTiledObject.generateWindGeneratorObject();
    final sunResourceObject = CustomTiledObject.generateSunResourceObject();
    final energyResourceObject = CustomTiledObject.generateEnergyResourceObject();

    sunSpawnPoint = SpriteFrame(
      position: Vector2(sunObject.x, sunObject.y),
      size: Vector2(sunObject.width, sunObject.height),
    );

    sunGeneratorSpawnPoint = SpriteFrame(
      position: Vector2(sunGeneratorObject.x, sunGeneratorObject.y),
      size: Vector2(sunGeneratorObject.width, sunGeneratorObject.height),
    );

    windGeneratorSpawnPoint = SpriteFrame(
      position: Vector2(windGeneratorObject.x, windGeneratorObject.y),
      size: Vector2(windGeneratorObject.width, windGeneratorObject.height),
    );

    sunResourceSpawnPoint = SpriteFrame(
      position: Vector2(sunResourceObject.x, sunResourceObject.y),
      size: Vector2(sunResourceObject.width, sunResourceObject.height),
    );

    windResourceSpawnPoint = SpriteFrame(
      position: Vector2(energyResourceObject.x, energyResourceObject.y),
      size: Vector2(energyResourceObject.width, energyResourceObject.height),
    );
  }

  void _loadAndAddCollisionBlocks() {
    final endGameObject = CustomTiledObject.generateEndGameCollision();
    final collisionBlockObjects = CustomTiledObject.generateCollisionBlocks();

    endGameBlock = EndGameBlock(
      position: Vector2(endGameObject.x, endGameObject.y),
      size: Vector2(endGameObject.width, endGameObject.height),
    );
    add(endGameBlock);

    for (final collision in collisionBlockObjects) {
      final position = Vector2(collision.x, collision.y);
      final size = Vector2(collision.width, collision.height);
      final block = CollisionBlock(
        position: position,
        size: size,
      );
      collisionBlocks.add(block);
      add(block);
    }
  }

  void _addSunCards() {
    plantDefenderTypes =
        AvailableUnitTypes.plantDefendersTypes(levelPlantBaseType);
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

          for (int rowIndex = 0;
              rowIndex < boardMapSpawnPoint.length;
              rowIndex++) {
            for (int columnIndex = 0;
                columnIndex < boardMapSpawnPoint[rowIndex].length;
                columnIndex++) {
              if (Rect.fromLTWH(
                boardMapSpawnPoint[rowIndex][columnIndex].position.x,
                boardMapSpawnPoint[rowIndex][columnIndex].position.y,
                boardMapSpawnPoint[rowIndex][columnIndex].size.x,
                boardMapSpawnPoint[rowIndex][columnIndex].size.y,
                // ).containsPoint(Vector2(position.x + 45, position.y + 65))) {
              ).containsPoint(Vector2(position.x + 86, position.y + 114))) {
                // INFO: Проверяем центр карточки при ее размере 91x129.
                // INFO: Проверяем центр карточки при ее размере 350x200 (-110x-20).
                if (plantsBoard[rowIndex][columnIndex] == null) {
                  PlantDefender plantDefender = PlantDefender(
                    plantDefenderType: plantDefenderType,
                    rowOnBoard: rowIndex,
                    columnOnBoard: columnIndex,
                    spawnBullet: (bullet) {
                      add(bullet);
                    },
                    wasKilled: (plantDefender, rowOnBoard, columnOnBoard) {
                      plantsBoard[rowOnBoard][columnOnBoard] = null;
                    },
                    position: Vector2(
                      boardMapSpawnPoint[rowIndex][columnIndex].position.x - 50,
                      boardMapSpawnPoint[rowIndex][columnIndex].position.y + 15,
                    ),
                    size: Vector2(265, 150),
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
      callback: () {
        final Map<String, dynamic> data = {"action": "failed"};
        const jsonEncoder = JsonEncoder();
        final json = jsonEncoder.convert(data);
        html.window.parent?.postMessage(json, "*");
        // game.reloadLevelsMap();
        // removeFromParent();
      },
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
      callback: () {
        sunResources?.removeFromParent();
        collectSunResources(50);
      },
      position: sunResourceSpawnPoint.position,
      size: sunResourceSpawnPoint.size,
    );
    add(sunResources!);
  }

  void _addEnergyResources() {
    energyResources = EnergyResources(
      callback: () {
        energyResources?.removeFromParent();
        collectEnergyResources(50);
      },
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
      callback: () {
        sunResources?.removeFromParent();
        collectSunResources(50);
      },
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
      callback: () {
        energyResources?.removeFromParent();
        collectEnergyResources(50);
      },
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

  void spawnInsects(
      {required InsectsTypes insectsType, required SpriteFrame spawnPoint}) {
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
      {required PlantWeedType plantWeedType,
      required int spawnPointRowIndex,
      required int spawnPointColumnIndex}) {
    final spawnPoint =
        boardMapSpawnPoint[spawnPointRowIndex][spawnPointColumnIndex];
    PlantWeed plantWeed = PlantWeed(
      plantWeedType: plantWeedType,
      rowOnBoard: spawnPointRowIndex,
      columnOnBoard: spawnPointColumnIndex,
      wasKilled: (plantWeed, rowOnBoard, columnOnBoard) {
        plantsBoard[rowOnBoard][columnOnBoard] = null;
      },
      position: Vector2(
        spawnPoint.position.x - 50,
        spawnPoint.position.y + 15,
      ),
      size: Vector2(265, 150),
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
        completed: () {
          switch (gameOverType) {
            case GameOverType.victory:
              final Map<String, dynamic> data = {"action": "success"};
              const jsonEncoder = JsonEncoder();
              final json = jsonEncoder.convert(data);
              html.window.parent?.postMessage(json, "*");
              break;
            case GameOverType.defeat:
              final Map<String, dynamic> data = {"action": "failed"};
              const jsonEncoder = JsonEncoder();
              final json = jsonEncoder.convert(data);
              html.window.parent?.postMessage(json, "*");
              break;
          }
          // game.reloadLevelsMap();
          removeFromParent();
        },
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
      position: Vector2(0, 0),
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
        for (int columnIndex = 0;
            columnIndex < boardMapSpawnPoint[rowIndex].length;
            columnIndex++) {
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
                boardMapSpawnPoint[rowIndex][columnIndex].position.x - 55,
                boardMapSpawnPoint[rowIndex][columnIndex].position.y,
              ),
              size: Vector2(265, 150),
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

  @override
  void onRemove() {
    // TODO: Внимательно проверить dispose ресурсов.
    super.onRemove();
  }

  @override
  void onDragStart(DragStartEvent event) {
    for (int i = 0; i < sunCardSpawnPoints.length; i++) {
      if (Rect.fromLTWH(
        sunCardSpawnPoints[i].position.x,
        sunCardSpawnPoints[i].position.y,
        sunCardSpawnPoints[i].size.x,
        sunCardSpawnPoints[i].size.y,
      ).containsPoint(event.localPosition)) {
        sunCardToDrag = sunCards[i];
        dragStartPosition = Vector2(
          event.localPosition.x,
          event.localPosition.y,
        );
        sunCardToDrag?.dragStart();
        break;
      }
    }

    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    final delta = Vector2(
      event.localPosition.x - dragStartPosition.x,
      event.localPosition.y - dragStartPosition.y,
    );
    sunCardToDrag?.dragUpdate(delta);
    super.onDragUpdate(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    sunCardToDrag?.dragEnd();
    sunCardToDrag = null;
    dragStartPosition = Vector2.zero();
    super.onDragEnd(event);
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    sunCardToDrag?.dragCancel();
    sunCardToDrag = null;
    dragStartPosition = Vector2.zero();
    super.onDragCancel(event);
  }

  void _addVictoryTimerBar() {
    victoryTimerBar = VictoryTimerBar(
      color: VictoryTimerBarColors.front,
      backgroundColor: VictoryTimerBarColors.back,
      borderColor: VictoryTimerBarColors.border,
      position: Vector2(1500, 1040),
      size: Vector2(250, 15),
      progress: 0,
    );
    add(victoryTimerBar);
  }

  void _updateVictoryTimerBar() {
    final victoryTimerCurrentSeconds = victoryTimer.current;
    final victoryTimerTotalSeconds = victoryTimerSeconds;
    final progress = victoryTimerCurrentSeconds / victoryTimerTotalSeconds;

    victoryTimerBar.removeFromParent();
    victoryTimerBar = VictoryTimerBar(
      color: VictoryTimerBarColors.front,
      backgroundColor: VictoryTimerBarColors.back,
      borderColor: VictoryTimerBarColors.border,
      position: Vector2(1500, 1040),
      size: Vector2(250, 15),
      progress: progress,
    );
    add(victoryTimerBar);
  }
}
