import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/services/api_service.dart';

class HistoryViewModel extends GetxController {
  dynamic response;
  Future<dynamic> getHistoryRepo() async {
    var response = await APIService().getResponse(
        url: 'https://i.invoiceapi.ml/api/customer/history',
        apitype: APIType.aGet);

    dynamic createPasswordResponseModel = await (response);
    // print(
    //     'CreatePasswordResponseModel ${createPasswordResponseModel[0]['account_number']}');
    return createPasswordResponseModel;
  }

  ApiResponse _historyApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get historyApiResponse => _historyApiResponse;
  bool isLoading = false;
  void updateLoading(bool v) {
    isLoading = v;
    update();
  }

  Future<void> history() async {
    _historyApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      updateLoading(true);
      response = await getHistoryRepo();
      print("HISTROY=response==>$response");

      _historyApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("HISTROY=e==>$e");
      _historyApiResponse = ApiResponse.error(message: 'error');
      updateLoading(false);
    }
    update();
  }
}
