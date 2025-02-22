import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/core/widgets/custom_text.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../core/utils/app_constants.dart';
import '../log_in/log_in_screen.dart';

class SetPasswordScreen extends StatelessWidget {
  SetPasswordScreen({super.key});




  final TextEditingController passWordCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  AuthController authController = Get.find<AuthController>();


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


                ///================Set Up New Password=============>>>

                CustomText(
                  text: "Set Up New Password",
                  top: 24.h,
                  fontsize: 28.h,
                  fontWeight: FontWeight.w600,
                ),


                ///==============New Password Field============<>>>>

                CustomTextFieldWithLavel(
                  controller: passWordCtrl,
                  isPassword: true,
                  hinText: "Enter new password",
                  laval: "New Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 8 ||
                        !AppConstants.validatePassword(value)) {
                      return "Password: 8 characters min, letters & digits \nrequired";
                    }
                    return null;
                  },
                ),



                ///==============Enter your new password again===========<>>>>

                CustomTextFieldWithLavel(
                  controller: confirmCtrl,
                  isPassword: true,
                  hinText: "Enter your new password again",
                  laval: "Confirm New Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value != passWordCtrl.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),



                SizedBox(height: 160.h),

                ///=====================Log in Button================>>>

                Obx(() =>
                   CustomButton(
                     loading: authController.setPasswordLoading.value,
                      width: double.infinity,
                      title: "Set Password", onpress: (){
                    if(fromKey.currentState!.validate()){
                      authController.setPassword(passWordCtrl.text, context: context);

                    }
                  }),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
