


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../global/custom_assets/assets.gen.dart';

class UploadProgressWidget extends StatefulWidget {
  final String fileName;
  final double progress;
  final String status;

  const UploadProgressWidget({
    super.key,
    required this.fileName,
    required this.progress,
    required this.status,
  });

  @override
  State<UploadProgressWidget> createState() => _UploadProgressWidgetState();
}

class _UploadProgressWidgetState extends State<UploadProgressWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Assets.icons.pdf.svg(),
          SizedBox(width: 12.h),


          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.fileName,
                  style:  TextStyle(
                    fontSize: 16.h,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  '${(widget.progress * 100).toStringAsFixed(0)} KB of 120 KB • ${widget.status}',
                  style: TextStyle(
                    fontSize: 12.h,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8.h),


                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          // Background Linear Progress Bar
                          Container(
                            width: double.infinity,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          // Foreground Progress
                          Container(
                            width: widget.progress * MediaQuery.of(context).size.width,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          // Percentage Text
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${(widget.progress * 100).toInt()}%",
                                style: TextStyle(
                                  fontSize: 7.h,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}




