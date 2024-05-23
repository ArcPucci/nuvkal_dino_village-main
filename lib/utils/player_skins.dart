import 'package:nuvkal_dino_village/models/player_skin.dart';

final List<PlayerSkin> playerSkins = [
  PlayerSkin(
    id: 0,
    name: "Allosaurus",
    cost: 0,
    description: "No abilities",
    asset: "assets/png/player_skins/allosaurus.png",
    disabledAsset: "assets/png/player_skins/allosaurus_disabled.png",
  ),
  PlayerSkin(
    id: 1,
    name: "Gastonia",
    cost: 2500,
    description: "Doesn't take spike damage on first hit",
    asset: "assets/png/player_skins/gastonia.png",
    disabledAsset: "assets/png/player_skins/gastonia_disabled.png",
  ),
  PlayerSkin(
    id: 2,
    name: "Kileskus",
    cost: 3500,
    description: "Gets 15% more crystals than others",
    asset: "assets/png/player_skins/kileskus.png",
    disabledAsset: "assets/png/player_skins/kileskus_disabled.png",
  ),
  PlayerSkin(
    id: 3,
    name: "Vulcanodon",
    cost: 5000,
    description:
        "The first 3 seconds of the game sees random 5 cells",
    asset: "assets/png/player_skins/vulkanodon.png",
    disabledAsset: "assets/png/player_skins/vulkanodon_disabled.png",
  ),
  PlayerSkin(
    id: 4,
    name: "Oviraptor",
    cost: 7500,
    description:
        "At the last second of the jackpot game sees the color that will be chosen",
    asset: "assets/png/player_skins/oviraptor.png",
    disabledAsset: "assets/png/player_skins/oviraptor_disabled.png",
  ),
];
