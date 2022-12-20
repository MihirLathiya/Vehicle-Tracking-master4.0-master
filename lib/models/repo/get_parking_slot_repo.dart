import 'package:vehicletracking/models/response_model/get_parking_slot_res_model.dart';
import 'package:vehicletracking/models/services/api_service.dart';
import 'package:vehicletracking/models/services/base_service.dart';

class GetParkingSlotRepo extends BaseService {
  Future<GetParkingSlotResponseModel> getParkingSlotRepo(
      {accountNo, placeId = '1'}) async {
    var response = await APIService().getResponse(
        url:
            'https://i.invoiceapi.ml/api/customer/getParkingSlot?place_id=$placeId&account_number=$accountNo',
        apitype: APIType.aGet);

    GetParkingSlotResponseModel getParkingSlotResponseModel =
        await GetParkingSlotResponseModel.fromJson(response);
    print('GetParkingSlotResponseModel $response');
    return getParkingSlotResponseModel;
  }
}
