import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuvkal_dino_village/utils/utils.dart';

class CounterButton extends StatelessWidget {
  const CounterButton({
    Key? key,
    this.isNextButton = false,
    this.onTap,
    this.enabled = true,
  }) : super(key: key);

  final bool isNextButton;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled ? 1 : 0.3,
        child: Container(
          width: 158.w,
          height: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            color: ThemeHelper.blue,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isNextButton) ...[
                SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: Image.asset(
                    "assets/png/icons/back.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 10.w),
              ],
              Text(
                isNextButton ? "Next" : "Prev",
                style: TextStyleHelper.helper6,
              ),
              if (isNextButton) ...[
                SizedBox(width: 10.w),
                SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: Image.asset(
                    "assets/png/icons/next.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
