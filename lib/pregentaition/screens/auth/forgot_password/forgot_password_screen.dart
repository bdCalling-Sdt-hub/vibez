import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/core/widgets/custom_text.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../log_in/log_in_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailCtrl = TextEditingController();
  final GlobalKey<FormState> _logKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Form(
            key: _logKey,
            child: Column(
              children: [

                SizedBox(height: 131.h),

                ///==================App Logo ===============>>>

                Assets.images.applogo.image(),


                ///================Forgot Passwprd=============>>>

                CustomText(
                  text: "Forgot Password",
                  top: 24.h,
                  fontsize: 28.h,
                  fontWeight: FontWeight.w600,
                ),


                CustomText(
                  top: 4.h,
                  bottom: 24.h,
                  text: "Please check email and enter the pin",
                  color: AppColors.textColor808080,
                ),



                ///==============Email Field============<>>>>

                CustomTextFieldWithLavel(
                  controller: emailCtrl,
                  isEmail: true,
                  hinText: "Enter your email address",
                  laval: "Email Address",
                ),



                SizedBox(height: 300.h),



                ///=====================Sign UP Button================>>>

                CustomButton(
                    width: double.infinity,
                    title: "Send Code", onpress: (){
                  // if(_logKey.currentState!.validate()){
                  context.pushNamed(AppRoutes.otpScreen, extra: "Forgot Password");
                  // }
                }),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

