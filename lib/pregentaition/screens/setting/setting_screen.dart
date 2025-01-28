import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/widgets/custom_network_image.dart';
import 'package:seth/core/widgets/custom_text.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "My Profile", fontsize: 20.h),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 10.h),

            GestureDetector(
              onTap: (){
                context.pushNamed(AppRoutes.profileScreen);
              },
              child: Row(
                children: [
                  CustomNetworkImage(
                      boxShape: BoxShape.circle,
                      imageUrl: "https://cdn.shopaccino.com/igmguru/products/flutter-igmguru_1527424732_l.jpg?v=476",
                      height: 86.h, width: 86.w
                  ),

                  SizedBox(width: 24.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Sagor Ahamed",fontsize: 20.h,fontWeight: FontWeight.w600),
                      CustomText(text: "sagor@gmail.com"),
                    ],
                  )
                ],
              ),
            ),



            CustomText(text: "Personal Info", top: 16.h),



            ///====================Personal Data==============>

            GestureDetector(
              onTap: (){
                context.pushNamed(AppRoutes.profileScreen);
              },
              child:  _customTile(
                  Assets.icons.person2.svg(),
                  Assets.icons.arrowRight.svg(),
                  "Personal Data"),
            ),



            ///==================Book marked events==============>>>

            GestureDetector(
              onTap: (){
                context.pushNamed(AppRoutes.bookMarkFavariteScreen);
              },
              child: _customTile(
                  Assets.icons.calander1.svg(),
                  Assets.icons.arrowRight.svg(),
                  "Bookmarked Events"),
            ),



            ///==============Change password===============>>>

            GestureDetector(
              onTap: (){
                context.pushNamed(AppRoutes.changePasswordScreen);
              },
              child:_customTile(
                  Assets.icons.changePass.svg(),
                  Assets.icons.arrowRight.svg(),
                  "Change Password")
            ),


            SizedBox(height: 20.h),
            CustomText(text: "Settings"),



            ///==============About app===============>>>


            GestureDetector(
              onTap: (){
                context.pushNamed(AppRoutes.privacyAllScreen, extra: "About Us");
              },
              child:    _customTile(
                  Assets.icons.about.svg(),
                  Assets.icons.arrowRight.svg(),
                  "About App"),
            ),




            ///==============Terms & Conditions===============>>>

            GestureDetector(
              onTap: (){
                context.pushNamed(AppRoutes.privacyAllScreen, extra: "Terms & Conditions");
              },
              child: _customTile(
                  Assets.icons.docFile.svg(),
                  Assets.icons.arrowRight.svg(),
                  "Terms & Conditions"),
            ),





            ///==============Privacy Policy===============>>>

            GestureDetector(
              onTap: (){
                context.pushNamed(AppRoutes.privacyAllScreen, extra: "Privacy Policy");
              },
              child: _customTile(
                  Assets.icons.docFile.svg(),
                  Assets.icons.arrowRight.svg(),
                  "Privacy Policy"),
            ),




            ///================Log Out================>>>>

            SizedBox(height: 18.5.h),
            GestureDetector(
              onTap: (){


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

                              Align(
                                alignment: Alignment.centerLeft,
                                  child: CustomText(text: "Logout", fontsize: 28.h, bottom: 20.h, color: Colors.black)),


                              Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                  text: "Are you sure you want to log out?",
                                  fontsize: 14.sp,
                                  color: Colors.black,
                                  maxline: 2,
                                ),
                              ),
                              SizedBox(height: 50.h),


                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: 180.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: 80.w,
                                          height: 40.h,
                                          child: CustomButton(
                                            title: 'No',
                                            fontSize: 16.h,
                                            onpress: () {
                                              Navigator.pop(context);
                                            },
                                            color: Colors.white,
                                            titlecolor: AppColors.primaryColor,
                                          )),
                                      SizedBox(
                                          width: 80.w,
                                          height: 40.h,
                                          child: CustomButton(
                                              color: AppColors.primaryColor,
                                              title: 'Yes',
                                              fontSize: 16.h,
                                              onpress: () async {

                                              })),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          elevation: 12.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              side: BorderSide(
                                  width: 1.w, color: AppColors.primaryColor)));
                    });


              },
              child: Row(
                children: [
                  Assets.icons.signOutCircle.svg(fit: BoxFit.cover, height: 25.h),
                  CustomText(text: "Log Out", left: 16.w, fontsize: 20.h, color: Colors.red),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }


  _customTile(Widget leading, Widget trailing, String title){
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(top: 18.5.h),
        child: Row(
          children: [
            leading,
            CustomText(text: title, left: 16.w, fontsize: 20.h),
            const Spacer(),
            trailing

          ],
        ),
      ),
    );
  }
}
