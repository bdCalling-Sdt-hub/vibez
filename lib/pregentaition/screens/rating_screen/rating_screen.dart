
import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/core/widgets/custom_text_field.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../helpers/toast_message_helper.dart';
import '../Manager/create_event/inner_widget/upload_progress_widget.dart';

class RatingScreen extends StatefulWidget {
  final String category;
  const RatingScreen({super.key, required this.category});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen>  {
 final TextEditingController ratingCtrl = TextEditingController();



  @override
  Widget build(BuildContext context) {



    final List<Map<String, dynamic>> ratingItems = widget.category == "bars"  || widget.category == "night-clubs" ? [
      {"title": "Food", "value": 3.2},
      {"title": "Service", "value": 3.2},
      {"title": "Ambience", "value": 3.2},
      {"title": "Price", "value": 3.2},
      {"title": "Music", "value": 3.2},
    ] :  widget.category == "ticketed-parties" ?

    [
    {"title": "Music", "value": 3.2},
    {"title": "Ambience", "value": 3.2},
    {"title": "Atmosphere", "value": 3.2},
    {"title": "Price", "value": 3.2},
    ] :  widget.category == "restaurant" ?
    [
    {"title": "Food", "value": 3.2},
    {"title": "Service", "value": 3.2},
    {"title": "Ambience", "value": 3.2},
    {"title": "Price", "value": 3.2},
    ] :  widget.category == "party-restaurant" ?

    [
    {"title": "Food", "value": 3.2},
    {"title": "Service", "value": 3.2},
    {"title": "Ambience", "value": 3.2},
    {"title": "Price", "value": 3.2},
    {"title": "Music", "value": 3.2},
    ] :


    [
    {"title": "Food & Drink", "value": 3.2},
    {"title": "Atmosphere", "value": 3.2},
    {"title": "Service", "value": 3.2}
    ];



     _updateRating(int index, double newValue) {
      setState(() {
        ratingItems[index]["value"] = newValue;
      });
    }


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

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemCount: ratingItems.length,
              itemBuilder: (context, index) {
                final item = ratingItems[index];
                return _customRating(item["title"], item["value"], (val) => _updateRating(index, val));
              },
            ),



            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [


                  CustomTextField(
                      hintText: "Add Comments",
                      prefixIcon: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 12.w),
                        child: const Icon(Icons.message),
                      ),
                      controller: ratingCtrl),


                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                          ),

                          child: Padding(
                            padding: EdgeInsets.all(8.r),
                            child: const Icon(Icons.wb_cloudy_outlined, color: Colors.black54),
                          )),


                      CustomText(text: "Upload Photo (max 2)", left: 12.w, color: AppColors.textColor808080)
                    ],
                  ),

                  const Divider(),

                  SizedBox(height: 12.h),


                  photos.length == 2 ? const SizedBox() :
                  GestureDetector(
                    onTap: (){
                      if (photos.length < 2) {
                        addPhoto();
                      } else {
                        ToastMessageHelper.showToastMessage('Upload Party Photo (max 2)');
                      }

                    },
                    child: Container(
                      height: 209.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.white),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(15.r),
                        dashPattern: const [10, 5],
                        color: const Color(0xffCBD0DC),
                        strokeWidth: 3,
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 24.w, vertical: 33.h),
                          child: Center(
                            child: Column(
                              children: [
                                const Icon(Icons.wb_cloudy_outlined, color: Colors.black54),

                                CustomText(text: "Choose a file here", color: const Color(0xff666666)),
                                CustomText(text: "PNG, JPG & JPEG formats, up to 50MB",top: 4.h, bottom: 20.h, color: const Color(0xffA9ACB4),),

                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(color: Colors.grey)
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(8.r),
                                    child: CustomText(text: "Browse File", color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 20.h),


                  if (progressShow) ...[
                    SizedBox(height: 20.h),
                    UploadProgressWidget(
                      fileName: "Sagor.pnd",
                      progress: progressValue.toDouble(),
                      status: "Uploading...",
                    ),
                    SizedBox(height: 20.h),
                  ],


                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                      childAspectRatio: 1.536,
                    ),
                    itemCount: photos.length,
                    itemBuilder: (context, index) {
                      if (index == photos.length) {
                        return GestureDetector(
                          onTap: () => addPhoto(),
                          child: Stack(
                            children: [
                              /// ================================>  Add Button with Dashed Border ==================================>
                              ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return const LinearGradient(
                                      colors: [
                                        Color(0xFFFB3F81),
                                        Color(0xFFB749BB),
                                        Color(0xFF8C4AEF),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ).createShader(bounds);
                                  }
                              ),
                            ],
                          ),
                        );
                      }

                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              image: DecorationImage(
                                image: FileImage(photos[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),


                  SizedBox(height: 25.h),


                  CustomButton(title: "Submit", onpress: (){}),

                  SizedBox(height: 100.h),

                ],
              ),
            ),




          ],
        ),
      ),
    );
  }


 bool progressShow = false;
 double progressValue = 0.0;
 RxList<File> photos = <File>[].obs;
 Future<void> addPhoto() async {
   final ImagePicker picker = ImagePicker();
   final XFile? image = await picker.pickImage(source: ImageSource.gallery);

   if (image != null) {
     photos.add(File(image.path));
   }
   _uploadImageSimulation();
 }


 Future<void> _uploadImageSimulation() async {
   progressShow = true;
   progressValue = 0.0;
   const interval = Duration(milliseconds: 200);
   Timer.periodic(interval, (timer) {
     setState(() {
       progressValue += 0.1;
       if (progressValue >= 1.0) {
         timer.cancel();
         progressShow = false;
       }
     });
   });
 }




 _customRating(String title, double sliderValue, Function(double) onChanged) {
   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       CustomText(text: title, fontsize: 16.h, fontWeight: FontWeight.w600, left: 20.w),

       SizedBox(
         child: Stack(
           alignment: Alignment.center,
           children: [
             SizedBox(height: 70.h),
             SliderTheme(
               data: SliderTheme.of(context).copyWith(
                 activeTrackColor: Colors.blue,
                 inactiveTrackColor: Colors.grey,
                 thumbColor: Colors.white,
                 overlayColor: Colors.blue.withOpacity(0.2),
                 valueIndicatorColor: Colors.blue,
               ),
               child: Slider(
                 min: 0.0,
                 max: 5.0,
                 value: sliderValue,
                 divisions: 10,
                 onChanged: (value) {
                   onChanged(double.parse(value.toStringAsFixed(1)));
                 },
               ),
             ),
             Positioned(
               left: 20 + (sliderValue / 5.0) * (393 - 64).w,
               top: 0,
               child: Container(
                 padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                 decoration: BoxDecoration(
                   color: Colors.blue,
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: CustomText(text: sliderValue.toString(), fontsize: 10.h),
               ),
             ),
           ],
         ),
       ),
       SizedBox(height: 30.h),
     ],
   );
 }

}




