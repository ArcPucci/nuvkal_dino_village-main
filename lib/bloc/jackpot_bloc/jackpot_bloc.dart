import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nuvkal_dino_village/bloc/blocs.dart';
import 'package:nuvkal_dino_village/models/crystal.dart';
import 'package:nuvkal_dino_village/utils/crystal_types.dart';

part 'jackpot_event.dart';

part 'jackpot_state.dart';

class JackpotBloc extends Bloc<JackpotEvent, JackpotState> {
  final GameBloc _gameBloc;

  late StreamSubscription _streamSubscription;

  JackpotBloc(
    this._gameBloc,
  ) : super(JackpotState.empty()) {
    on<StartJackpotEvent>(_onStart);
    on<FinishJackpotEvent>(_onFinishEvent);
    on<SelectCrystalEvent>(_onSelectCrystalEvent);
    on<_UpdateTimerJackpotEvent>(_onUpdateTimerEvent);
  }

  FutureOr<void> _onStart(
    StartJackpotEvent event,
    Emitter<JackpotState> emit,
  ) async {
    final List<Crystal> crystals = [];
    final int matrixLength = _gameBloc.state.levelInfo.jackpotMatrixLength;
    int balance = 0;

    if(_gameBloc.state.levelInfo.id == 1){
      balance = _gameBloc.state.balance;
    }

    for (int i = 0; i < matrixLength * matrixLength; i++) {
      final int x = Random().nextInt(crystalTypes.length);
      crystals.add(crystalTypes[x]);
    }

    final random = Random().nextInt(crystals.length - 1);
    final String randomColor = crystals[random].colorName;
    int duration = _gameBloc.state.levelInfo.jackpotDuration;

    emit(
      state.copyWith(
        colorName: randomColor,
        crystals: crystals,
        collectedTreasures: {},
        gameProcess: GameProcess.playing,
        counter: duration,
        balance: balance,
        visible: true,
      ),
    );

    _streamSubscription =
        Stream.periodic(const Duration(seconds: 1)).listen(_listener);
  }

  void _listener(event) {
    add(_UpdateTimerJackpotEvent());
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onFinishEvent(
    FinishJackpotEvent event,
    Emitter<JackpotState> emit,
  ) async {
    emit(
      state.copyWith(
        gameProcess: GameProcess.playing,
      ),
    );
    _gameBloc.add(
      ContinueGameEvent(state.balance),
    );
  }

  FutureOr<void> _onSelectCrystalEvent(
    SelectCrystalEvent event,
    Emitter<JackpotState> emit,
  ) async {
    if (!state.visible && state.gameProcess == GameProcess.playing) {
      final collectedPlates = {
        ...state.collectedTreasures,
        event.index,
      };
      final actualPlate = state.crystals[event.index];
      int balance = state.balance;
      int rightAnswersCount = 0;

      for (final i in state.crystals) {
        if (i.colorName == state.colorName) {
          rightAnswersCount++;
        }
      }

      if (state.colorName == actualPlate.colorName) {
        balance += _gameBloc.state.levelInfo.jackpotValue;
        if (collectedPlates.length == rightAnswersCount) {
          return emit(
            state.copyWith(
              balance: balance,
              gameProcess: GameProcess.endGame,
              collectedTreasures: collectedPlates,
            ),
          );
        }
        return emit(
          state.copyWith(
            balance: balance,
            collectedTreasures: collectedPlates,
          ),
        );
      } else {
        return emit(
          state.copyWith(
            gameProcess: GameProcess.fail,
            collectedTreasures: collectedPlates,
          ),
        );
      }
    }
  }

  FutureOr<void> _onUpdateTimerEvent(
    _UpdateTimerJackpotEvent event,
    Emitter<JackpotState> emit,
  ) async {
    final counter = state.counter - 1;
    if (counter <= 0) {
      _streamSubscription.cancel();
      return emit(
        state.copyWith(visible: false),
      );
    }
    emit(state.copyWith(counter: counter));
  }
}
