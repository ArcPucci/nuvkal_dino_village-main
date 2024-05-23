part of 'jackpot_bloc.dart';

@immutable
class JackpotState {
  final Set<int> collectedTreasures;
  final List<Crystal> crystals;
  final bool visible;
  final int counter;
  final GameProcess gameProcess;
  final int balance;
  final String colorName;

  const JackpotState({
    required this.colorName,
    required this.crystals,
    required this.balance,
    required this.gameProcess,
    required this.collectedTreasures,
    required this.visible,
    required this.counter,
  });

  factory JackpotState.empty() =>
      const JackpotState(
        colorName: 'blue',
        crystals: [],
        balance: 0,
        gameProcess: GameProcess.playing,
        collectedTreasures: {},
        visible: true,
        counter: 5,
      );

  JackpotState copyWith({
    GameProcess? gameProcess,
    Set<int>? collectedTreasures,
    bool? visible,
    int? counter,
    List<Crystal>? crystals,
    int? balance,
    String? colorName,
  }) {
    return JackpotState(
      colorName: colorName ?? this.colorName,
      crystals: crystals ?? this.crystals,
      balance: balance ?? this.balance,
      gameProcess: gameProcess ?? this.gameProcess,
      collectedTreasures: collectedTreasures ?? this.collectedTreasures,
      visible: visible ?? this.visible,
      counter: counter ?? this.counter,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JackpotState &&
          runtimeType == other.runtimeType &&
          collectedTreasures == other.collectedTreasures &&
          crystals == other.crystals &&
          visible == other.visible &&
          counter == other.counter &&
          gameProcess == other.gameProcess &&
          balance == other.balance &&
          colorName == other.colorName;

  @override
  int get hashCode =>
      collectedTreasures.hashCode ^
      crystals.hashCode ^
      visible.hashCode ^
      counter.hashCode ^
      gameProcess.hashCode ^
      balance.hashCode ^
      colorName.hashCode;
}