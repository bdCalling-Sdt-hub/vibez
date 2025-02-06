
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../../core/widgets/custom_text.dart';

class CustomCommentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8.r),
      ),
      width: 393.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [

              CustomNetworkImage(
                imageUrl: "https://images.pexels.com/photos/1763075/pexels-photo-1763075.jpeg?cs=srgb&dl=pexels-sebastian-ervi-866902-1763075.jpg&fm=jpg",
                height: 32.h,
                width: 32.w,
                boxShape: BoxShape.circle,
              ),

              SizedBox(width: 10.w),


              CustomText(text: "Kristin Watson", fontsize: 12),

              const Spacer(),

              CustomText(text: "Avg. Ratings", fontsize: 10.h, color: AppColors.textColor808080),

              SizedBox(width: 6.w),


              Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4.r),
                  ),


                  child: CustomText(
                    text: "5.2",
                  )

              ),
            ],
          ),
          SizedBox(height: 12.h),

          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 277.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) => ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CustomNetworkImage(
                        imageUrl: "https://images.pexels.com/photos/1763075/pexels-photo-1763075.jpeg?cs=srgb&dl=pexels-sebastian-ervi-866902-1763075.jpg&fm=jpg",
                        height: 72.h,
                        width: 72.w)
                ),
                ),
              ),
            ),
          ),


          SizedBox(height: 12.h),

          Align(
              alignment: Alignment.centerRight,
              child: CustomText(text: "Feb 09, 2025",fontsize: 12.h, color: AppColors.textColor808080))

        ],
      ),
    );
  }
}
