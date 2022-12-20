import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';

class AccessController extends GetxController {
  dynamic responses;
  List value = [];

  updateValue(List x) {
    value = x;
    update();
  }

  updateData(index, val) {
    value[index] = val;
    update();
  }

  Future<dynamic> accessControllerRepo({String id}) async {
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://i.invoiceapi.ml/api/customer/getAccessControls?place_id=$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic accessData = jsonDecode(await response.stream.bytesToString());
      return accessData;
    } else {
      print(response.reasonPhrase);
    }
  }

  ApiResponse _accessApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get accessApiResponse => _accessApiResponse;

  Future<void> accessControllerViewModel({String id}) async {
    _accessApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      responses = await accessControllerRepo(id: id);
      print("access responses=response==>$responses");

      _accessApiResponse = ApiResponse.complete(responses);
    } catch (e) {
      print("access responses=e==>$e");
      _accessApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
