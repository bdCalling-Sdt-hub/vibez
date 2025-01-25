
import 'package:go_router/go_router.dart';
import 'package:seth/pregentaition/screens/log_in/log_in_screen.dart';
import '../../pregentaition/screens/forgot_password/forgot_password_screen.dart';
import '../../pregentaition/screens/manager_sign_up_screen/manager_sign_up_screen.dart';
import '../../pregentaition/screens/onboarding/onboarding_screen.dart';
import '../../pregentaition/screens/otp_screen/otp_screen.dart';
import '../../pregentaition/screens/role_screen/role_screen.dart';
import '../../pregentaition/screens/set_password/set_password_screen.dart';
import '../../pregentaition/screens/setting/setting_screen.dart';
import '../../pregentaition/screens/sign_up/sign_up_screen.dart';
import '../../pregentaition/screens/splash/splash_screen.dart';
import '../../pregentaition/screens/user/user_home/user_home_screen.dart';


class AppRoutes {
  ///===================routes Path===================>>>

  static const String splashScreen = "/splashScreen";
  static const String loginScreen = "/loginScreen";
  static const String homeScreen = "/HomeScreen";
  static const String onboardingScreen = "/OnboardingScreen";
  static const String roleScreen = "/RoleScreen";
  static const String signUpScreen = "/SignUpScreen";
  static const String setPasswordScreen = "/SetPasswordScreen";
  static const String forgotPasswordScreen = "/ForgotPasswordScreen";
  static const String otpScreen = "/OtpScreen";
  static const String managerSignUpScreen = "/ManagerSignUpScreen";
  static const String userHomeScreen = "/UserHomeScreen";
  static const String settingScreen = "/SettingScreen";


  static final GoRouter goRouter = GoRouter(
      initialLocation: splashScreen,
      routes: [

        ///===================Splash Screen=================>>>
        GoRoute(
          path: splashScreen,
          name: splashScreen,
          builder: (context, state) =>const SplashScreen(),
          redirect: (context, state) {
            Future.delayed(const Duration(seconds: 3), (){
               AppRoutes.goRouter.replaceNamed(AppRoutes.onboardingScreen);
            });
            return null;
          },
        ),

        ///=========Log in Screen========>>

        GoRoute(
          path: loginScreen,
          name: loginScreen,
          builder: (context, state) =>  LogInScreen(),
        ),


       ///=========On Boarding Screen========>>
       GoRoute(
          path: onboardingScreen,
          name: onboardingScreen,
          builder: (context, state) =>  OnboardingScreen(),
        ),


        ///=========Role Screen========>>
       GoRoute(
          path: roleScreen,
          name: roleScreen,
          builder: (context, state) =>  RoleScreen(),
        ),


        ///=========sign Up Screen========>>

        GoRoute(
          path: signUpScreen,
          name: signUpScreen,
          builder: (context, state) =>  SignUpScreen(),
        ),


        ///=========Set Password Screen========>>

        GoRoute(
          path: setPasswordScreen,
          name: setPasswordScreen,
          builder: (context, state) =>  SetPasswordScreen(),
        ),


        ///=========Forgot Password Screen========>>

        GoRoute(
          path: forgotPasswordScreen,
          name: forgotPasswordScreen,
          builder: (context, state) =>  ForgotPasswordScreen(),
        ),



        ///=========Otp Screen========>>

        GoRoute(
          path: otpScreen,
          name: otpScreen,
          builder: (context, state) =>  OtpScreen(),
        ),


        ///=========Manager Sign up Screen========>>

        GoRoute(
          path: managerSignUpScreen,
          name: managerSignUpScreen,
          builder: (context, state) =>  ManagerSignUpScreen(),
        ),



        ///=========User Home Screen========>>

        GoRoute(
          path: userHomeScreen,
          name: userHomeScreen,
          builder: (context, state) =>  UserHomeScreen(),
        ),


        ///=========Setting Screen========>>

        GoRoute(
          path: settingScreen,
          name: settingScreen,
          builder: (context, state) =>  SettingScreen(),
        ),

      ]
  );
}