class CustomTiledObject {
  String name;
  String type;

  double x;
  double y;
  double width;
  double height;

  int row;
  int column;

  CustomTiledObject(
      {this.name = '',
      this.type = '',
      this.x = 0,
      this.y = 0,
      this.width = 0,
      this.height = 0,
      this.row = 0,
      this.column = 0});

  static List<CustomTiledObject> generateBoard() {
    return <CustomTiledObject>[

      CustomTiledObject(column: 0, row: 0, x: 468, y: 234, width: 154, height: 154),
      CustomTiledObject(column: 0, row: 1,  x: 468, y: 388, width: 154, height: 154),
      CustomTiledObject(column: 0, row: 2,  x: 468, y: 542, width: 154, height: 154),
      CustomTiledObject(column: 0, row: 3,  x: 468, y: 696, width: 154, height: 154),
      CustomTiledObject(column: 0, row: 4,  x: 468, y: 850, width: 154, height: 154),

      CustomTiledObject(column: 1, row: 0, x: 622, y: 234, width: 154, height: 154),
      CustomTiledObject(column: 1, row: 1,  x: 622, y: 388, width: 154, height: 154),
      CustomTiledObject(column: 1, row: 2,  x: 622, y: 542, width: 154, height: 154),
      CustomTiledObject(column: 1, row: 3,  x: 622, y: 696, width: 154, height: 154),
      CustomTiledObject(column: 1, row: 4,  x: 622, y: 850, width: 154, height: 154),

      CustomTiledObject(column: 2, row: 0, x: 776, y: 234, width: 154, height: 154),
      CustomTiledObject(column: 2, row: 1,  x: 776, y: 388, width: 154, height: 154),
      CustomTiledObject(column: 2, row: 2,  x: 776, y: 542, width: 154, height: 154),
      CustomTiledObject(column: 2, row: 3,  x: 776, y: 696, width: 154, height: 154),
      CustomTiledObject(column: 2, row: 4,  x: 776, y: 850, width: 154, height: 154),

      CustomTiledObject(column: 3, row: 0, x: 930, y: 234, width: 154, height: 154),
      CustomTiledObject(column: 3, row: 1,  x: 930, y: 388, width: 154, height: 154),
      CustomTiledObject(column: 3, row: 2,  x: 930, y: 542, width: 154, height: 154),
      CustomTiledObject(column: 3, row: 3,  x: 930, y: 696, width: 154, height: 154),
      CustomTiledObject(column: 3, row: 4,  x: 930, y: 850, width: 154, height: 154),

      CustomTiledObject(column: 4, row: 0, x: 1084, y: 234, width: 154, height: 154),
      CustomTiledObject(column: 4, row: 1,  x: 1084, y: 388, width: 154, height: 154),
      CustomTiledObject(column: 4, row: 2,  x: 1084, y: 542, width: 154, height: 154),
      CustomTiledObject(column: 4, row: 3,  x: 1084, y: 696, width: 154, height: 154),
      CustomTiledObject(column: 4, row: 4,  x: 1084, y: 850, width: 154, height: 154),

      CustomTiledObject(column: 5, row: 0, x: 1238, y: 234, width: 154, height: 154),
      CustomTiledObject(column: 5, row: 1,  x: 1238, y: 388, width: 154, height: 154),
      CustomTiledObject(column: 5, row: 2,  x: 1238, y: 542, width: 154, height: 154),
      CustomTiledObject(column: 5, row: 3,  x: 1238, y: 696, width: 154, height: 154),
      CustomTiledObject(column: 5, row: 4,  x: 1238, y: 850, width: 154, height: 154),

      CustomTiledObject(column: 6, row: 0, x: 1392, y: 234, width: 154, height: 154),
      CustomTiledObject(column: 6, row: 1,  x: 1392, y: 388, width: 154, height: 154),
      CustomTiledObject(column: 6, row: 2,  x: 1392, y: 542, width: 154, height: 154),
      CustomTiledObject(column: 6, row: 3,  x: 1392, y: 696, width: 154, height: 154),
      CustomTiledObject(column: 6, row: 4,  x: 1392, y: 850, width: 154, height: 154),

      CustomTiledObject(column: 7, row: 0, x: 1546, y: 234, width: 154, height: 154),
      CustomTiledObject(column: 7, row: 1,  x: 1546, y: 388, width: 154, height: 154),
      CustomTiledObject(column: 7, row: 2,  x: 1546, y: 542, width: 154, height: 154),
      CustomTiledObject(column: 7, row: 3,  x: 1546, y: 696, width: 154, height: 154),
      CustomTiledObject(column: 7, row: 4,  x: 1546, y: 850, width: 154, height: 154),

      CustomTiledObject(column: 8, row: 0, x: 1700, y: 234, width: 154, height: 154),
      CustomTiledObject(column: 8, row: 1,  x: 1700, y: 388, width: 154, height: 154),
      CustomTiledObject(column: 8, row: 2,  x: 1700, y: 542, width: 154, height: 154),
      CustomTiledObject(column: 8, row: 3,  x: 1700, y: 696, width: 154, height: 154),
      CustomTiledObject(column: 8, row: 4,  x: 1700, y: 850, width: 154, height: 154),
    ];
  }

