import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuvkal_dino_village/bloc/blocs.dart';
import 'package:nuvkal_dino_village/utils/utils.dart';
import 'package:nuvkal_dino_village/widgets/custom_button.dart';
import 'package:nuvkal_dino_village/widgets/matrix_item.dart';

class GameInfoScreen extends StatelessWidget {
  GameInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          final int levelId = state.levelInfo.id;
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 4,
              sigmaY: 4,
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Column(
                  children: [
                    Spacer(),
                    Container(
                      width: 341.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/png/picture.png",
                          ),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(10.sp),
                        border: Border.all(
                          color: ThemeHelper.blue.withOpacity(0.3),
                          width: 1.sp,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 24.h,
                      ),
                      child: Column(
                        children: List.generate(
                          treasures.length,
                          (index) {
                            final treasure = treasures[index];
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 70.sp,
                                      height: 70.sp,
                                      child: MatrixItem(
                                        basicAsset: treasures[index].asset,
                                        treasureAsset: treasures[index].asset,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    index < treasures.length - 1
                                        ? Text(
                                            treasure.value[levelId] > 0
                                                ? "+${treasure.value[levelId]}${treasure.description}"
                                                : treasure.value[levelId] == 0
                                                    ? treasure.description
                                                    : "${treasure.value[levelId]}${treasure.description}",
                                            style: TextStyleHelper.helper1,
                                          )
                                        : Text(
                                            "GAME OVER\n+${treasure.value[levelId]}" +
                                                treasure.description,
                                            style: TextStyleHelper.helper1,
                                          ),
                                  ],
                                ),
                                if (index < treasures.length - 1)
                                  SizedBox(height: 24.h),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 60.h),
                    CustomButton(
                      onTap: () => Navigator.pop(context),
                      content: "Close",
                    ),
                    SizedBox(height: 58.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
