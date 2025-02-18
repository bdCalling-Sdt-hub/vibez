import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/core/widgets/custom_text.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../../../../controllers/auth_controller.dart';
import '../log_in/log_in_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String email;
  ForgotPasswordScreen({super.key, required this.email});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  AuthController authController = Get.find<AuthController>();

  final GlobalKey<FormState> _logKey = GlobalKey<FormState>();


  @override
  void initState() {
    print("====================${widget.email}");
    setState(() {
      emailCtrl.text = widget.email;
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Form(
            key: _logKey,
            child: Column(
              children: [

                SizedBox(height: 70.h),

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



                SizedBox(height: 250.h),



                ///=====================Sign UP Button================>>>

                CustomButton(
                    width: double.infinity,
                    title: "Send Code", onpress: (){
                  if(_logKey.currentState!.validate()){
                    authController.handleForgot(emailCtrl.text, "forgot", context: context);
                  }
                }),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

