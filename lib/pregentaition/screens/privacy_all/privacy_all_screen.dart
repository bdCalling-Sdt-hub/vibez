import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:seth/core/widgets/custom_loader.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../../../controllers/privacy_policy_all_controller.dart';
import '../../../core/widgets/custom_text.dart';

class PrivacyAllScreen extends StatefulWidget {
  final String title;

  PrivacyAllScreen({super.key, required this.title});

  @override
  State<PrivacyAllScreen> createState() => _PrivacyAllScreenState();
}

class _PrivacyAllScreenState extends State<PrivacyAllScreen> {
  PrivacyPolicyAllController policyAllController = Get.put(PrivacyPolicyAllController());

  @override
  void initState() {
    policyAllController.getPrivacy(
        url: widget.title == "About Us"
            ? "/about"
            : widget.title == "Privacy Policy"
            ? "/privacy"
            : "/terms");
    super.initState();
  }

  @override
  void dispose() {
    policyAllController.content.value = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: CustomText(text: widget.title.toString(), fontsize: 20.h),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [


              widget.title == "About Us"
                  ? Padding(
                    padding:  EdgeInsets.symmetric(vertical: 20.h),
                    child: Assets.images.aboutUs.image(),
                  )  : const SizedBox.shrink(),

              
              Obx(() => policyAllController.isLoading.value
                  ?  CustomLoader(top: 300.h)
                  : policyAllController.content.isEmpty
                      ? Center(child: CustomText(text: "No Data Found!", top: 300.h))
                      : HtmlWidget(policyAllController.content.value,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 14.h,
                          ))),
            ],
          ),
        ),
      ),
    );
  }
}
