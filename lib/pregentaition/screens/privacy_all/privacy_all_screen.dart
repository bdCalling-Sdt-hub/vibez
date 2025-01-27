import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/custom_text.dart';

class PrivacyAllScreen extends StatelessWidget {
  final String title;
   PrivacyAllScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: title.toString(), fontsize: 20.h),
      ),


      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [



            CustomText(
              maxline: 3000,
              textAlign: TextAlign.start,
              text: "Lorem ipsum dolor sit amet consectetur. Ultrices id feugiat venenatis habitant mattis viverra elementum purus volutpat. Lacus eu molestie pulvinar rhoncus integer proin elementum. Pretium sit fringilla massa tristique aenean commodo leo. Aliquet viverra amet sit porta elementum et pellentesque posuere. Ullamcorper viverra tortor lobortis viverra auctor egestas. Nulla condimentum ac metus quam turpis gravida ut velit. Porta justo lacus consequat sed platea. Ut dui massa quam elit faucibus consectetur sapien aenean auctor. Felis ipsum amet justo in. Netus amet in egestas sed auctor lorem. Justo ullamcorper velit habitasse lorem eu arcu. Non enim a elit urna eget nibh quisque donec condimentum. Elit ut pellentesque neque in quis at viverra. Nisl etiam tristique odio eget convallis.",
            )


          ],
        ),
      ),

    );
  }
}
