part of 'config_bloc.dart';

@immutable
abstract class ConfigEvent {}

class InitConfigEvent extends ConfigEvent {}

class BuyPremiumConfigEvent extends ConfigEvent {}

class SelectPlayerSkin extends ConfigEvent {
  final PlayerSkin playerSkin;

  SelectPlayerSkin(this.playerSkin);
}

class SelectPearlSkin extends ConfigEvent {
  final PearlSkin pearlSkin;

  SelectPearlSkin(this.pearlSkin);
}

class SavePointsConfigEvent extends ConfigEvent {
  final int points;

  SavePointsConfigEvent(this.points);
}