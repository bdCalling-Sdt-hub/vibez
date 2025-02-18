import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_themes/app_themes.dart';
import 'core/app_routes/app_routes.dart';
import 'helpers/dependancy_injaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection di = DependencyInjection();
  di.dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) =>  MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: Themes().darkTheme,
        darkTheme: Themes().darkTheme,
        routeInformationParser: AppRoutes.goRouter.routeInformationParser,
        routeInformationProvider: AppRoutes.goRouter.routeInformationProvider,
        routerDelegate: AppRoutes.goRouter.routerDelegate,
      ),
    );
  }
}
