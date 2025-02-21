import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/toast_message_helper.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';



class CreateEventController extends GetxController{
  RxBool createEventLoading = false.obs;
  createEvent({required File coverImage, required List <File> photos, required String name, details, log, lat, date, time, ticketLink, address,category,  required List filterIdArray, required BuildContext context}) async {
    createEventLoading(true);

    List<MultipartBody> photoList = [];


    photoList.add(MultipartBody("coverPhoto", coverImage));

    for(var photos in photos){
      photoList.add(MultipartBody("photos", photos));
    }



    var body = {
      "name" : "$name",
      "details" : "$details",
      "lon" : "$log",
      "lat" : "$lat",
      "date" : "$date",
      "time" : "$time",
      "ticketLink" : "$ticketLink",
      "filterIdArray" : jsonEncode(filterIdArray),
      "address" : "$address",
      "category" : "$category",
    };

    var response = await ApiClient.postMultipartData("/event/create", body, multipartBody: photoList);

    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage(response.body["message"]);
      update();
      context.pop();
      createEventLoading(false);
    }else{
      createEventLoading(false);
    }
  }

}