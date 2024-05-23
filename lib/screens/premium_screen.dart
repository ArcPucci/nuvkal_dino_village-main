import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuvkal_dino_village/bloc/blocs.dart';
import 'package:nuvkal_dino_village/utils/utils.dart';
import 'package:nuvkal_dino_village/widgets/custom_button.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/png/backgrounds/premium_background.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 56.w,
                        height: 56.h,
                        color: Colors.transparent,
                        child: Center(
                          child: SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: Image.asset(
                              "assets/png/icons/close.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                    onTap: () => _onBuyPremium(context),
                    content: "GET PREMIUM FOR \$0.99",
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: 343.w,
                    child: Opacity(
                      opacity: 0.7,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              overlayColor: MaterialStateProperty.all(
                                Colors.transparent,
                              ),
                              child: Text(
                                "TERMS OF USE",
                                style: TextStyleHelper.helper2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () => _onBuyPremium(context),
                              overlayColor: MaterialStateProperty.all(
                                Colors.transparent,
                              ),
                              child: Text(
                                "RESTORE",
                                style: TextStyleHelper.helper2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "PRIVACY POLICY",
                              style: TextStyleHelper.helper2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> _launchUrl(Uri url) async {
  //   if (!await launchUrl(url)) {
  //     throw "Could not launch $url";
  //   }
  // }

  _onBuyPremium(BuildContext context) {
    context.read<ConfigBloc>().add(
      BuyPremiumConfigEvent(),
    );
    Navigator.pop(context);
  }
}
