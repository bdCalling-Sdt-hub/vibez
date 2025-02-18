import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/core/widgets/custom_text.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../../../../controllers/auth_controller.dart';


class OtpScreen extends StatelessWidget {
  final String screenType;
  OtpScreen({super.key, required this.screenType});

  final TextEditingController otpCtrl = TextEditingController();
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 70.h),

              ///==================App Logo ===============>>>

              Assets.images.applogo.image(),


              ///================Verify Email=============>>>

              CustomText(
                text: screenType == "Sign Up" || screenType == "user" || screenType == "manager" ? "Verify Email" : "Forgot Password",
                top: 24.h,
                fontsize: 28.h,
                fontWeight: FontWeight.w600,
              ),


              CustomText(
                top: 4.h,
                bottom: 24.h,
                text:  screenType == "Sign Up" || screenType == "user" || screenType == "manager" ? "Please check email and enter the pin" : "Enter OTP",
                color: AppColors.textColor808080,
              ),




              ///==============Pin code Field============<>>>>

              CustomPinCodeTextField(textEditingController: otpCtrl),

              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerRight,
                child: Obx(() => GestureDetector(
                  onTap: authController.isCountingDown.value
                      ? null
                      : () {
                    authController.startCountdown();
                    authController.reSendOtp();
                  },
                  child: CustomText(
                    text: authController.isCountingDown.value
                        ? 'Resend in ${authController.countdown.value}s'
                        : 'Resend code',
                    color: authController.isCountingDown.value
                        ? Colors.red
                        : AppColors.primaryColor,
                    fontsize: 12.sp,
                  ),
                )),
              ),


              SizedBox(height: 200.h),

              ///=====================Sign UP Button================>>>

              CustomButton(
                  width: double.infinity,
                  title: screenType == "Sign Up" || screenType == "user" || screenType == "manager" ? "Verify" : "Change Password", onpress: (){
                    if(screenType == "Sign Up"){
                      authController.verfyEmail(otpCtrl.text, screenType: "Sign Up", context: context);
                    }else if(screenType == "user"){
                      authController.verfyEmail(otpCtrl.text, screenType: "user", context: context);
                    }else if(screenType == "manager"){
                      authController.verfyEmail(otpCtrl.text, screenType: "manager", context: context);
                    } else{
                      authController.verfyEmail(otpCtrl.text, screenType: "forgot", context: context);
                    }
              }),


            ],
          ),
        ),
      ),
    );
  }
}


class CustomPinCodeTextField extends StatelessWidget {
  const CustomPinCodeTextField({super.key, this.textEditingController});
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: textEditingController,
      length: 6,
      defaultPinTheme: PinTheme(
        width: 120.w,
        height: 60.h,
        textStyle: const TextStyle(color: Colors.black, fontSize: 20),
        decoration: BoxDecoration(
          color: const Color(0xffD3D3D3),
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      focusedPinTheme: PinTheme(
        width: 120.w,
        height: 60.h,
        textStyle: const TextStyle(color: Colors.black, fontSize: 20),
        decoration: BoxDecoration(
          color: AppColors.textColor808080,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primaryColor),
        ),
      ),
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 2,
            height: 20,
            color: AppColors.primaryColor,
          ),
        ],
      ),
      keyboardType: TextInputType.number,
      obscureText: false,
      autofocus: false,
      onChanged: (value) {},
    );
  }
}
