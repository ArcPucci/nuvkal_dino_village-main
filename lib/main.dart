import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuvkal_dino_village/bloc/blocs.dart';
import 'package:nuvkal_dino_village/screens/screens.dart';
import 'package:nuvkal_dino_village/services/preference_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferenceService().init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runZonedGuarded(
      () => runApp(
            ScreenUtilInit(
              designSize: const Size(375, 812),
              builder: (BuildContext context, Widget? child) => MyApp(),
            ),
          ), (error, stack) {
    debugPrint(error.toString());
    debugPrintStack(stackTrace: stack);
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _goRouter = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (BuildContext context, GoRouterState state) {
          return MainScreen();
        },
        routes: [
          GoRoute(
            path: "level_screen",
            builder: (BuildContext context, GoRouterState state) {
              return LevelScreen();
            },
            routes: [
              GoRoute(
                path: "game_screen",
                builder: (BuildContext context, GoRouterState state) {
                  return GameScreen();
                },
                routes: [
                  GoRoute(
                    path: "jackpot_screen",
                    builder: (BuildContext context, GoRouterState state) {
                      return JackpotScreen();
                    },
                  ),
                ],
              )
            ],
          ),
          GoRoute(
            path: "shop_screen",
            builder: (BuildContext context, GoRouterState state) {
              return ShopScreen();
            },
          ),
          GoRoute(
            path: "settings_screen",
            builder: (BuildContext context, GoRouterState state) {
              return SettingsScreen();
            },
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PreferenceService(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return ConfigBloc(
                RepositoryProvider.of(context),
              )..add(InitConfigEvent());
            },
          ),
          BlocProvider(
            create: (context) {
              return GameBloc(
                BlocProvider.of(context),
              );
            },
          ),
          BlocProvider(
            create: (context) {
              return JackpotBloc(
                BlocProvider.of(context),
              );
            },
          ),
        ],
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          routerDelegate: _goRouter.routerDelegate,
          routeInformationParser: _goRouter.routeInformationParser,
          routeInformationProvider: _goRouter.routeInformationProvider,
        ),
      ),
    );
  }
}
