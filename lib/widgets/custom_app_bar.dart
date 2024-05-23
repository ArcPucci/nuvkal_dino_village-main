import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuvkal_dino_village/utils/utils.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.onTapLeft,
    this.onTapRight,
    this.hasInfo = false,
    this.isBackButton = false,
    this.isCrossButton = false,
    required this.coins,
  }) : super(key: key);

  final VoidCallback? onTapLeft;
  final VoidCallback? onTapRight;
  final bool hasInfo;
  final bool isBackButton;
  final bool isCrossButton;
  final int coins;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 6,
          sigmaX: 6,
        ),
        child: Container(
          width: 375.w,
          height: 54.h,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.sp,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            color: ThemeHelper.darkBlue.withOpacity(0.3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onTapLeft,
                child: Container(
                  width: 56.w,
                  height: 54.h,
                  color: Colors.transparent,
                  child: Center(
                    child: SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: Image.asset(
                        isCrossButton
                            ? "assets/png/icons/close.png"
                            : isBackButton
                                ? "assets/png/icons/back.png"
                                : "assets/png/icons/shop.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "$coins",
                    style: TextStyleHelper.helper3,
                  ),
                  SizedBox(width: 2.w),
                  SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: Image.asset(
                      "assets/png/icons/diamond.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              onTapRight != null
                  ? GestureDetector(
                      onTap: onTapRight,
                      child: Container(
                        width: 56.w,
                        height: 54.h,
                        color: Colors.transparent,
                        child: Center(
                          child: SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: Image.asset(
                              hasInfo
                                  ? "assets/png/icons/info.png"
                                  : "assets/png/icons/settings.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(width: 56.w),
            ],
          ),
        ),
      ),
    );
  }
}
