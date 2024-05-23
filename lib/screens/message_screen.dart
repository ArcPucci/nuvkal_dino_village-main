import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuvkal_dino_village/bloc/blocs.dart';
import 'package:nuvkal_dino_village/utils/utils.dart';
import 'package:nuvkal_dino_village/widgets/widgets.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({
    Key? key,
    this.onTap,
    this.gameEndMessage = false,
  }) : super(key: key);

  final VoidCallback? onTap;
  final bool gameEndMessage;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, state) {
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
                    Text(
                      "JACKPOT",
                      style: TextStyleHelper.helper11,
                    ),
                    Text(
                      gameEndMessage ? "GAME OVER" : "GAME FOUND",
                      style: gameEndMessage
                          ? TextStyleHelper.helper12.copyWith(
                              color: ThemeHelper.red,
                            )
                          : TextStyleHelper.helper12,
                    ),
                    SizedBox(height: 95.h),
                    SizedBox(
                      height: 320.h,
                      child: Transform.scale(
                        scale: 1.2,
                        child: Image.asset(
                          gameEndMessage
                              ? state.playerSkin.disabledAsset
                              : state.playerSkin.asset,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    CustomButton(
                      onTap: onTap,
                      content: gameEndMessage ? "Ok" : "PLAY",
                    ),
                    SizedBox(height: 47.h),
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
