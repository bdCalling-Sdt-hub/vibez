import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';
import '../../../../core/widgets/custom_text.dart';
import '../log_in/log_in_screen.dart';

class ChangePasswordScreen extends StatelessWidget {
   ChangePasswordScreen({super.key});

  final TextEditingController oldPassCtrl = TextEditingController();
  final TextEditingController newPassCtrl = TextEditingController();
  final TextEditingController confirmPassCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "Change Password", fontsize: 20.h),
      ),



      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
          
          
              ///================Old Pass ================>>>
          
              CustomTextFieldWithLavel(
                  lavalColor: Colors.white,
                  laval: "Old Password",
                  hinText: "Enter you old password",
                  isPassword: true,
                  leadingIcon: Assets.icons.password.svg(),
                  controller: oldPassCtrl),
          
          
              ///================New Pass ================>>>
          
              CustomTextFieldWithLavel(
                  lavalColor: Colors.white,
                  laval: "New Password",
                  hinText: "Enter you new password",
                  isPassword: true,
                  leadingIcon: Assets.icons.password.svg(),
                  controller: newPassCtrl),
          
          
          
          
          
              ///================Confirm password ================>>>
          
              CustomTextFieldWithLavel(
                 lavalColor: Colors.white,
                  laval: "Confirm password",
                  hinText: "Enter you Confirm password",
                  isPassword: true,
                  leadingIcon: Assets.icons.password.svg(),
                  controller: confirmPassCtrl),
          
          
          
          
              ///===================Button====================>>>
          
              SizedBox(height: 70.h),
              CustomButton(title: "Done", onpress: (){})
          
            ],
          ),
        ),
      ),

    );
  }
}
