import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/core/widgets/custom_text.dart';
import 'package:seth/core/widgets/custom_text_field.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';
import 'package:seth/helpers/toast_message_helper.dart';

import '../../../../controllers/auth_controller.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passWordCtrl = TextEditingController();

  final GlobalKey<FormState> _logKey = GlobalKey<FormState>();
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Form(
            key: _logKey,
            child: Column(
              children: [
                SizedBox(height: 131.h),

                ///==================App Logo ===============>>>

                Assets.images.applogo.image(),

                ///================WelCome=============>>>

                CustomText(
                  text: "Welcome",
                  top: 24.h,
                  fontsize: 28.h,
                  fontWeight: FontWeight.w600,
                ),

                CustomText(
                  top: 4.h,
                  bottom: 24.h,
                  text: "Login to continue!",
                  color: AppColors.textColor808080,
                ),

                ///==============Email Field============<>>>>

                CustomTextFieldWithLavel(
                  controller: emailCtrl,
                  isEmail: true,
                  hinText: "Enter your email address",
                  laval: "Email Address",
                ),

                ///==============Password Field============<>>>>

                CustomTextFieldWithLavel(
                  controller: passWordCtrl,
                  hinText: "Enter your password",
                  laval: "Password",
                  isPassword: true,
                ),

                ///================Forget Password============>>>>

                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      if(emailCtrl.text.isEmpty){
                        ToastMessageHelper.showToastMessage("Please enter your email");
                      }else{
                        context.pushNamed(AppRoutes.forgotPasswordScreen, extra: emailCtrl.text);
                      }
                    },
                    child: CustomText(
                      top: 24.h,
                      bottom: 24.h,
                      text: "Forgot Password?",
                      fontsize: 16.h,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                ///=====================Sign UP Button================>>>

                CustomButton(
                  // loading: authController.logInLoading.value,
                    width: double.infinity,
                    title: "Login",
                    onpress: () {
                      if (_logKey.currentState!.validate()) {
                        authController.handleLogIn(
                            emailCtrl.text, passWordCtrl.text.trim(), context: context);
                      }
                    }),

                ///=================Do not have Account================>>>

                SizedBox(height: 24.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Don’t have an account? ",
                      fontsize: 16.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoutes.signUpScreen);
                      },
                      child: CustomText(
                        text: " Sign Up",
                        fontsize: 16.h,
                        color: const Color(0xffFF6F61),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldWithLavel extends StatelessWidget {
  final TextEditingController controller;
  final String? hinText;
  final String? laval;
  final Color? lavalColor;
  final bool? isEmail;
  final int? maxLine;
  final bool isPassword;
  final FormFieldValidator? validator;
  final TextInputType? keyboardType;
  final Widget? leadingIcon;

  const CustomTextFieldWithLavel({
    super.key,
    required this.controller,
    this.hinText,
    this.laval,
    this.validator,
    this.isEmail = false,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.leadingIcon,
    this.lavalColor,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          bottom: 4.h,
          top: 24.h,
          text: "$laval",
          color: lavalColor ?? AppColors.textColor808080,
        ),
        CustomTextField(
          maxLine: maxLine ?? 1,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: leadingIcon ?? null,
          ),
          controller: controller,
          hintText: "$hinText",
          validator: validator ?? null,
          isEmail: isEmail,
          isPassword: isPassword,
          keyboardType: keyboardType,
        )
      ],
    );
  }
}
