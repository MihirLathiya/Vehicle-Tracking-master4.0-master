import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/repo/add_number_repo.dart';

class AddNumberViewModel extends GetxController {
  ApiResponse _addNumberApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addNumberApiResponse => _addNumberApiResponse;
  bool isLoading = false;
  void updateLoading(bool v) {
    isLoading = v;
    update();
  }

  Future<void> addNumberViewModel({model}) async {
    _addNumberApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      updateLoading(true);
      dynamic response = await AddNumberRepo().addNumberRepo(body: model);
      print("StoreVehicleNumberResponseModel=response==>$response");

      _addNumberApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("StoreVehicleNumberResponseModel=e==>$e");
      _addNumberApiResponse = ApiResponse.error(message: 'error');
      updateLoading(false);
    }
    update();
  }
}
