import 'package:nuvkal_dino_village/utils/pearl_skins.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static final PreferenceService instance = PreferenceService._();
  static late final SharedPreferences _prefs;

  PreferenceService._();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  factory PreferenceService() => instance;

  static const premiumKey = "PREMIUM_KEY";
  static const selectedPlayerSkinKey = "SELECTED_PLAYER_SKIN";
  static const selectedEggSkinKey = "SELECTED_PEARL_SKIN";
  static const boughtEggSkinsKey = "PEARL_SKINS";
  static const boughtPlayerSkinsKey = "PLAYER_SKINS";
  static const pointsKey = "POINTS";

  Future<void> setPremium() async {
    await _prefs.setBool(premiumKey, true);
  }

  bool isPremium() {
    return _prefs.getBool(premiumKey) ?? false;
  }

  Future<void> setPoints(int points) async {
    await _prefs.setInt(pointsKey, points);
  }

  int getPoints() {
    return _prefs.getInt(pointsKey) ?? 500;
  }

  Future<void> setPlayerSkin(String value) async {
    await _prefs.setString(selectedPlayerSkinKey, value);
  }

  int getPlayerSkin() {
    return _prefs.getInt(selectedEggSkinKey) ?? 0;
  }

  Future<void> setPearlSkin(String value) async {
    await _prefs.setString(selectedEggSkinKey, value);
  }

  String getPearlSkin() {
    return _prefs.getString(selectedEggSkinKey) ?? pearlSkins[0].asset;
  }

  Future<void> setPlayerSkins(List<String> playerSkins) async {
    await _prefs.setStringList(boughtPlayerSkinsKey, playerSkins);
  }

  List<String> getPlayerSkins() {
    return _prefs.getStringList(boughtPlayerSkinsKey) ?? ["0"];
  }

  Future<void> setPearlSkins(List<String> pearlSkins) async {
    await _prefs.setStringList(boughtEggSkinsKey, pearlSkins);
  }

  List<String> getPearlSkins() {
    return _prefs.getStringList(boughtEggSkinsKey) ?? [pearlSkins[0].asset];
  }
}
