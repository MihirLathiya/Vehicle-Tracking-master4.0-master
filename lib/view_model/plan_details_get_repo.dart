import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';

class PlanDetailsViewModel extends GetxController {
  dynamic responses;
  Map<String, dynamic> planDetails = {};
  List planDuration = [];
  Future<dynamic> planDetailsRepo({String id}) async {
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://i.invoiceapi.ml/api/customer/getSubscriptionPlan?place_id=$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(await response.stream.bytesToString());
      log('RESPONSE ${data}');
      return data;
    } else {
      print(response.reasonPhrase);
    }
  }

  ApiResponse _subscriptionApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get subscriptionApiResponse => _subscriptionApiResponse;

  Future<void> subscriptionViewModel({String id}) async {
    _subscriptionApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      responses = await planDetailsRepo(id: id);
      print("responses=response==>$responses");
      planDuration.clear();
      for (int i = 0; i < (responses['data'] as List).length; i++) {
        planDuration.add(responses['data'][i]['duration']);
      }
      if (PreferenceManager.getDuration() != null ||
          PreferenceManager.getDuration() != '') {
        for (int i = 0; i < (responses['data'] as List).length; i++) {
          if (responses['data'][i]['duration'] ==
              PreferenceManager.getDuration()) {
            planDetails = {
              'dutation': responses['data'][i]['duration'],
              'price': responses['data'][i]['prize']
            };
          }
        }
        update();
      }
      log('PLAN DURATION :- ${planDuration}');
      update();
      _subscriptionApiResponse = ApiResponse.complete(responses);
    } catch (e) {
      print("responses=e==>$e");
      _subscriptionApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
