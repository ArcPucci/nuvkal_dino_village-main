import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuvkal_dino_village/utils/utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.content,
    this.hasIcon = false,
    this.onTap,
    this.enabled = true,
  }) : super(key: key);

  final String content;
  final bool hasIcon;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled ? 1 : 0.3,
        child: Container(
          width: 335.w,
          height: 72.h,
          decoration: BoxDecoration(
            color: ThemeHelper.red,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                content,
                style: TextStyleHelper.helper1,
              ),
              if (hasIcon) ...[
                SizedBox(width: 4.w),
                SizedBox(
                  width: 32.w,
                  height: 32.h,
                  child: Image.asset(
                    "assets/png/icons/diamond.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
