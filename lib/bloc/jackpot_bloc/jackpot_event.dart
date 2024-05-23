part of 'jackpot_bloc.dart';

@immutable
abstract class JackpotEvent {}

class StartJackpotEvent extends JackpotEvent {}

class FinishJackpotEvent extends JackpotEvent {}

class SelectCrystalEvent extends JackpotEvent {
  final int index;

  SelectCrystalEvent(this.index);
}

class _UpdateTimerJackpotEvent extends JackpotEvent {}
