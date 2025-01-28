
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "Filter Your Vibe", fontsize: 20.h),

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

          CustomCard(),

        ],
      ),
    );
  }
}





class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('https://via.placeholder.com/50'),
              ),
              SizedBox(width: 10),
              Text(
                'Kristin Watson',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                'Avg. Ratings',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              SizedBox(width: 6),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '4.6',
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) =>
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://via.placeholder.com/100',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Feb 09, 2025',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class RatingSlider extends StatefulWidget {
  @override
  _RatingSliderState createState() => _RatingSliderState();
}

class _RatingSliderState extends State<RatingSlider> {
  double _currentValue = 3.2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rate Food',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.blue,
            inactiveTrackColor: Colors.grey,
            thumbColor: Colors.white,
            overlayColor: Colors.blue.withOpacity(0.2),
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
            valueIndicatorColor: Colors.blue,
            valueIndicatorTextStyle: TextStyle(color: Colors.white),
          ),
          child: Slider(
            value: _currentValue,
            min: 0,
            max: 5,
            divisions: 10,
            label: _currentValue.toStringAsFixed(1),
            onChanged: (double value) {
              setState(() {
                _currentValue = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
