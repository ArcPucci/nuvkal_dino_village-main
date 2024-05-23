part of 'game_bloc.dart';

enum GameProcess { playing, jackpot, endGame, fail }

@immutable
class GameState {
  final List<Treasure> treasureList;
  final List<int> collectedTreasures;
  final int balance;
  final LevelInfo levelInfo;
  final GameProcess gameProcess;
  final bool abilityUsed;
  final int abilityCounter;
  final List<int> randomNumbers;
  final bool jackpotPlayed;

  const GameState({
    required this.jackpotPlayed,
    required this.randomNumbers,
    required this.abilityCounter,
    required this.gameProcess,
    required this.levelInfo,
    required this.treasureList,
    required this.collectedTreasures,
    required this.balance,
    required this.abilityUsed,
  });

  factory GameState.empty() => GameState(
        jackpotPlayed: false,
        randomNumbers: [],
        abilityCounter: 3,
        abilityUsed: false,
        gameProcess: GameProcess.playing,
        levelInfo: levels[0],
        treasureList: const [],
        collectedTreasures: const [],
        balance: 0,
      );

  GameState copyWith({
    int? points,
    List<Treasure>? treasureList,
    List<int>? collectedTreasures,
    int? balance,
    LevelInfo? levelInfo,
    GameProcess? gameProcess,
    bool? abilityUsed,
    int? abilityCounter,
    List<int>? randomNumbers,
    bool? jackpotPlayed,
  }) {
    return GameState(
      jackpotPlayed: jackpotPlayed ?? this.jackpotPlayed,
      randomNumbers: randomNumbers ?? this.randomNumbers,
      abilityCounter: abilityCounter ?? this.abilityCounter,
      abilityUsed: abilityUsed ?? this.abilityUsed,
      gameProcess: gameProcess ?? this.gameProcess,
      levelInfo: levelInfo ?? this.levelInfo,
      balance: balance ?? this.balance,
      treasureList: treasureList ?? this.treasureList,
      collectedTreasures: collectedTreasures ?? this.collectedTreasures,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameState &&
          runtimeType == other.runtimeType &&
          treasureList == other.treasureList &&
          collectedTreasures == other.collectedTreasures &&
          balance == other.balance &&
          levelInfo == other.levelInfo &&
          gameProcess == other.gameProcess &&
          abilityUsed == other.abilityUsed &&
          abilityCounter == other.abilityCounter &&
          randomNumbers == other.randomNumbers &&
          jackpotPlayed == other.jackpotPlayed;

  @override
  int get hashCode =>
      treasureList.hashCode ^
      collectedTreasures.hashCode ^
      balance.hashCode ^
      levelInfo.hashCode ^
      gameProcess.hashCode ^
      abilityUsed.hashCode ^
      abilityCounter.hashCode ^
      randomNumbers.hashCode ^
      jackpotPlayed.hashCode;
}
