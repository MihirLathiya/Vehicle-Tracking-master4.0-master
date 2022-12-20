import 'package:vehicletracking/models/response_model/cancle_sub_res_model.dart';
import 'package:vehicletracking/models/services/api_service.dart';
import 'package:vehicletracking/models/services/base_service.dart';

class CancleSubRepo extends BaseService {
  Future<CancleSubscriptionResponseModel> cancleSubRepo({String id}) async {
    var response = await APIService().getResponse(
        url: 'https://i.invoiceapi.ml/api/customer/cancelSubscription/${id}',
        apitype: APIType.aGet);

    CancleSubscriptionResponseModel cancleSubscriptionResponseModel =
        await CancleSubscriptionResponseModel.fromJson(response);
    return cancleSubscriptionResponseModel;
  }
}
