import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_text.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

        ///===================Back Ground Image=================>>>

        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/onboardingImage.png'),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 140.h),
            
            
                ///===========Welcome to app ===========>>>
            
                CustomText(text: "Welcome to", fontsize: 28.h, bottom: 8.h),
            
            
                ///=================App Logo Icon===========>>>
            
                Assets.images.applogo.image(),
                SizedBox(height: 180.h),
            
            
                ///===============Lets Vibe================>>>
            
                CustomText(text: "Let’s Vibe", fontsize: 32.h, bottom: 12.h),
            
            
                ///================Discover about app==========>>>
            
                CustomText(
                  maxline: 2,
                    text: "Discover the real vibe of events, from live videos to \n crowd reviews, before stepping out.",
                    fontsize: 14.h,
                    color: AppColors.textColor808080,
                    bottom: 12.h),
            
            
                SizedBox(height: 130.h),
            
            
                ///===================Next Button==============>>>
            
                GestureDetector(
                    onTap: (){
                      context.pushNamed(AppRoutes.roleScreen);
                    },
                    child: Assets.icons.button.svg())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
