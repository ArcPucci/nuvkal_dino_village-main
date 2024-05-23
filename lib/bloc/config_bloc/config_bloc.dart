import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nuvkal_dino_village/models/models.dart';
import 'package:nuvkal_dino_village/services/preference_service.dart';
import 'package:nuvkal_dino_village/utils/utils.dart';

part 'config_event.dart';

part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final PreferenceService preferenceService;

  ConfigBloc(this.preferenceService) : super(ConfigState.empty()) {
    on<InitConfigEvent>(_onInit);
    on<BuyPremiumConfigEvent>(_onBuyPremium);
    on<SelectPlayerSkin>(_onSelectPlayerSkin);
    on<SelectPearlSkin>(_onSelectPearlSkin);
    on<SavePointsConfigEvent>(_onSavePoints);
  }

  FutureOr<void> _onInit(
    InitConfigEvent event,
    Emitter<ConfigState> emit,
  ) async {
    final int points = preferenceService.getPoints();
    final String pearlSkin = preferenceService.getPearlSkin();
    final bool isPremium = preferenceService.isPremium();
    final List<String> pearlSkins = preferenceService.getPearlSkins();
    final List<String> playerSkinsIndexes = preferenceService.getPlayerSkins();

    final List<PlayerSkin> boughtPlayerSkins = playerSkins
        .where(
          (element) => playerSkinsIndexes.contains(
            element.id.toString(),
          ),
        )
        .toList();

    emit(
      state.copyWith(
        points: points,
        pearlSkin: pearlSkin,
        isPremium: isPremium,
        pearlSkins: pearlSkins,
        playerSkins: boughtPlayerSkins,
      ),
    );
  }

  FutureOr<void> _onBuyPremium(
    BuyPremiumConfigEvent event,
    Emitter<ConfigState> emit,
  ) async {
    await preferenceService.setPremium();

    final List<String> playerSkinsIndexes = [];

    for (final i in playerSkins) {
      playerSkinsIndexes.add(i.id.toString());
    }

    final List<String> allEggSkins = [];

    for (final i in pearlSkins) {
      allEggSkins.add(i.asset);
    }

    await preferenceService.setPlayerSkins(playerSkinsIndexes);

    await preferenceService.setPearlSkins(allEggSkins);

    emit(
      state.copyWith(
        isPremium: true,
        pearlSkins: allEggSkins,
        playerSkins: playerSkins,
      ),
    );
  }

  FutureOr<void> _onSelectPlayerSkin(
      SelectPlayerSkin event, Emitter<ConfigState> emit) async {
    final playerSkins = state.skins;
    final playerSkin = event.playerSkin;
    final hasPlayerSkin = playerSkins.contains(playerSkin);

    if (hasPlayerSkin) {
      return emit(
        state.copyWith(playerSkin: playerSkin),
      );
    }

    final points = state.points - playerSkin.cost;

    playerSkins.add(playerSkin);

    await preferenceService.setPoints(points);

    final List<String> playerSkinsIndexes = [];

    for (final i in playerSkins) {
      playerSkinsIndexes.add(i.id.toString());
    }

    await preferenceService.setPlayerSkins(playerSkinsIndexes);

    emit(
      state.copyWith(
        points: points,
        playerSkin: playerSkin,
        playerSkins: playerSkins,
      ),
    );
  }

  FutureOr<void> _onSelectPearlSkin(
      SelectPearlSkin event, Emitter<ConfigState> emit) async {
    final List<String> pearls = List.from(state.pearlSkins);
    final pearlSkin = event.pearlSkin;
    final hasBackgroundSkin = pearls.contains(pearlSkin.asset);

    if (hasBackgroundSkin) {
      return emit(
        state.copyWith(
          pearlSkin: pearlSkin.asset,
        ),
      );
    }

    final points = state.points - pearlSkin.cost;
    pearls.add(pearlSkin.asset);

    await preferenceService.setPoints(points);
    await preferenceService.setPearlSkins(pearls);

    emit(
      state.copyWith(
        points: points,
        pearlSkin: pearlSkin.asset,
        pearlSkins: pearls,
      ),
    );
  }

  FutureOr<void> _onSavePoints(
    SavePointsConfigEvent event,
    Emitter<ConfigState> emit,
  ) async {
    final points = event.points;

    await preferenceService.setPoints(points);

    emit(
      state.copyWith(
        points: points,
      ),
    );
  }
}
