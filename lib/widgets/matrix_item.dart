import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuvkal_dino_village/utils/utils.dart';

class MatrixItem extends StatelessWidget {
  const MatrixItem({
    Key? key,
    required this.basicAsset,
    this.isCollected = false,
    required this.treasureAsset,
    this.onTap,
  }) : super(key: key);

  final String basicAsset;
  final bool isCollected;
  final String treasureAsset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: ThemeHelper.darkBlue.withOpacity(0.5),
              border: Border.all(
                width: 1.sp,
                color: ThemeHelper.blue.withOpacity(0.5),
              ),
            ),
            child: Image.asset(
              isCollected ? treasureAsset : basicAsset,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
