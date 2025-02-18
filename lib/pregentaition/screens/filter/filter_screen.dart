import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_text_field.dart';



class FilterScreen extends StatefulWidget {
  final String? categoryType;
   FilterScreen({super.key, this.categoryType});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  final TextEditingController within = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "Filter Your Vibe", fontsize: 20.h),

        actions: [

          GestureDetector(
              onTap: (){
                for(var item in musicTypeList){
                  item["isSelected"] = false;
                }
                for(var item in energyLevel){
                  item["isSelected"] = false;
                }
                for(var item in crowdList){
                  item["isSelected"] = false;
                }

                setState(() {});
              },
              child: CustomText(text: "Clear All", color: AppColors.textColor808080)),

          SizedBox(width: 20.w)
        ],
      ),



      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            ///=================Location Radius =======================><

            CustomText(text: "Location Radius", fontsize: 16.h, top: 20.h, bottom: 16.h),


            CustomText(text: "Within", bottom: 10.h),
            SizedBox(
              width: 200.w,
              child: GestureDetector(
                onTapDown: (details){
                  _showPopupMenu(context, details.globalPosition);
                },
                child: CustomTextField(
                  readOnly: true,
                  controller: within,
                  hintText: "Select Your Business Type",
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: const Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                ),
              ),
            ),




            ///================= Music Type =======================><

            CustomText(text: "Music Type", fontsize: 16.h, top: 20.h, bottom: 12.h),

            _buttons(musicTypeList),


            ///================= Energy Level =======================><

            CustomText(text: "Energy Level", fontsize: 16.h, top: 20.h, bottom: 12.h),


            _buttons(energyLevel),



            ///================= Crowd Size =======================><

            CustomText(text: "Crowd Size", fontsize: 16.h, top: 20.h, bottom: 12.h),


            _buttons(crowdList),


            SizedBox(height: 35.h),


            CustomButton(
                color: Colors.transparent,
                titlecolor: AppColors.primaryColor,
                title: "Apple filters", onpress: (){})



          ],
        ),
      ),

    );
  }


  Widget _buttons(List list){
    return  Wrap(
      spacing: 12.r,
      runSpacing: 12.r,
      children: list.map((x){
        return GestureDetector(
          onTap: () {
            setState(() {
              x["isSelected"] = !x["isSelected"];
            });
          },
          child: Container(
              padding:  EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: x["isSelected"] ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: CustomText(
                text: x["value"],
                color: x["isSelected"] ? Colors.white : Colors.black,
              )
          ),
        );
      }).toList(),
    );
  }


  List  musicTypeList = [
    {
      "value" : "EDM",
      "isSelected" : false
    },
    {
      "value" : "Hip-Hop",
      "isSelected" : false
    },
    {
      "value" : "Jazz",
      "isSelected" : false
    },
    {
      "value" : "Country",
      "isSelected" : false
    },
    {
      "value" : "House",
      "isSelected" : false
    },
    {
      "value" : "Rock",
      "isSelected" : false
    },
    {
      "value" : "Classical",
      "isSelected" : false
    },
    {
      "value" : "Middle Eastern",
      "isSelected" : false
    },
    {
      "value" : "Latin",
      "isSelected" : false
    },
    {
      "value" : "R&B",
      "isSelected" : false
    },
    {
      "value" : "Reggae",
      "isSelected" : false
    }
  ];


  List  energyLevel = [
    {
      "value" : "Chill",
      "isSelected" : false,
    },
    {
      "value" : "High",
      "isSelected" : false,
    },
  ];


  List  crowdList = [
    {
      "value" : "Full House",
      "isSelected" : false,
    },
    {
      "value" : "Moderate",
      "isSelected" : false,
    },
    {
      "value" : "Free-Flow",
      "isSelected" : false,
    }
  ];


  List <String> mileList = ["1 Miles", "2 Miles", "3 Miles", "4 Miles" , "5 Miles"];


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
      items: mileList.map((String type) {
        return PopupMenuItem<String>(
          value: type,
          child: CustomText(text: type, top: 1.h, bottom: 1.h),
        );
      }).toList(),
    );

    if (selectedType != null) {
      setState(() {
        within.text = selectedType;
      });
    }
  }


}
