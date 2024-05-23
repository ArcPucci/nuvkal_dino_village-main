enum TreasureKind {
  none,
  spike,
  jackpot,
  endGame,
}

class Treasure {
  final int id;
  final String asset;
  final List<int> value;
  final TreasureKind treasureKind;
  final String description;

  Treasure({
    required this.id,
    required this.asset,
    required this.value,
    required this.treasureKind,
    required this.description,
  });
}
