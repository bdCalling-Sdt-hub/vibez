 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/controllers/auth_controller.dart';
import 'package:seth/core/utils/app_constants.dart';
import 'package:seth/helpers/prefs_helper.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text.dart';


 customDialog(BuildContext context){
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 24.w, vertical: 26.h),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [



                CustomText(
                  text: "Sign Up Now",
                  fontsize: 23.h,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                  top: 16.h,
                  bottom: 8.h,
                ),


                CustomText(
                  text: "To access all the features signup as a user.",
                  color: Colors.black,
                  fontsize: 14.h,
                  maxline: 2,
                ),

               SizedBox(height: 24.h),
                Divider(color: Colors.red, height: 0.05.h),


                SizedBox(height: 24.h),

                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomButton(
                          loaderIgnore: false,
                          color: Colors.transparent,
                          titlecolor: AppColors.primaryColor,
                          title: "No", onpress: (){
                            context.pop();
                      }),
                    ),


                    SizedBox(width: 20.w),

                    Expanded(
                      flex: 1,
                      child: CustomButton(
                          loaderIgnore: false,
                          color: AppColors.primaryColor,
                          titlecolor: Colors.white,
                          title: "Yes", onpress: ()async{
                            await PrefsHelper.remove(AppConstants.role);
                        context.go(AppRoutes.roleScreen);
                      }),
                    ),
                  ],
                )

              ],
            ),
            elevation: 12.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: BorderSide(
                    width: 1.w, color: AppColors.primaryColor)));
      });
}
