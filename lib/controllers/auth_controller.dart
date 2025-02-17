import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../core/app_routes/app_routes.dart';
import '../core/utils/app_constants.dart';
import '../helpers/prefs_helper.dart';
import '../helpers/toast_message_helper.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';


class AuthController extends GetxController {
  ///************************************************************************///

  RxBool signUpLoading = false.obs;

  ///===============Sing up ================<>
  handleSignUp({String? name, email, phone, password, required BuildContext context}) async {
    String role = await PrefsHelper.getString(AppConstants.role);
    signUpLoading(true);
    var body = {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "role": role == "user" ? "user" : "manager"
    };

    var response = await ApiClient.postData(ApiConstants.signUpEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      context.pushNamed(AppRoutes.otpScreen, extra: "Sign Up");
      ToastMessageHelper.showToastMessage("Account create successful.\n \nNow you have an one time code your email");
      signUpLoading(false);
    } else if(response.statusCode == 1){
      signUpLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      signUpLoading(false);
    }
  }

  ///************************************************************************///

  ///===============Verify Email================<>
  RxBool verfyLoading = false.obs;

  verfyEmail(String otpCode, {String screenType = '', required BuildContext context}) async {
    verfyLoading(true);
    var role = await PrefsHelper.getString(AppConstants.role);
    var body = {"code": otpCode};

    var response = await ApiClient.postData(
        ApiConstants.verifyEmailEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("==========bearer token save done : ${response.body['token']}");
      await PrefsHelper.setString(AppConstants.bearerToken, response.body['token']);
      if (screenType == 'Sign Up') {
        ///=============If role is user go to user home screen else go to manager home screen============>>>
        if(role == "user"){
          context.go(AppRoutes.loginScreen);
        }else{
          context.go(AppRoutes.loginScreen);
        }
      }else if(screenType == "user"){
        context.go(AppRoutes.loginScreen);
      }else if(screenType == "manager"){
        context.go(AppRoutes.loginScreen);
      } else {
        context.go(AppRoutes.setPasswordScreen);
      }
      verfyLoading(false);
    } else if(response.statusCode == 1){
      verfyLoading(false);
      // ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    }
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      verfyLoading(false);

  }





  ///************************************************************************///
  ///===============Log in================<>
  RxBool logInLoading = false.obs;
  handleLogIn(String email, String password, {required BuildContext context}) async {
    logInLoading.value = true;
    var headers = {'Content-Type': 'application/json'};
    var body = {
      "email": email,
      "password": password,
    };
    var response = await ApiClient.postData(
        ApiConstants.signInEndPoint, jsonEncode(body),
        headers: headers);
    print("========================${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = response.body['data']["user"];
      await PrefsHelper.setString(AppConstants.role, data['role']);
      await PrefsHelper.setString(AppConstants.bearerToken, response.body["data"]['token']);
      await PrefsHelper.setString(AppConstants.email, email);
      await PrefsHelper.setString(AppConstants.name, data['name']);
      await PrefsHelper.setString(AppConstants.image, data['image']["publicFileURL"]);

      await PrefsHelper.setString(AppConstants.userId, data['_id']);
      await PrefsHelper.setBool(AppConstants.isLogged, true);

      var role = data['role'];

      if (role == "user") {
        context.go(AppRoutes.userHomeScreen);
      }else{
        context.go(AppRoutes.managerHomeScreen);
      }
      ToastMessageHelper.showToastMessage('Your are logged in');
      logInLoading(false);
    } else if(response.statusCode == 1){
      logInLoading(false);
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
    }else{
      ///******** When user do not able to verify their account thay have to verify there account then they can go to the app********
      if (response.body["message"] == "We've sent an OTP to your email to verify your profile.") {
        var role = response.body["data"]["role"];
        context.go(AppRoutes.otpScreen, extra: "$role");
        ToastMessageHelper.showToastMessage("We've sent an OTP to your email to verify your profile.");
      }else if(response.body["message"] == "⛔ Wrong password! ⛔"){
        ToastMessageHelper.showToastMessage(response.body["message"]);
      }
      logInLoading(false);
      ToastMessageHelper.showToastMessage(response.body['message']);
    }
  }



  ///************************************************************************///


  ///===============Forgot Password================<>
  RxBool forgotLoading = false.obs;

  handleForgot(String email, screenType, {required BuildContext context}) async {
    forgotLoading(true);
    var body = {"email": email};
    var response = await ApiClient.postData(
        ApiConstants.forgotPasswordPoint, jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {

      if(screenType == "forgot"){
        context.pushNamed(AppRoutes.forgotPasswordScreen, extra: email.toString());
      }

      forgotLoading(false);
    }  else {
      forgotLoading(false);
      ToastMessageHelper.showToastMessage(response.body["message"]);
    }
  }


  ///===============Set Password================<>

  RxBool setPasswordLoading = false.obs;

  setPassword(String password) async {
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    setPasswordLoading(true);
    var body = {
      "token": bearerToken.toString(),
      "password": password.toString().trim()
    };

    var response = await ApiClient.postData(
        ApiConstants.setPasswordEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.offAllNamed(AppRoutes.loginScreen);
      ToastMessageHelper.showToastMessage('Password Changed');
      print("======>>> successful");
      setPasswordLoading(false);
    } else if(response.statusCode == 1){
      setPasswordLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      setPasswordLoading(false);
    }
  }


  ///===============Resend================<>


  RxBool resendLoading = false.obs;

  reSendOtp(String email) async {
    resendLoading(true);
    var body = {"email": email};

    var response = await ApiClient.postData(
        ApiConstants.resendOtpEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage(
          'You have got an one time code to your email');
      print("======>>> successful");
      resendLoading(false);
    }else{
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      resendLoading(false);
    }
  }


  ///===============Change Password================<>

  RxBool changePasswordLoading = false.obs;
  changePassword(String oldPassword, newPassword) async {
    changePasswordLoading(true);
    var body = {"oldPassword": "$oldPassword", "newPassword": "$newPassword"};

    var response =
    await ApiClient.postData(ApiConstants.changePassword, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage('Password Changed Successful');
      print("======>>> successful");
      changePasswordLoading(false);
    } else if(response.statusCode == 1){
      changePasswordLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      ToastMessageHelper.showToastMessage(response.body['message']);
      changePasswordLoading(false);
    }
  }






  final RxInt countdown = 60.obs;
  final RxBool isCountingDown = false.obs;


  void startCountdown() {
    isCountingDown.value = true;
    countdown.value = 60;
    update();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
        update();
      } else {
        timer.cancel();
        isCountingDown.value = false;
        update();
      }
    });
  }



}
