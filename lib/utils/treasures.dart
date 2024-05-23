import 'package:nuvkal_dino_village/models/treasure.dart';

final List<Treasure> treasures = [
  Treasure(
    id: 0,
    asset: "assets/png/treasures/diamond.png",
    value: [10, 20],
    treasureKind: TreasureKind.none,
    description: " Coins",
  ),
  Treasure(
    id: 1,
    asset: "assets/png/treasures/blue_diamond.png",
    value: [30, 70],
    treasureKind: TreasureKind.none,
    description: " Coins",
  ),
  Treasure(
    id: 2,
    asset: "assets/png/treasures/spike.png",
    value: [-10, -20],
    treasureKind: TreasureKind.spike,
    description: "% of Balance",
  ),
  Treasure(
    id: 3,
    asset: "assets/png/treasures/jackpot.png",
    value: [0, 0],
    treasureKind: TreasureKind.jackpot,
    description: "JACKPOT GAME",
  ),
  Treasure(
    id: 4,
    asset: "assets/png/treasures/purple_diamond.png",
    value: [30, 50],
    treasureKind: TreasureKind.endGame,
    description: " Coins",
  ),
];
