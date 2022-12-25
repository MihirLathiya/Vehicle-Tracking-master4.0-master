import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/repo/subscription_details_repo.dart';
import 'package:vehicletracking/models/response_model/subscription_detail_res_model.dart';

class SubscriptionDetailsViewModel extends GetxController {
  ApiResponse _subscriptionDetailApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get subscriptionDetailApiResponse =>
      _subscriptionDetailApiResponse;

  Future<void> subscriptionDetailsViewModel() async {
    _subscriptionDetailApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      GetSubscriptionResponseModel response =
          await SubscriptionDetailsRepo().subscriptionDetailsRepo();
      print("SubscriptionDetailsResponseModel=response==>$response");

      _subscriptionDetailApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("SubscriptionDetailsResponseModel=e==>$e");
      _subscriptionDetailApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
