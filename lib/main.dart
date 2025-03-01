import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seth/core/widgets/no_inter_net_screen.dart';
import 'package:seth/services/firebase_notification_services.dart';
import 'package:seth/services/socket_services.dart';

import 'app_themes/app_themes.dart';
import 'core/app_routes/app_routes.dart';
import 'helpers/dependancy_injaction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance;

  // Socket initialization properly
  SocketServices.init();
  SocketServices();

  // Print FCM Token
  await FirebaseNotificationService.printFCMToken();
  await FirebaseNotificationService.initialize();

  // Dependency Injection
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
        builder: (context, child) {
          return Scaffold(body: NoInterNetScreen(child: child!));
        },
      ),
    );
  }
}