  static CustomTiledObject generateEndGameCollision() {
    return CustomTiledObject(x: 448, y: 0, width: 10, height: 1080);
  }

  static List<CustomTiledObject> generateCollisionBlocks() {
    return <CustomTiledObject>[
      CustomTiledObject(x: 0, y: 1008, width: 1920, height: 10),
      CustomTiledObject(x: 0, y: 223, width: 1920, height: 10),
      CustomTiledObject(x: 1860, y: 0, width: 10, height: 1080),
      CustomTiledObject(x: 458, y: 0, width: 10, height: 1080),
    ];
  }

  static CustomTiledObject generateSunObject() {
    return CustomTiledObject(x: 1566, y: 20, width: 400, height: 225);
  }

  static CustomTiledObject generateSunGeneratorObject() {
    return CustomTiledObject(x: 129, y: 92, width: 571, height: 321);
  }

  static CustomTiledObject generateWindGeneratorObject() {
    return CustomTiledObject(x: -344, y: 519, width: 1212, height: 682);
  }

  static CustomTiledObject generateSunResourceObject() {
    return CustomTiledObject(x: 321, y: 149, width: 271, height: 152);
  }

  static CustomTiledObject generateEnergyResourceObject() {
    return CustomTiledObject(x: 188, y: 810, width: 464, height: 261);
  }

  static CustomTiledObject generateScoreTableObject() {
    return CustomTiledObject(x: -96, y: -61, width: 557, height: 305);
  }

  static CustomTiledObject generateMenuButtonObject() {
    return CustomTiledObject(x: -162, y: 72, width: 659, height: 361);
  }

  static CustomTiledObject generateFieldObject() {
    return CustomTiledObject(x: 0, y: 299, width: 103, height: 340);
  }

  static List<CustomTiledObject> generateSunCardObjects() {
    return <CustomTiledObject>[
      CustomTiledObject(x: 670, y: 0, width: 173, height: 228),
      CustomTiledObject(x: 843, y: 0, width: 173, height: 228),
      CustomTiledObject(x: 1016, y: 0, width: 173, height: 228),
      CustomTiledObject(x: 1189, y: 0, width: 173, height: 228),
    ];
  }

  static List<CustomTiledObject> generateEnergyCardObjects() {
    return <CustomTiledObject>[
      CustomTiledObject(x: 1436, y: 0, width: 173, height: 228),
    ];
  }

  static CustomTiledObject generatePlayerObject() {
    return CustomTiledObject(x: 484, y: 450, width: 433, height: 245);
  }

  static List<CustomTiledObject> generatePlaneObjects() {
    return <CustomTiledObject>[
      CustomTiledObject(row: 0, x: -1200, y: 234, width: 265, height: 150),
      CustomTiledObject(row: 1, x: -1200, y: 388, width: 265, height: 150),
      CustomTiledObject(row: 2, x: -1200, y: 542, width: 265, height: 150),
      CustomTiledObject(row: 3, x: -1200, y: 696, width: 265, height: 150),
      CustomTiledObject(row: 4, x: -1200, y: 850, width: 265, height: 150),
    ];
  }

  static List<CustomTiledObject> generateInsectObjects() {
    return <CustomTiledObject>[
      CustomTiledObject(row: 0, x: 1920, y: 249, width: 265, height: 150),
      CustomTiledObject(row: 1, x: 1920, y: 403, width: 265, height: 150),
      CustomTiledObject(row: 2, x: 1920, y: 557, width: 265, height: 150),
      CustomTiledObject(row: 3, x: 1920, y: 711, width: 265, height: 150),
      CustomTiledObject(row: 4, x: 1920, y: 865, width: 265, height: 150),
    ];
  }
}
