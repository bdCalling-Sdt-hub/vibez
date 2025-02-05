
import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/hatch_mark.dart';
import 'package:another_xlider/models/hatch_mark_label.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/core/widgets/custom_text_field.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_text.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {


 final TextEditingController ratingCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: CustomText(text: "Rate the Vibe", fontsize: 20.h),

        actions: [

          GestureDetector(
              onTap: (){
                setState(() {});
              },
              child: CustomText(text: "Clear All", color: AppColors.textColor808080)),

          SizedBox(width: 20.w)
        ],
      ),


      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
        
            _customRating("Rate Food"),
            _customRating("Rate Service"),
            _customRating("Rate Ambience"),
            _customRating("Rate Food"),
            _customRating("Rate Price"),
        
        
        
        
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomTextField(
                  hintText: "Add Comments",
                  prefixIcon: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 12.w),
                    child: const Icon(Icons.message),
                  ),
                  controller: ratingCtrl),
            ),



            SizedBox(height: 25.h),


            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomButton(title: "Submit", onpress: (){}),
            ),

            SizedBox(height: 100.h),




        
        
          ],
        ),
      ),
    );
  }



  _customRating(String title){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title,  fontsize: 16.h, fontWeight: FontWeight.w600, left: 20.w),
        FlutterSlider(
            values: const [50],
            max: 5,
            min: 0,
            trackBar: FlutterSliderTrackBar(
              inactiveTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.grey,
                border: Border.all(width: 3, color: Colors.blue)
              ),
              activeTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.primaryColor
              ),
            )
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Assets.images.ratingImage.image(),
        ),


        SizedBox(height: 30.h)


      ],
    );
  }
}




