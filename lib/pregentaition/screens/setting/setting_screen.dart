import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seth/core/widgets/custom_network_image.dart';
import 'package:seth/core/widgets/custom_text.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 59.h),

            Row(
              children: [
                CustomNetworkImage(
                    boxShape: BoxShape.circle,
                    imageUrl: "", height: 86.h, width: 86.w),

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



            CustomText(text: "Personal Info"),



            ///====================Personal Data==============>

            _customTile(
              Assets.icons.person2.svg(),
              Assets.icons.arrowRight.svg(),
              "Personal Data"),


            ///==================Book marked events==============>>>

            _customTile(
                Assets.icons.calander1.svg(),
                Assets.icons.arrowRight.svg(),
                "Bookmarked Events"),



            ///==================Payment Account==============>>>

            _customTile(
                Assets.icons.person2.svg(),
                Assets.icons.arrowRight.svg(),
                "Payment Account"),



            _customTile(
                Assets.icons.person2.svg(),
                Assets.icons.arrowRight.svg(),
                "Personal Data"),

          ],
        ),
      ),
    );
  }


  _customTile(Widget leading, Widget trailing, String title){
    return Row(
      children: [
        leading,
        CustomText(text: title, left: 12.w, fontsize: 20.h),
        const Spacer(),

        trailing


      ],
    );
  }
}
