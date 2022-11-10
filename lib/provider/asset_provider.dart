import 'package:flutter/material.dart';

class AssetProvider {
  static AssetProvider? _instance;
  static AssetProvider get instance {
    _instance ??= AssetProvider();
    return _instance!;
  }

  static const customBoard = AssetImage("./assets/custom_moonboard.png");
  static const moonboardImage =
      AssetImage("./assets/A_2016-B_2016-OS_2016_highRes.png");
}
