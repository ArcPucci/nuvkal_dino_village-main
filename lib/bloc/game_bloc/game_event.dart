part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}


class StartGameEvent extends GameEvent {}

class CollectTreasure extends GameEvent {
  final int index;

  CollectTreasure(this.index);
}

class FinishGameEvent extends GameEvent {}

class JackpotGameEvent extends GameEvent {}

class ContinueGameEvent extends GameEvent {
  final int balance;

  ContinueGameEvent(this.balance);
}

class SelectLevelGameEvent extends GameEvent {
  final LevelInfo levelInfo;

  SelectLevelGameEvent(this.levelInfo);
}

class _UpdateAbilityTimerEvent extends GameEvent {}
