class LevelInfo {
  final int id;
  final int matrixLength;
  final int spikesChance;
  final int colorfulCrystalChance;
  final String asset;
  final int jackpotMatrixLength;
  final int spikesCount;
  final String name;
  final String description;
  final int jackpotValue;
  final int jackpotDuration;

  LevelInfo({
    required this.name,
    required this.description,
    required this.id,
    required this.matrixLength,
    required this.spikesChance,
    required this.colorfulCrystalChance,
    required this.asset,
    required this.jackpotMatrixLength,
    required this.spikesCount,
    required this.jackpotValue,
    required this.jackpotDuration,
  });
}
