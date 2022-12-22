import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';
import 'package:vehicletracking/utils/validators.dart';

class ImageController extends GetxController {
  String url;

  updateUrl({String imageUrl}) {
    url = imageUrl;
    update();
  }

  bool loading = false;

  updateLoading(bool val) {
    loading = val;
    update();
  }

  apiCalling() async {
    updateLoading(true);
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var response = await http.get(
        Uri.parse(
            'https://i.invoiceapi.ml/api/customer/getUserDetail/${PreferenceManager.getAccountNo()}'),
        headers: headers);

    if (response.statusCode == 200) {
      print(" RESPONSE ${await response}");
      var data = jsonDecode(response.body);
      // ProfileResponseModel hello = await ProfileResponseModel.fromJson(data);
      log('HELLO :- ${await data}');
      updateUrl(imageUrl: data['data']['image'].toString());
      updateLoading(false);
    } else {
      print(response.reasonPhrase);
      updateLoading(true);
      CommonSnackBar.commonSnackBar(message: '${response.reasonPhrase}');
    }
  }

  @override
  void onInit() {
    apiCalling();
    super.onInit();
  }
}
