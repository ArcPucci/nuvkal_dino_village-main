import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuvkal_dino_village/bloc/blocs.dart';
import 'package:nuvkal_dino_village/utils/utils.dart';
import 'package:nuvkal_dino_village/widgets/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedPlayerSkin = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, state) {
        final points = state.points;
        final playerSkin = playerSkins[selectedPlayerSkin];
        final canChoose = state.skins.contains(playerSkin);
        final canBuy = playerSkin.cost <= points && !canChoose;
        final chosen = state.playerSkin == playerSkin;
        return BackgroundWidget(
          child: Column(
            children: [
              CustomAppBar(
                coins: state.points,
                onTapLeft: () => context.go("/shop_screen"),
                onTapRight: () => context.go("/settings_screen"),
              ),
              Spacer(),
              CarouselSlider.builder(
                itemCount: playerSkins.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return Image.asset(
                    playerSkins[index].asset,
                    fit: BoxFit.fitHeight,
                  );
                },
                carouselController: _controller,
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    selectedPlayerSkin = index;
                    setState(() {});
                  },
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  enableInfiniteScroll: true,
                  height: 275.h,
                  viewportFraction: 0.6,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                playerSkins[selectedPlayerSkin].name,
                style: TextStyleHelper.helper4,
              ),
              SizedBox(height: 8.h),
              Opacity(
                opacity: 0.7,
                child: SizedBox(
                  width: 343.w,
                  child: Text(
                    playerSkins[selectedPlayerSkin].description,
                    style: TextStyleHelper.helper5,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 80.h),
              SizedBox(
                width: 335.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CounterButton(
                      onTap: onPrev,
                    ),
                    CounterButton(
                      onTap: onNext,
                      isNextButton: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              CustomButton(
                onTap: () {
                  if (chosen) {
                    context.go("/level_screen");
                  } else if(canChoose) {
                    context.read<ConfigBloc>().add(
                      SelectPlayerSkin(playerSkin),
                    );
                    context.go("/level_screen");
                  } else if(canBuy) {
                    context.read<ConfigBloc>().add(
                      SelectPlayerSkin(playerSkin),
                    );
                  }
                },
                hasIcon: !canChoose && !chosen,
                content: chosen
                    ? "PLAY"
                    : canChoose
                        ? "CHOOSE AND PLAY"
                        : "${playerSkin.cost}",
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    );
  }

  void onNext() =>
      _controller.nextPage(duration: const Duration(milliseconds: 300));

  void onPrev() =>
      _controller.previousPage(duration: const Duration(milliseconds: 300));
}
