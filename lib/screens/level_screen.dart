import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuvkal_dino_village/bloc/blocs.dart';
import 'package:nuvkal_dino_village/utils/levels.dart';
import 'package:nuvkal_dino_village/utils/text_style_helper.dart';
import 'package:nuvkal_dino_village/widgets/background_widget.dart';
import 'package:nuvkal_dino_village/widgets/counter_button.dart';
import 'package:nuvkal_dino_village/widgets/custom_app_bar.dart';
import 'package:nuvkal_dino_village/widgets/custom_button.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  final CarouselController _controller = CarouselController();

  int selectedLevel = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return BlocBuilder<ConfigBloc, ConfigState>(
          builder: (context, configState) {
            return BackgroundWidget(
              child: Column(
                children: [
                  CustomAppBar(
                    onTapLeft: () => context.pop(),
                    isBackButton: true,
                    coins: configState.points,
                  ),
                  SizedBox(height: 40.h),
                  CarouselSlider.builder(
                    itemCount: levels.length,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return Image.asset(
                        levels[index].asset,
                        fit: BoxFit.fitHeight,
                      );
                    },
                    carouselController: _controller,
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        selectedLevel = index;
                        setState(() {});
                      },
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.scale,
                      height: 343.h,
                      viewportFraction: 0.6,
                    ),
                  ),
                  Text(
                    levels[selectedLevel].name,
                    style: TextStyleHelper.helper4,
                  ),
                  SizedBox(height: 8.h),
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      levels[selectedLevel].description,
                      style: TextStyleHelper.helper5,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 335.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CounterButton(
                          onTap: onPrev,
                          enabled: selectedLevel > 0,
                        ),
                        CounterButton(
                          onTap: onNext,
                          enabled: selectedLevel == 0,
                          isNextButton: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CustomButton(
                    onTap: () {
                      context.read<GameBloc>().add(
                            SelectLevelGameEvent(
                              levels[selectedLevel],
                            ),
                          );
                      context.go("/level_screen/game_screen");
                    },
                    content: "PLAY",
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void onNext() =>
      _controller.nextPage(duration: const Duration(milliseconds: 300));

  void onPrev() =>
      _controller.previousPage(duration: const Duration(milliseconds: 300));
}
