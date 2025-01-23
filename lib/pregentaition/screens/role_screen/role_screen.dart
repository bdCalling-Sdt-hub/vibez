import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/core/widgets/custom_text.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';
import 'package:seth/helpers/toast_message_helper.dart';
import 'package:seth/pregentaition/screens/onboarding/onboarding_screen.dart';

class RoleScreen extends StatefulWidget {
   RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  List roles =[
    {
      "title" : "User",
      "subTitle" : "Can view events, explore details, and \npurchase tickets.",
      "image" : Assets.icons.userIcon.svg(height: 64.h, width: 64.w, fit: BoxFit.cover),
      "isChecked": false,
    },

    {
      "title" : "Manager",
      "subTitle" : "Can create events, manage ticket \nsales also view events.",
      "image" : Assets.icons.managerIcon.svg(height: 64.h, width: 64.w, fit: BoxFit.cover),
      "isChecked": false,
    },

    {
      "title" : "Guest",
      "subTitle" : "Can view events.",
      "image" : Assets.icons.guestIcon.svg(height: 64.h, width: 64.w, fit: BoxFit.cover),
      "isChecked": false,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Center(
          child: Column(
            children: [


              SizedBox(height: 130.h),

              ///====================Join Us ===================>>>

              CustomText(text: "Join Us", fontsize: 48.h, fontWeight: FontWeight.w900, bottom: 12.h),


              ///=====================Select Your Role to Signup=============>>>

              CustomText(text: "Select Your Role to Signup", fontsize: 20.h, bottom: 12.h),



              ///====================All Role Lists===============>>>

              ListView.builder(
                shrinkWrap: true,
                itemCount: roles.length,
                itemBuilder: (context, index) {
                  var role = roles[index];
                  return   Padding(
                    padding:  EdgeInsets.symmetric(vertical: 12.h),
                    child: ManagerCard(
                      title: role["title"],
                      subTitle: role["subTitle"],
                      image: role["image"],
                      isChecked: role["isChecked"],
                      onChanged: (value) {

                        for (int i = 0; i < roles.length; i++) {
                          roles[i]["isChecked"] = i == index;
                        }
                        setState(() {});
                      },
                    ),
                  );
                },
              ),

              SizedBox(height: 100.h),


              ///=================Next Btn=================>>>>

              CustomButton(
                width: double.infinity,
                title: "Next",
                onpress: () {
                  ///==============Find out the Selected Role=============>>>
                  final selectedRole = roles.firstWhere(
                        (role) => role["isChecked"] == true,
                    orElse: () => "null"
                  );

                  ///============Navigate or Show Toast Message============>>>
                  if (selectedRole == "null") {
                    // Show toast message if no role is selected
                    ToastMessageHelper.showToastMessage("Please select your role!");
                  } else {
                    // Navigate based on the selected role
                    switch (selectedRole["title"]) {
                      case "User":
                        context.pushNamed(AppRoutes.loginScreen);
                        break;
                      case "Manager":
                        context.pushNamed(AppRoutes.managerSignUpScreen);
                        break;
                      case "Guest":
                        context.pushNamed(AppRoutes.loginScreen);
                        break;
                      default:
                        print("Unknown role selected");
                    }
                  }
                },
              )


            ],
          ),
        ),
      ),
    );
  }
}






class ManagerCard extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Widget? image;
  final bool? isChecked;
  final ValueChanged<bool?>? onChanged;

   const ManagerCard({super.key, this.title, this.subTitle, this.image, this.isChecked, this.onChanged});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColor272727,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(12.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


                ///======================Leading Icon==================<>><

                CircleAvatar(
                  radius: 30, // Adjust the size of the avatar
                  backgroundColor: Colors.grey.shade800,
                  child: image,
                ),



                Padding(
                  padding: const EdgeInsets.only(left: 12.0), // Add consistent spacing
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      ///=================Title==================>>>

                      CustomText(
                        fontsize: 20.h,
                        fontWeight: FontWeight.w700,
                        text: title ?? '',
                      ),


                      ///=================Sub Title ==============>>>>

                      CustomText(
                        textAlign: TextAlign.start,
                        maxline: 2,
                        top: 4.h,
                        text: subTitle ?? '',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),


          ///================Check Box===============>>>>

          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Checkbox(
              value: isChecked ?? false,
              onChanged: onChanged,
              checkColor: Colors.white,
              side: const BorderSide(width: 0.5),
               fillColor:  WidgetStatePropertyAll(isChecked == true ? Colors.blueAccent  : Colors.white),
              activeColor: Colors.blue,
            ),
          ),
        ],
      )

    );
  }
}