import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuvkal_dino_village/bloc/blocs.dart';
import 'package:nuvkal_dino_village/screens/game_info_screen.dart';
import 'package:nuvkal_dino_village/screens/message_screen.dart';
import 'package:nuvkal_dino_village/utils/text_style_helper.dart';
import 'package:nuvkal_dino_village/utils/utils.dart';
import 'package:nuvkal_dino_village/widgets/widgets.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, configState) {
        return BlocConsumer<GameBloc, GameState>(
          listener: (context, state) => _listener(
            context,
            state,
            configState,
          ),
          builder: (context, state) {
            int matrixLength = state.levelInfo.matrixLength;
            return BackgroundWidget(
              child: Column(
                children: [
                  CustomAppBar(
                    onTapLeft: () => context.pop(),
                    onTapRight: () => toInfo(context),
                    hasInfo: true,
                    isCrossButton: true,
                    coins: configState.points,
                  ),
                  SizedBox(height: 40.h),
                  Container(
                    width: 336.sp,
                    height: 336.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: matrixLength,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: (matrixLength * matrixLength),
                      itemBuilder: (context, index) {
                        final treasure = state.treasureList[index];
                        return MatrixItem(
                          onTap: () {
                            context.read<GameBloc>().add(
                                  CollectTreasure(index),
                                );
                          },
                          isCollected:
                              (state.collectedTreasures.contains(index)) ||
                                  (state.randomNumbers.contains(index) &&
                                      !state.abilityUsed),
                          treasureAsset: treasure.asset,
                          basicAsset: configState.pearlSkin,
                        );
                      },
                    ),
                  ),
                  if (!state.abilityUsed && configState.playerSkin.id == 3) ...[
                    SizedBox(height: 16.h),
                    Text(
                      "0:0${state.abilityCounter}",
                      style: TextStyleHelper.helper9,
                    ),
                  ],
                  const Spacer(),
                  SizedBox(
                    width: 335.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 113.w,
                          height: 154.h,
                          child: Image.asset(
                            configState.playerSkin.asset,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              state.balance > 0
                                  ? "+${state.balance}"
                                  : "${state.balance}",
                              style: TextStyleHelper.helper7,
                            ),
                            SizedBox(width: 8.w),
                            SizedBox(
                              width: 36.w,
                              height: 36.h,
                              child: Image.asset(
                                "assets/png/icons/diamond.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60.h),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _listener(
    BuildContext context,
    GameState state,
    ConfigState configState,
  ) {
    if (state.gameProcess == GameProcess.jackpot) {
      context.read<GameBloc>().add(
            ContinueGameEvent(0),
          );
      showJackpotIntroduction(context, configState, state);
    }
  }

  void showJackpotIntroduction(
    BuildContext context,
    ConfigState state,
    GameState gameState,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return gameState.jackpotPlayed
            ? MessageScreen(
                onTap: () => _onEnterJackpotGame(context),
              )
            : _buildLabel(context, gameState);
      },
    );
  }

  void _onEnterJackpotGame(BuildContext context) {
    Navigator.pop(context);
    context.read<JackpotBloc>().add(StartJackpotEvent());
    context.go('/level_screen/game_screen/jackpot_screen');
  }

  Widget _buildLabel(BuildContext context, GameState state) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: [
              Spacer(),
              Container(
                width: 335.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/png/picture.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16.sp),
                  border: Border.all(
                    color: ThemeHelper.blue.withOpacity(0.3),
                    width: 0.5.sp,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25.sp,
                      color: ThemeHelper.coldBlue.withOpacity(0.1),
                    ),
                  ],
                ),
                padding: EdgeInsets.only(
                  top: 20.h,
                  bottom: 16.h,
                ),
                child: Column(
                  children: [
                    Text(
                      "JACKPOT GAME",
                      style: TextStyleHelper.helper3.copyWith(
                        color: ThemeHelper.green,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      width: 335.w,
                      height: 0.5.sp,
                      color: ThemeHelper.blue.withOpacity(0.3),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: 311.w,
                      child: Text(
                        "You are shown crystals of different colors. After a while, all the colors will be hidden, and you have to select all the crystals of the specified color. You get +${state.levelInfo.jackpotValue} coins for each correctly selected crystal. If you choose wrong, the game will end",
                        style: TextStyleHelper.helper10,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 177.h),
              CustomButton(
                onTap: () => _onEnterJackpotGame(context),
                content: "PLAY",
              ),
              SizedBox(height: 58.h),
            ],
          ),
        ),
      ),
    );
  }

  void toInfo(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return GameInfoScreen();
      },
    );
  }
}
