import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuvkal_dino_village/bloc/blocs.dart';
import 'package:nuvkal_dino_village/utils/pearl_skins.dart';
import 'package:nuvkal_dino_village/utils/treasures.dart';
import 'package:nuvkal_dino_village/widgets/background_widget.dart';
import 'package:nuvkal_dino_village/widgets/counter_button.dart';
import 'package:nuvkal_dino_village/widgets/custom_app_bar.dart';
import 'package:nuvkal_dino_village/widgets/custom_button.dart';
import 'package:nuvkal_dino_village/widgets/matrix_item.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int selectedPearl = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, state) {
        final points = state.points;
        final pearlSkin = pearlSkins[selectedPearl];
        final canChoose = state.pearlSkins.contains(pearlSkin.asset);
        final canBuy = pearlSkin.cost <= points && !canChoose;
        final chosen = state.pearlSkin == pearlSkin.asset;
        return BackgroundWidget(
          child: Column(
            children: [
              CustomAppBar(
                isBackButton: true,
                onTapLeft: () => context.pop(),
                coins: state.points,
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 16,
                  itemBuilder: (context, index) {
                    return MatrixItem(
                      isCollected: false,
                      basicAsset: pearlSkins[selectedPearl].asset,
                      treasureAsset: treasures[0].asset,
                    );
                  },
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 335.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CounterButton(
                      onTap: () {
                        selectedPearl--;
                        setState(() {});
                      },
                      enabled: selectedPearl > 0,
                    ),
                    CounterButton(
                      onTap: () {
                        selectedPearl++;
                        setState(() {});
                      },
                      enabled: selectedPearl < pearlSkins.length - 1,
                      isNextButton: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              CustomButton(
                onTap: () {
                  context.read<ConfigBloc>().add(
                        SelectPearlSkin(pearlSkin),
                      );
                },
                hasIcon: !chosen && !canChoose,
                enabled: (canBuy || canChoose) && !chosen,
                content: chosen
                    ? "CHOSEN"
                    : canChoose
                        ? "CHOOSE"
                        : "${pearlSkin.cost}",
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    );
  }
}
