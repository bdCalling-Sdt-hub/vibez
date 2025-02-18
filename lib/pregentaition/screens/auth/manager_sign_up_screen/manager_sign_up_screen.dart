
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/core/widgets/custom_text.dart';
import 'package:seth/core/widgets/custom_text_field.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../helpers/toast_message_helper.dart';
import '../log_in/log_in_screen.dart';



class ManagerSignUpScreen extends StatefulWidget {
   ManagerSignUpScreen({super.key});

  @override
  State<ManagerSignUpScreen> createState() => _ManagerSignUpScreenState();
}

class _ManagerSignUpScreenState extends State<ManagerSignUpScreen> {

  final TextEditingController businessTypeCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passWordCtrl = TextEditingController();
  final TextEditingController phoneNumberCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController websiteLinkCtrl = TextEditingController();
  final TextEditingController govIdCtrl = TextEditingController();
  final TextEditingController confirmPassCtrl = TextEditingController();

  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  late bool isCheck = false;
  AuthController authController = Get.find<AuthController>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Form(
              key: fromKey,
              child: Column(
                children: [
        
                  SizedBox(height: 80.h),
        
                  ///==================App Logo ===============>>>
        
                  Assets.images.applogo.image(),
        
        
                  ///================Sign Up as a Manager=============>>>
        
                  CustomText(
                    text: "Sign Up as a Manager",
                    top: 24.h,
                    fontsize: 28.h,
                    fontWeight: FontWeight.w600,
                  ),
        
        
                  CustomText(
                    top: 4.h,
                    bottom: 24.h,
                    text: "Be a manager and create your own events.",
                    color: AppColors.textColor808080,
                  ),
        
        
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      bottom: 4.h,
                      top: 24.h,
                      text: "Which type of manager are you?*",
                      color: AppColors.textColor808080,
                    ),
                  ),
        
        
                  GestureDetector(
                    onTapDown: (details){
                      _showPopupMenu(context, details.globalPosition);
                    },
                    child: CustomTextField(
                      readOnly: true,
                      controller: businessTypeCtrl,
                      hintText: "Select Your Business Type",
                      suffixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: const Icon(Icons.keyboard_arrow_down_outlined),
                      ),
                    ),
                  ),
        
        
        
                  ///==============Full Name* Field============<>>>>
        
                  CustomTextFieldWithLavel(
                    leadingIcon: Assets.icons.person.svg(),
                    controller: nameCtrl,
                    hinText: "Enter Your Full Name",
                    laval: "Full Name*",
                  ),
        
        
        
        
                  ///==============Email Field============<>>>>
        
                  CustomTextFieldWithLavel(
                    leadingIcon: Assets.icons.email.svg(),
                    controller: emailCtrl,
                    isEmail: true,
                    hinText: "Enter your email address",
                    laval: "Email Address",
                  ),
        
        
        
                  ///==============Enter your phone number===========<>>>>
        
                  CustomTextFieldWithLavel(
                    leadingIcon: Assets.icons.call.svg(),
                    controller: phoneNumberCtrl,
                    hinText: "Enter your phone number",
                    laval: "Phone Number",
                    keyboardType: TextInputType.number,
                  ),
        
                  
        
                  ///==============Business Address Field============<>>>>
        
                  CustomTextFieldWithLavel(
                    leadingIcon:  Assets.icons.location.svg(),
                    controller: addressCtrl,
                    hinText: "Enter Your Business Address",
                    laval: "Business Address",
                  ),
        
        
        
        
                  ///==============Enter Business Website/ Social Field============<>>>>
        
                  CustomTextFieldWithLavel(
                    leadingIcon:  Assets.icons.url.svg(),
                    controller: websiteLinkCtrl,
                    hinText: "Enter URL",
                    laval: "Enter Business Website/ Social",
                  ),
        
        
        
        
                  ///==============Government ID===========<>>>>
        
                  CustomTextFieldWithLavel(
                    leadingIcon:  Assets.icons.atracFile.svg(),
                    controller: govIdCtrl,
                    hinText: "Upload Your Government ID",
                    laval: "Government ID",
                  ),
        
        
        
        
                  ///==============Password Field============<>>>>
        
                  CustomTextFieldWithLavel(
                    leadingIcon:  Assets.icons.password.svg(),
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
                    leadingIcon:  Assets.icons.password.svg(),
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
        
                  CustomButton(
                      width: double.infinity,
                      title: "Sign Up", onpress: (){
        
                     if(fromKey.currentState!.validate()){
                       if(isCheck){
                         authController.handleSignUp(context: context,
                             name: nameCtrl.text,
                             email: emailCtrl.text,
                             phone: phoneNumberCtrl.text,
                             password: passWordCtrl.text,
                             url: websiteLinkCtrl.text,
                             businessAddress: addressCtrl.text,
                             governmentId: govIdCtrl.text,
                             managerType: businessTypeCtrl.text
                         );
                       }else{
                         ToastMessageHelper.showToastMessage("Please Check term and conditions!");
                       }

                    // _dialog();
                     }
                  }),
        
        
        
                  ///=================Do you have Account================>>>
        
                  SizedBox(height: 24.h),
        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Already have an account?",
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
      ),
    );
  }



  final List<String> businessTypes = [
    "Are you a manager for a club?",
    "Are you a manager for a restaurant?",
    "Are you a manager for a bar or nightclub?",
    "Are you a manager for a party restaurant?",
    "Are you a manager for  ticketed parties?",
    "Are you a manager for a comedy club?",
    "Are you a manager for concerts?",
  ];

  void _showPopupMenu(BuildContext context, Offset offset) async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final selectedType = await showMenu<String>(
      initialValue: "Select Your Business Type",
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        offset.dx + size.width,
        offset.dy + size.height,
      ),
      items: businessTypes.map((String type) {
        return PopupMenuItem<String>(
          value: type,
          child: CustomText(text: type, top: 1.h, bottom: 1.h),
        );
      }).toList(),
    );

    if (selectedType != null) {
      setState(() {
        businessTypeCtrl.text = selectedType;
      });
    }
  }
}
