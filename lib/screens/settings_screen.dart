import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuvkal_dino_village/bloc/blocs.dart';
import 'package:nuvkal_dino_village/screens/screens.dart';
import 'package:nuvkal_dino_village/utils/text_style_helper.dart';
import 'package:nuvkal_dino_village/utils/theme_helper.dart';
import 'package:nuvkal_dino_village/widgets/background_widget.dart';
import 'package:nuvkal_dino_village/widgets/custom_app_bar.dart';
import 'package:nuvkal_dino_village/widgets/custom_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, state) {
        return BackgroundWidget(
          child: Column(
            children: [
              CustomAppBar(
                onTapLeft: () => context.pop(),
                isBackButton: true,
                coins: state.points,
              ),
              SizedBox(height: 24.h),
              if (!state.isPremium) ...[
                CustomButton(
                  onTap: () => _toPremium(context),
                  content: "GET PREMIUM",
                ),
                SizedBox(height: 16.h),
              ],
              SizedBox(
                width: 335.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _SettingsButton(
                      onTap: () {},
                      width: 158.w,
                      content: "Privacy Policy",
                    ),
                    _SettingsButton(
                      onTap: () {},
                      width: 158.w,
                      content: "Terms of Use",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              _SettingsButton(
                onTap: () {},
                content: "Support",
              ),
            ],
          ),
        );
      },
    );
  }

  void _toPremium(BuildContext context) {
    final route = MaterialPageRoute(
      builder: (BuildContext context) {
        return const PremiumScreen();
      },
    );
    Navigator.push(context, route);
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton({
    Key? key,
    required this.content,
    this.onTap,
    this.width,
  }) : super(key: key);

  final String content;
  final VoidCallback? onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 335.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: ThemeHelper.blue,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Center(
          child: Text(
            content,
            style: TextStyleHelper.helper8,
          ),
        ),
      ),
    );
  }
}
