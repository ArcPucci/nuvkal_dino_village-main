part of 'config_bloc.dart';

@immutable
class ConfigState {
  final int points;
  final PlayerSkin playerSkin;
  final String pearlSkin;
  final bool isPremium;
  final List<PlayerSkin> skins;
  final List<String> pearlSkins;

  ConfigState({
    required this.points,
    required this.playerSkin,
    required this.pearlSkin,
    required this.isPremium,
    required this.skins,
    required this.pearlSkins,
  });

  ConfigState copyWith({
    int? points,
    PlayerSkin? playerSkin,
    String? pearlSkin,
    List<PlayerSkin>? playerSkins,
    List<String>? pearlSkins,
    bool? isPremium,
  }) {
    return ConfigState(
      points: points ?? this.points,
      playerSkin: playerSkin ?? this.playerSkin,
      pearlSkin: pearlSkin ?? this.pearlSkin,
      isPremium: isPremium ?? this.isPremium,
      pearlSkins: pearlSkins ?? this.pearlSkins,
      skins: playerSkins ?? this.skins,
    );
  }

  factory ConfigState.empty() => ConfigState(
    points: 500,
    playerSkin: playerSkins[0],
    pearlSkin: "assets/png/pearl.png",
    isPremium: false,
    pearlSkins: const ["assets/png/pearl.png"],
    skins: [playerSkins[0]],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigState &&
          runtimeType == other.runtimeType &&
          points == other.points &&
          playerSkin == other.playerSkin &&
          pearlSkin == other.pearlSkin &&
          isPremium == other.isPremium &&
          skins == other.skins &&
          pearlSkins == other.pearlSkins;

  @override
  int get hashCode =>
      points.hashCode ^
      playerSkin.hashCode ^
      pearlSkin.hashCode ^
      isPremium.hashCode ^
      skins.hashCode ^
      pearlSkins.hashCode;
}
