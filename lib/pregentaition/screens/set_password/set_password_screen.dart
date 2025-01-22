import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/core/widgets/custom_text.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../log_in/log_in_screen.dart';

class SetPasswordScreen extends StatelessWidget {
  SetPasswordScreen({super.key});




  final TextEditingController passWordCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();


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
                ),



                ///==============Enter your new password againr===========<>>>>

                CustomTextFieldWithLavel(
                  controller: confirmCtrl,
                  hinText: "Enter your new password again",
                  laval: "Confirm New Password",
                  keyboardType: TextInputType.number,
                ),




                ///=====================Log in Button================>>>

                CustomButton(
                    width: double.infinity,
                    title: "Login", onpress: (){
                  if(fromKey.currentState!.validate()){
                    print("log in");
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
