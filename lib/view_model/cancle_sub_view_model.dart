import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/repo/cancle_sub_repo.dart';
import 'package:vehicletracking/models/response_model/cancle_sub_res_model.dart';

class CancleSubViewModel extends GetxController {
  ApiResponse _cancleSubApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get cancleSubApiResponse => _cancleSubApiResponse;
  bool isLoading = false;
  void updateLoading(bool v) {
    isLoading = v;
    update();
  }

  Future<void> cancleSubViewModel({String id}) async {
    _cancleSubApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      updateLoading(true);
      CancleSubscriptionResponseModel response =
          await CancleSubRepo().cancleSubRepo(id: id);
      print("CreatePasswordResponseModel=response==>$response");

      _cancleSubApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("CreatePasswordResponseModel=e==>$e");
      _cancleSubApiResponse = ApiResponse.error(message: 'error');
      updateLoading(false);
    }
    update();
  }
}
