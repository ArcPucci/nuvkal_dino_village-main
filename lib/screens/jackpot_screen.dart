import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuvkal_dino_village/bloc/blocs.dart';
import 'package:nuvkal_dino_village/models/models.dart';
import 'package:nuvkal_dino_village/screens/game_info_screen.dart';
import 'package:nuvkal_dino_village/screens/message_screen.dart';
import 'package:nuvkal_dino_village/utils/utils.dart';
import 'package:nuvkal_dino_village/widgets/widgets.dart';

class JackpotScreen extends StatelessWidget {
  const JackpotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return BlocBuilder<ConfigBloc, ConfigState>(
          builder: (configBloc, configState) {
            return BlocConsumer<JackpotBloc, JackpotState>(
              listener: (BuildContext context, state) {
                _listener(context, state, configState);
              },
              builder: (context, jackpotState) {
                final int matrixLength = state.levelInfo.jackpotMatrixLength;
                return BackgroundWidget(
                  child: Column(
                    children: [
                      CustomAppBar(
                        coins: configState.points,
                        isCrossButton: true,
                        hasInfo: true,
                        onTapLeft: () => context.go("/level_screen"),
                        onTapRight: () => showInfo(
                          context,
                          state.levelInfo.jackpotValue,
                        ),
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: matrixLength,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: (matrixLength * matrixLength),
                          itemBuilder: (context, index) {
                            final Crystal crystal =
                                jackpotState.crystals[index];
                            return MatrixItem(
                              onTap: () {
                                context.read<JackpotBloc>().add(
                                      SelectCrystalEvent(index),
                                    );
                              },
                              basicAsset: "assets/png/star.png",
                              treasureAsset: crystal.asset,
                              isCollected: jackpotState.visible ||
                                  jackpotState.collectedTreasures
                                      .contains(index),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                      !jackpotState.visible ||
                              (jackpotState.counter < 2 &&
                                  configState.playerSkin.id == 4)
                          ? RichText(
                              text: TextSpan(
                                text: "Choose all ",
                                style: TextStyleHelper.helper1,
                                children: [
                                  TextSpan(
                                    text: "${jackpotState.colorName}",
                                    style: TextStyleHelper.helper1.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " crystals",
                                    style: TextStyleHelper.helper1,
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              "0:0${jackpotState.counter}",
                              style: TextStyleHelper.helper9,
                            ),
                      Spacer(),
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
                                  jackpotState.balance > 0
                                      ? "+${jackpotState.balance}"
                                      : "${jackpotState.balance}",
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
      },
    );
  }

  void showInfo(BuildContext context, int jackpotValue) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return GameInfoScreen();
      },
    );
  }

  void showJackpotFailed(BuildContext context, ConfigState state) {
    showDialog(
      context: context,
      builder: (context) {
        return MessageScreen(
          gameEndMessage: true,
          onTap: () {
            context.read<JackpotBloc>().add(FinishJackpotEvent());
            Navigator.pop(context);
            context.pop();
          },
        );
      },
    );
  }

  void _listener(
    BuildContext context,
    JackpotState state,
    ConfigState configState,
  ) {
    if (state.gameProcess == GameProcess.fail) {
      showJackpotFailed(context, configState);
    } else if (state.gameProcess == GameProcess.endGame) {
      context.read<JackpotBloc>().add(FinishJackpotEvent());
      context.pop();
    }
  }
}
