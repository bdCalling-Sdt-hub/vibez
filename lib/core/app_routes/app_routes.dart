
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/utils/app_constants.dart';
import 'package:seth/helpers/prefs_helper.dart';
import 'package:seth/pregentaition/screens/profile/profile_screen.dart';
import 'package:seth/pregentaition/screens/rating_screen/rating_screen.dart';
import '../../models/cetegory_model.dart';
import '../../pregentaition/screens/Manager/create_event/create_event_screen.dart';
import '../../pregentaition/screens/Manager/events/manager_events_screen.dart';
import '../../pregentaition/screens/Manager/manager_all_events/manager_all_event_screen.dart';
import '../../pregentaition/screens/Manager/manager_home/manager_home_screen.dart';
import '../../pregentaition/screens/all_event/all_event_screen.dart';
import '../../pregentaition/screens/auth/change_password/change_password_screen.dart';
import '../../pregentaition/screens/auth/forgot_password/forgot_password_screen.dart';
import '../../pregentaition/screens/auth/log_in/log_in_screen.dart';
import '../../pregentaition/screens/auth/manager_sign_up_screen/manager_sign_up_screen.dart';
import '../../pregentaition/screens/auth/onboarding/onboarding_screen.dart';
import '../../pregentaition/screens/auth/otp_screen/otp_screen.dart';
import '../../pregentaition/screens/auth/role_screen/role_screen.dart';
import '../../pregentaition/screens/auth/set_password/set_password_screen.dart';
import '../../pregentaition/screens/auth/sign_up/sign_up_screen.dart';
import '../../pregentaition/screens/book_mard_favarite_screen/book_mark_favarite_screen.dart';
import '../../pregentaition/screens/book_mard_favarite_screen/book_mark_screen.dart';
import '../../pregentaition/screens/event_details/event_details.dart';
import '../../pregentaition/screens/filter/filter_screen.dart';
import '../../pregentaition/screens/notification/notification_screen.dart';
import '../../pregentaition/screens/privacy_all/privacy_all_screen.dart';
import '../../pregentaition/screens/profile/edit_profile_screen.dart';
import '../../pregentaition/screens/setting/setting_screen.dart';
import '../../pregentaition/screens/splash/splash_screen.dart';
import '../../pregentaition/screens/user/events_in_your_area/events_in_your_are_screen.dart';
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
  static const String profileScreen = "/ProfileScreen";
  static const String changePasswordScreen = "/ChangePasswordScreen";
  static const String privacyAllScreen = "/PrivacyAllScreen";
  static const String bookMarkFavariteScreen = "/BookMarkFavariteScreen";
  static const String bookMarkScreen = "/BookMarkScreen";
  static const String filterScreen = "/FilterScreen";
  static const String editProfileScreen = "/EditProfileScreen";
  static const String eventDetails = "/EventDetails";
  static const String ratingScreen = "/RatingScreen";
  static const String eventsInYourAreScreen = "/EventsInYourAreScreen";
  static const String managerHomeScreen = "/ManagerHomeScreen";
  static const String managerEventsScreen = "/ManagerEventsScreen";
  static const String createEventScreen = "/CreateEventScreen";
  static const String managerAllEventScreen = "/ManagerAllEventScreen";
  static const String notificationScreen = "/NotificationScreen";
  static const String allEventScreen = "/AllEventScreen";



  static final GoRouter goRouter = GoRouter(
      initialLocation: splashScreen,
      routes: [
        ///===================Splash Screen=================>>>
        GoRoute(
          path: splashScreen,
          name: splashScreen,
          builder: (context, state) =>const SplashScreen(),
          redirect: (context, state) {
            Future.delayed(const Duration(seconds: 3), ()async{
              String role = await PrefsHelper.getString(AppConstants.role);
              String token = await PrefsHelper.getString(AppConstants.bearerToken);

              if(token.isNotEmpty){
                if(role == "user"){
                  AppRoutes.goRouter.replaceNamed(AppRoutes.userHomeScreen);
                }else{
                  AppRoutes.goRouter.replaceNamed(AppRoutes.managerHomeScreen);
                }
              }else{
                AppRoutes.goRouter.replaceNamed(AppRoutes.onboardingScreen);
              }


            });
            return null;
          },
        ),

        ///=========Log in Screen========>>

        GoRoute(
          path: loginScreen,
          name: loginScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( LogInScreen(), state),
        ),


       ///=========On Boarding Screen========>>
       GoRoute(
          path: onboardingScreen,
          name: onboardingScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( OnboardingScreen(), state),
        ),


        ///=========Role Screen========>>
       GoRoute(
          path: roleScreen,
          name: roleScreen,
          pageBuilder: (context, state) =>  _customTransitionPage(RoleScreen(), state),
        ),


        ///=========sign Up Screen========>>

        GoRoute(
          path: signUpScreen,
          name: signUpScreen,
          pageBuilder: (context, state) =>  _customTransitionPage( SignUpScreen(), state),
        ),


        ///=========Set Password Screen========>>

        GoRoute(
          path: setPasswordScreen,
          name: setPasswordScreen,
          pageBuilder: (context, state) =>  _customTransitionPage(SetPasswordScreen(), state),
        ),


        ///=========Forgot Password Screen========>>

        GoRoute(
          path: forgotPasswordScreen,
          name: forgotPasswordScreen,
          pageBuilder: (context, state) {
            String email = state.extra as String;
            return _customTransitionPage( ForgotPasswordScreen(email: email), state);
          },
        ),



        ///=========Otp Screen========>>

        GoRoute(
          path: otpScreen,
          name: otpScreen,
          pageBuilder: (context, state) {
            String screenType = state.extra as String;
            return _customTransitionPage(OtpScreen(screenType: screenType), state);
          }  ,
        ),


        ///=========Manager Sign up Screen========>>

        GoRoute(
          path: managerSignUpScreen,
          name: managerSignUpScreen,
          pageBuilder: (context, state) =>  _customTransitionPage(ManagerSignUpScreen(), state),
        ),



        ///=========User Home Screen========>>

        GoRoute(
          path: userHomeScreen,
          name: userHomeScreen,
          pageBuilder: (context, state) =>  _customTransitionPage(UserHomeScreen(), state),
        ),


        ///=========Setting Screen========>>

        GoRoute(
          path: settingScreen,
          name: settingScreen,
          pageBuilder: (context, state) =>  _customTransitionPage(SettingScreen(), state),
        ),


        ///=========Profile Screen========>>

        GoRoute(
          path: profileScreen,
          name: profileScreen,
          pageBuilder: (context, state) {
            final Map<String, dynamic> profileData = state.extra as Map<String, dynamic>? ?? {};
            return _customTransitionPage(ProfileScreen(profileData: profileData), state);
          },
        ),



        ///=========change password Screen========>>

        GoRoute(
          path: changePasswordScreen,
          name: changePasswordScreen,
          pageBuilder: (context, state) =>  _customTransitionPage(ChangePasswordScreen(), state),
        ),


        ///=========Privacy All Screen========>>

        GoRoute(
          path: privacyAllScreen,
          name: privacyAllScreen,
          pageBuilder: (context, state) {
           String title = state.extra as String;
            return _customTransitionPage(PrivacyAllScreen(title : title), state);
          },
        ),


        ///=========Privacy All Screen========>>

        GoRoute(
          path: bookMarkFavariteScreen,
          name: bookMarkFavariteScreen,
          pageBuilder: (context, state) {
            return _customTransitionPage(BookMarkFavariteScreen(), state);
          },
        ),


        ///========= book mark Screen========>>

        GoRoute(
          path: bookMarkScreen,
          name: bookMarkScreen,
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            String category = extra?["category"] as String;
            List<Filter> filter = extra?["filter"] as List<Filter>;
            return _customTransitionPage( BookMarkScreen(category : category, filter: filter), state);
          },
        ),


        ///=========filter Screen========>>

        GoRoute(
          path: filterScreen,
          name: filterScreen,
          pageBuilder: (context, state) {
             List<Filter> filter = state.extra as List<Filter>;
             return _customTransitionPage( FilterScreen(filter: filter), state);
          },
        ),



        ///=========Edit Profile Screen========>>

        GoRoute(
          path: editProfileScreen,
          name: editProfileScreen,
          pageBuilder: (context, state) {
            final Map<String, dynamic> profileData = state.extra as Map<String, dynamic>? ?? {};
            return _customTransitionPage( EditProfileScreen(profileData: profileData), state);
          },
        ),


        ///=========Event Screen========>>

        GoRoute(
          path: eventDetails,
          name: eventDetails,
          pageBuilder: (context, state) {
            String id = state.extra as String;
            return _customTransitionPage( EventDetails(id: id), state);
          },
        ),



        ///=========rating Screen========>>

        GoRoute(
          path: ratingScreen,
          name: ratingScreen,
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?; // Extra data as Map
            final String category = extra?['category'] ?? '';
            final String eventId = extra?['eventId'] ?? '';
            return _customTransitionPage( RatingScreen(category: category, eventId: eventId), state);
          },
        ),



        ///=========rating Screen========>>

        GoRoute(
          path: eventsInYourAreScreen,
          name: eventsInYourAreScreen,
          pageBuilder: (context, state) {
            String title = state.extra as String;
            return _customTransitionPage( EventsInYourAreScreen(title: title), state);
          },
        ),




        ///=========manager home  Screen========>>

        GoRoute(
          path: managerHomeScreen,
          name: managerHomeScreen,
          pageBuilder: (context, state) {
            return _customTransitionPage( ManagerHomeScreen(), state);
          },
        ),



        ///=========Manager Events Screen========>>

        GoRoute(
          path: managerEventsScreen,
          name: managerEventsScreen,
          pageBuilder: (context, state) {
            String title = state.extra as String;
            return _customTransitionPage(ManagerEventsScreen(title: title), state);
          },
        ),

        ///=========Manager Events Screen========>>

        GoRoute(
          path: createEventScreen,
          name: createEventScreen,
          pageBuilder: (context, state) {
            String title = state.extra as String;
            return _customTransitionPage(CreateEventScreen(title: title), state);
          },
        ),



        ///=========Manager Events Screen========>>

        GoRoute(
          path: managerAllEventScreen,
          name: managerAllEventScreen,
          pageBuilder: (context, state) {
            return _customTransitionPage(ManagerAllEventScreen(), state);
          },
        ),



        ///=========Manager Events Screen========>>



        GoRoute(
          path: notificationScreen,
          name: notificationScreen,
          pageBuilder: (context, state) {
            return _customTransitionPage(const NotificationScreen(), state);
          },
        ),




        ///=========Manager Events Screen========>>

        GoRoute(
          path: allEventScreen,
          name: allEventScreen,
          pageBuilder: (context, state) {
            String category = state.extra as String;
            return _customTransitionPage(AllEventScreen(category: category), state);
          },
        ),


      ]
  );


 static Page<dynamic> _customTransitionPage(Widget child, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

}