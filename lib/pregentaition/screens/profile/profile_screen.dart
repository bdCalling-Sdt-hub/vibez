import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/core/widgets/custom_text.dart';
import 'package:seth/core/widgets/custom_text_field.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../../../core/widgets/custom_network_image.dart';

class ProfileScreen extends StatefulWidget {
   ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneNoCtrl = TextEditingController();


  @override
  void initState() {
    nameCtrl.text = "Sagor ahamed";
    emailCtrl.text = "Sagor@gamail.com";
    phoneNoCtrl.text = "015456454642";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "Personal Data", fontsize: 20.h),
      ),


      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [

            CustomNetworkImage(
                boxShape: BoxShape.circle,
                imageUrl: "https://cdn.shopaccino.com/igmguru/products/flutter-igmguru_1527424732_l.jpg?v=476",
                height: 120.h, width: 120.w
            ),


            CustomText(text: "User Name", fontsize: 20.h, top: 16.h),



            ///==================Name -==============>>>

            SizedBox(height: 16.h),
            CustomTextField(
               prefixIcon: Padding(
                 padding:  EdgeInsets.symmetric(horizontal: 16.w),
                 child: Assets.icons.person.svg(),
               ),
                readOnly: true,
                controller: nameCtrl),




            ///==================Email -==============>>>

            SizedBox(height: 16.h),
            CustomTextField(
                prefixIcon: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16.w),
                  child: Assets.icons.email.svg(),
                ),
                readOnly: true,
                controller: emailCtrl),






            ///==================Phone -==============>>>

            SizedBox(height: 16.h),
            CustomTextField(
                prefixIcon: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16.w),
                  child: Assets.icons.call.svg(),
                ),
                readOnly: true,
                controller: phoneNoCtrl),



            SizedBox(height: 50.h),

            CustomButton(
                color: Colors.transparent,
                titlecolor: AppColors.primaryColor,
                title: "Edit Profile", onpress: (){
                  context.pushNamed(AppRoutes.editProfileScreen);
            })


          ],
        ),
      ),
    );
  }
}
