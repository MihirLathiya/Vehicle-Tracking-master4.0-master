import 'package:vehicletracking/models/response_model/subscription_detail_res_model.dart';
import 'package:vehicletracking/models/services/api_service.dart';
import 'package:vehicletracking/models/services/base_service.dart';

class SubscriptionDetailsRepo extends BaseService {
  Future<SubscriptionDetailsResponseModel> subscriptionDetailsRepo() async {
    var response = await APIService()
        .getResponse(url: subscriptionDetail, apitype: APIType.aGet);

    SubscriptionDetailsResponseModel subscriptionDetailsResponseModel =
        await SubscriptionDetailsResponseModel.fromJson(response);
    print('SubscriptionDetailsResponseModel $response');
    return subscriptionDetailsResponseModel;
  }
}
