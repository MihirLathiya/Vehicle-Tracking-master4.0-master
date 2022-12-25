import 'package:vehicletracking/models/response_model/sub_slot_res_model.dart';
import 'package:vehicletracking/models/services/api_service.dart';
import 'package:vehicletracking/models/services/base_service.dart';

class SubscriptionSlotDetailsRepo extends BaseService {
  Future<SubscriptionSlotResponseModel> subscriptionSlotDetailsRepo(
      {String id}) async {
    var response = await APIService().getResponse(
        url: '${subscriptionSlotDetail}$id', apitype: APIType.aGet);

    SubscriptionSlotResponseModel subscriptionSlotResponseModel =
        await SubscriptionSlotResponseModel.fromJson(response);
    print('SubscriptionSlotResponseModel $response');
    return subscriptionSlotResponseModel;
  }
}
