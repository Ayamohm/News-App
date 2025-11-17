import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/home_screen/bloc/home_bloc.dart';
import 'package:news_app/features/search_result_screen/search_bloc/search_bloc.dart';

import 'core/networking/dio_helper.dart';
import 'core/routing/router_generation_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  DioHelper.initDio();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale("ar")],
        path:
            'assets/translations',
        fallbackLocale: const Locale('ar'),
        child: MultiBlocProvider(
          providers: [
          BlocProvider(create: (_) => HomeBloc()..add(GetTopheadLinesEvent()),
          ),
            BlocProvider(create: (_)=>SearchBloc(),
            )
        ], child: const MyApp(),)),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'News App',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: RouterGenerationConfig.goRouter,
        );
      },
    );
  }
}
