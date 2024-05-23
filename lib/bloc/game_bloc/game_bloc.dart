import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nuvkal_dino_village/bloc/blocs.dart';
import 'package:nuvkal_dino_village/models/models.dart';
import 'package:nuvkal_dino_village/utils/levels.dart';
import 'package:nuvkal_dino_village/utils/treasures.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final ConfigBloc _configBloc;

  late StreamSubscription _streamSubscription;

  GameBloc(this._configBloc) : super(GameState.empty()) {
    on<StartGameEvent>(_onStartGame);
    on<SelectLevelGameEvent>(_onSelectLevel);
    on<CollectTreasure>(_onCollectTreasure);
    on<FinishGameEvent>(_onFinish);
    on<ContinueGameEvent>(_onContinue);
    on<_UpdateAbilityTimerEvent>(_onUpdateTimerEvent);
  }

  FutureOr<void> _onStartGame(
    StartGameEvent event,
    Emitter<GameState> emit,
  ) {
    final playerSkin = _configBloc.state.playerSkin;
    final levelInfo = state.levelInfo;
    final int matrixLength = levelInfo.matrixLength;
    final List<int> randomNumbers = [];
    final List<int> numbers = [];

    final List<Treasure> treasureList = [];

    int x = Random().nextInt(1);
    int y = 0;
    int z = 0;

    for (int i = 0; i < (matrixLength * matrixLength); i++) {
      treasureList.add(treasures[x]);
      x = Random().nextInt(2);
    }

    if (playerSkin.id == 3) {
      for (int i = 0; i < treasureList.length; i++) {
        randomNumbers.add(i);
      }
      randomNumbers.shuffle();

      numbers.addAll(randomNumbers.take(5));
    }

    x = Random().nextInt(treasureList.length - 1);
    treasureList[x] = treasures.last;

    int spikesCount = Random().nextInt(state.levelInfo.spikesCount);
    for (int i = 0; i <= spikesCount; i++) {
      y = Random().nextInt(treasureList.length - 1);
      while (y == x) {
        y = Random().nextInt(treasureList.length - 1);
      }
      treasureList[y] = treasures[2];
    }

    if (Random().nextInt(100) <= levelInfo.colorfulCrystalChance) {
      z = Random().nextInt(treasureList.length - 1);
      while (treasureList[z].treasureKind == TreasureKind.endGame ||
          treasureList[z].treasureKind == TreasureKind.spike) {
        z = Random().nextInt(treasureList.length - 1);
      }
      treasureList[z] = treasures[3];
    }

    emit(
      state.copyWith(
        treasureList: treasureList,
        collectedTreasures: [],
        balance: 0,
        abilityUsed: false,
        abilityCounter: 3,
        gameProcess: GameProcess.playing,
        randomNumbers: numbers,
      ),
    );

    if (playerSkin.id == 3) {
      _streamSubscription =
          Stream.periodic(const Duration(seconds: 1)).listen(_listener);
    }
  }

  FutureOr<void> _onUpdateTimerEvent(
    _UpdateAbilityTimerEvent event,
    Emitter<GameState> emit,
  ) async {
    final counter = state.abilityCounter - 1;
    if (counter < 0) {
      _streamSubscription.cancel();
      return emit(
        state.copyWith(abilityUsed: true),
      );
    }
    emit(state.copyWith(abilityCounter: counter));
  }

  void _listener(event) {
    add(_UpdateAbilityTimerEvent());
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onSelectLevel(
    SelectLevelGameEvent event,
    Emitter<GameState> emit,
  ) {
    final level = event.levelInfo;

    emit(state.copyWith(
      levelInfo: level,
      jackpotPlayed: false,
    ));
    add(StartGameEvent());
  }

  FutureOr<void> _onCollectTreasure(
    CollectTreasure event,
    Emitter<GameState> emit,
  ) async {
    if (state.gameProcess == GameProcess.playing &&
        !state.collectedTreasures.contains(event.index) &&
        !(_configBloc.state.playerSkin.id == 3 && !state.abilityUsed)) {
      final List<int> collectedTreasures = [
        ...state.collectedTreasures,
        event.index,
      ];

      final levelInfo = state.levelInfo;
      final levelId = levelInfo.id;
      final PlayerSkin playerSkin = _configBloc.state.playerSkin;
      final treasure = state.treasureList[event.index];
      int balance = state.balance;
      bool abilityUsed = state.abilityUsed;

      switch (treasure.treasureKind) {
        case TreasureKind.none:
          if (playerSkin.id == 2) {
            balance += (treasure.value[levelId] * 1.15).round();
          } else {
            balance += treasure.value[levelId];
          }
          break;
        case TreasureKind.spike:
          if (playerSkin.id == 1 && !abilityUsed) {
            abilityUsed = true;
          } else {
            balance +=
                ((treasure.value[levelId] / 100) * _configBloc.state.points)
                    .round();
          }
          break;
        case TreasureKind.endGame:
          balance += treasure.value[levelId];
          add(FinishGameEvent());
          break;
        case TreasureKind.jackpot:
          return emit(
            state.copyWith(
              abilityUsed: abilityUsed,
              collectedTreasures: collectedTreasures,
              balance: balance,
              gameProcess: GameProcess.jackpot,
            ),
          );
      }

      emit(
        state.copyWith(
          balance: balance,
          collectedTreasures: collectedTreasures,
          abilityUsed: abilityUsed,
        ),
      );
    }
  }

  FutureOr<void> _onFinish(
    FinishGameEvent event,
    Emitter<GameState> emit,
  ) async {
    int points = state.balance + _configBloc.state.points;

    if (_configBloc.state.playerSkin.id == 2) {
      points += ((points * 0.1).round()).abs();
    }

    emit(
      state.copyWith(
        gameProcess: GameProcess.endGame,
      ),
    );

    _configBloc.add(
      SavePointsConfigEvent(points),
    );
    Future.delayed(const Duration(milliseconds: 800), () {
      add(StartGameEvent());
    });
  }

  FutureOr<void> _onContinue(
    ContinueGameEvent event,
    Emitter<GameState> emit,
  ) async {
    final balance = state.balance + event.balance;
    emit(
      state.copyWith(
        gameProcess: GameProcess.playing,
        balance: balance,
        jackpotPlayed: true,
      ),
    );
  }
}
