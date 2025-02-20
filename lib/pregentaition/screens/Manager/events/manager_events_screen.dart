
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seth/core/utils/app_colors.dart';
import '../../../../core/widgets/custom_event_card.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../global/custom_assets/assets.gen.dart';

class ManagerEventsScreen extends StatefulWidget {
   final String title;
   ManagerEventsScreen({super.key, required this.title});

  @override
  State<ManagerEventsScreen> createState() => _ManagerEventsScreenState();
}

class _ManagerEventsScreenState extends State<ManagerEventsScreen> {
   int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      ///=====================App Bar ==================>>>>
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: CustomText(text: widget.title, fontsize: 20.h),
      ),



      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [


            ///===================My Events and All Events===============>>>

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedItem == 0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        color: selectedItem == 0 ? AppColors.primaryColor :  Colors.transparent,
                      border: Border.all(color: Colors.white)
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                      child: CustomText(text: "Current Events (12)"),
                    ),
                  ),
                ),


                SizedBox(width: 16.w),


                GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedItem == 1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        color: selectedItem == 1 ? AppColors.primaryColor :  Colors.transparent,
                        border: Border.all(color: Colors.white)
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                      child: CustomText(text: "Past Events (20)"),
                    ),
                  ),
                ),


              ],
            ),



            SizedBox(height: 20.h),


            ///=========================Events List View================>>>>

            Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child:  CustomEventCard(),
                    );
                  }),
            ),


          ],
        ),
      ),

    );
  }
}
