import 'dart:convert';

import 'package:get/get.dart';
import 'package:seth/models/cetegory_model.dart';
import 'package:seth/models/event_details_model.dart';
import 'package:seth/models/event_model.dart';

import '../../services/api_client.dart';
import '../../services/api_constants.dart';

class ManagerEventController extends GetxController{



  RxBool eventLoading = false.obs;
  RxList<EventModel> events = <EventModel>[].obs;
  fetchEvent({String? type})async{
   events.clear();
    eventLoading(true);
    var response = await ApiClient.getData("/event/mine?type=$type");

    if(response.statusCode == 200){

      events.value = List<EventModel>.from(response.body["data"].map((x)=> EventModel.fromJson(x)));
      eventLoading(false);
    }else{
      eventLoading(false);
    }
  }



  RxBool eventDetailsLoading = false.obs;
  Rx<EventDetailsModel> eventDetails = EventDetailsModel().obs;

  getEventDetails({required String id}) async {
    eventDetailsLoading(true);
    var response = await ApiClient.getData(ApiConstants.eventDetailsEndPoint(id.toString()));

    print('--------------------------------------------${response.body}');
    if (response.statusCode == 200) {
      var responseData = response.body;
      eventDetails.value = EventDetailsModel.fromJson(responseData['data']);
      eventDetailsLoading(false);
    } else if (response.statusCode == 404) {
      eventDetailsLoading(false);
    }
  }




  RxBool categoryLoading = false.obs;
  RxList<CategoryModel> category = <CategoryModel>[].obs;
  getCategory()async{
    categoryLoading(true);
    var response = await ApiClient.getData("/category");
    if(response.statusCode == 200){
      category.value = List<CategoryModel>.from(response.body["data"].map((x)=> CategoryModel.fromJson(x)));
      categoryLoading(false);
    }else{
      categoryLoading(false);
    }
  }



  RxBool loveLoading = false.obs;

  love({required String id}) async {
    loveLoading(true);
    var body = {};

    var response = await ApiClient.postData("/bookmark/add-remove?id=$id", jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      eventDetails.value.eventDetails?.isBooked = !(eventDetails.value.eventDetails?.isBooked ?? false);
      refresh();
      update();
      print("======>>> successful");
      loveLoading(false);
    }else{
      loveLoading(false);
    }
  }




  RxBool featuredEventLoading = false.obs;
  RxList<EventModel> featuredEvents = <EventModel>[].obs;
  fetchFeaturedEvent()async{
    featuredEventLoading(true);
    var response = await ApiClient.getData("${ApiConstants.eventEndPoint}?type=featured");

    if(response.statusCode == 200){

      featuredEvents.value = List<EventModel>.from(response.body["data"].map((x)=> EventModel.fromJson(x)));
      featuredEventLoading(false);
    }else{
      featuredEventLoading(false);
    }
  }



  RxBool bookMarkLoading = false.obs;
  RxList<EventModel> bookMarkEvents = <EventModel>[].obs;
  fetchBookEvent()async{
    bookMarkLoading(true);
    var response = await ApiClient.getData("/bookmark");

    if(response.statusCode == 200){

      bookMarkEvents.value = List<EventModel>.from(response.body["data"].map((x)=> EventModel.fromJson(x)));
      bookMarkLoading(false);
    }else{
      bookMarkLoading(false);
    }
  }



}