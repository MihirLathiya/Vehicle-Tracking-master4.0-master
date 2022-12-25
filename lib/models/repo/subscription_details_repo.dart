import 'package:vehicletracking/models/response_model/subscription_detail_res_model.dart';
import 'package:vehicletracking/models/services/api_service.dart';
import 'package:vehicletracking/models/services/base_service.dart';

class SubscriptionDetailsRepo extends BaseService {
  Future<GetSubscriptionResponseModel> subscriptionDetailsRepo() async {
    var response = await APIService()
        .getResponse(url: subscriptionDetail, apitype: APIType.aGet);

    GetSubscriptionResponseModel getSubscriptionResponseModel =
        await GetSubscriptionResponseModel.fromJson(response);
    print('GetSubscriptionResponseModel $response');
    return getSubscriptionResponseModel;
  }
}
