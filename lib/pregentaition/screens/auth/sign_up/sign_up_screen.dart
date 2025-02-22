import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/controllers/auth_controller.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/core/widgets/custom_text.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';
import 'package:seth/helpers/toast_message_helper.dart';

import '../log_in/log_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController passWordCtrl = TextEditingController();
  final TextEditingController phoneNumberCtrl = TextEditingController();
  final TextEditingController confirmPassCtrl = TextEditingController();
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  AuthController authController = Get.find<AuthController>();
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Form(
            key: fromKey,
            child: Column(
              children: [

                SizedBox(height: 131.h),

                ///==================App Logo ===============>>>

                Assets.images.applogo.image(),


                ///================Create Account=============>>>

                CustomText(
                  text: "Create Account",
                  top: 24.h,
                  fontsize: 28.h,
                  fontWeight: FontWeight.w600,
                ),


                CustomText(
                  top: 4.h,
                  bottom: 24.h,
                  text: "Join the community and find your event vibe!",
                  color: AppColors.textColor808080,
                ),



                ///==============name Field============<>>>>

                CustomTextFieldWithLavel(
                  controller: nameCtrl,
                  hinText: "Enter your name",
                  laval: "Name",
                ),




                ///==============Email Field============<>>>>

                CustomTextFieldWithLavel(
                  controller: emailCtrl,
                  isEmail: true,
                  hinText: "Enter your email address",
                  laval: "Email Address",
                ),



                ///==============Enter your phone number===========<>>>>

                CustomTextFieldWithLavel(
                  controller: phoneNumberCtrl,
                  hinText: "Enter your phone number",
                  laval: "Phone Number",
                  keyboardType: TextInputType.number,
                ),



                ///==============Password Field============<>>>>

                CustomTextFieldWithLavel(
                  controller: passWordCtrl,
                  hinText: "Enter your password",
                  laval: "Password",
                  isPassword: true,
                ),



                ///================Confirm password ================>>>

                CustomTextFieldWithLavel(
                  laval: "Confirm password",
                  hinText: "Enter you Confirm password",
                  isPassword: true,
                  controller: confirmPassCtrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value != passWordCtrl.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },

                ),





                ///================Forget Password============>>>>

                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [

                      Checkbox(
                        value: isCheck,
                        onChanged: (value) {
                          isCheck = !isCheck;
                          setState(() {});
                        },
                        checkColor: Colors.white,
                        side: const BorderSide(width: 0.5),
                        fillColor:  WidgetStatePropertyAll(isCheck ? Colors.blueAccent  : Colors.white),
                        activeColor: Colors.blue,
                      ),

                      CustomText(
                        top: 24.h,
                        bottom: 24.h,
                        text: "I Agree to all the term and conditions.",
                        fontsize: 16.h,
                        color: AppColors.textColor808080,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),





                ///=====================Log in Button================>>>

                Obx(() =>
                   CustomButton(
                     loading: authController.signUpLoading.value,
                      width: double.infinity,
                      title: "Sign Up", onpress: (){
                    if(fromKey.currentState!.validate()){
                      if(isCheck){
                        authController.handleSignUp(
                            context: context,
                            name: nameCtrl.text,
                            email: emailCtrl.text,
                            phone: phoneNumberCtrl.text,
                            password: passWordCtrl.text.trim()
                        );
                      }else{
                        ToastMessageHelper.showToastMessage("Please Check term and conditions!");
                      }
                    }
                  }),
                ),



                ///=================Do you have Account================>>>

                SizedBox(height: 24.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Alreadu have an account?",
                      fontsize: 16.h,
                    ),

                    GestureDetector(
                      onTap: (){
                        context.pushNamed(AppRoutes.loginScreen);
                      },
                      child: CustomText(
                        text: " Log In",
                        fontsize: 16.h,
                        color: const Color(0xffFF6F61),
                      ),
                    ),
                  ],
                ),


                SizedBox(height: 50.h)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
