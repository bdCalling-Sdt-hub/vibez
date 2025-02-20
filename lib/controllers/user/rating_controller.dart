import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/controllers/auth_controller.dart';
import 'package:seth/controllers/user/user_event_controller.dart';
import 'package:seth/helpers/toast_message_helper.dart';
import 'package:seth/services/api_constants.dart';
import '../../services/api_client.dart';

class RatingController extends GetxController{

  RxBool ratingLoading = false.obs;
  rating({required List <File> image,required String id, required String comment, required List rating, required BuildContext context}) async {
    ratingLoading(true);

    List<MultipartBody> photoList = [];
    for(var photos in image){
      photoList.add(MultipartBody("photos", photos));
    }
    List<MultipartBody> multipartBody = photoList ?? [];

    var body = {
      "eventId" : "$id",
      "comment" : "$comment",
      "rating" : jsonEncode(rating),
    };

    var response = await ApiClient.postMultipartData(ApiConstants.reviewRating, body, multipartBody: multipartBody);

    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage("Review Submitted!\nThank you for your review!");
      UserEventController userEventController = Get.put(UserEventController());
      userEventController.getEventDetails(id: id.toString());
      update();
      context.pop();
      ratingLoading(false);
    }else{
      ratingLoading(false);
    }
  }


}