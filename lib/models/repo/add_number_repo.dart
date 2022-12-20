import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vehicletracking/models/services/base_service.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';

class AddNumberRepo extends BaseService {
  Future<dynamic> addNumberRepo({body}) async {
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var request = await http.post(
        Uri.parse('https://i.invoiceapi.ml/api/customer/storeVehicleNumber'),
        headers: headers,
        body: body);

    if (request.statusCode == 200) {
      print(await request.body);
      dynamic data = jsonDecode(await request.body);
      return data;
    } else {
      print(request.reasonPhrase);
    }
  }
}
