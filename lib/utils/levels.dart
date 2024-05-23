import 'package:nuvkal_dino_village/models/level_info.dart';

final List<LevelInfo> levels = [
  LevelInfo(
    id: 0,
    matrixLength: 4,
    spikesChance: 30,
    colorfulCrystalChance: 40,
    asset: "assets/png/easy_level.png",
    jackpotMatrixLength: 3,
    spikesCount: 1,
    name: "Easy level",
    description: "Matrix size - 4x4",
    jackpotValue: 60,
    jackpotDuration: 4,
  ),
  LevelInfo(
    id: 1,
    matrixLength: 6,
    spikesCount: 3,
    spikesChance: 50,
    colorfulCrystalChance: 100,
    asset: "assets/png/hard_level.png",
    jackpotMatrixLength: 6,
    name: "Hard level",
    description: "Matrix size - 6x6",
    jackpotValue: 100,
    jackpotDuration: 5,
  ),
];
