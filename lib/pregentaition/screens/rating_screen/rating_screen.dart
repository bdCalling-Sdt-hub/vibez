
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_text.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {


  double age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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


      body: Column(
        children: [




          CustomText(text: "Rate Music",  fontsize: 16.h, fontWeight: FontWeight.w600),


          _buildAgeRangeSection(),



        ],
      ),
    );
  }

  /// ======================================> Age Range Section ================================================>
  Widget _buildAgeRangeSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Age Range',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Slider(
                  value: age,
                  max: 100,
                  min: 1,
                  activeColor: AppColors.textColor808080,
                  inactiveColor: Colors.grey[300],
                  onChanged: (value) {
                    if (value >= 18) {
                      setState(() {
                        age = value;
                      });
                    } else {
                      // // Optional: Show a snack bar or error message to inform the user
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Age must be 18 or older'),
                      //     duration: Duration(seconds: 2),
                      //   ),
                      // );
                    }
                  },
                ),
              ),
              Text(
                ' Age',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Show people slightly out of my preferred range if I run out of profiles to see',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              Switch(
                value: true,
                activeColor: Colors.purple,
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }

}




