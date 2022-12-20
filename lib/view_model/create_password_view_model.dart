import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/repo/create_password_repo.dart';
import 'package:vehicletracking/models/response_model/create_password_res_model.dart';

class CreatePasswordViewModel extends GetxController {
  ApiResponse _createPasswordApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get createPasswordApiResponse => _createPasswordApiResponse;
  bool isLoading = false;
  void updateLoading(bool v) {
    isLoading = v;
    update();
  }

  Future<void> createPasswordViewModel({Map<String, dynamic> model}) async {
    _createPasswordApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      updateLoading(true);
      CreatePasswordResponseModel response =
          await CreatePasswordRepo().createPasswordRepo(body: model);
      print("CreatePasswordResponseModel=response==>$response");

      _createPasswordApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("CreatePasswordResponseModel=e==>$e");
      _createPasswordApiResponse = ApiResponse.error(message: 'error');
      updateLoading(false);
    }
    update();
  }
}
