import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/pages/not_subscribed/choose_plan_screen.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';
import 'package:vehicletracking/utils/app_assets.dart';
import 'package:vehicletracking/utils/app_colors.dart';
import 'package:vehicletracking/utils/app_static_decoration.dart';
import 'package:vehicletracking/utils/app_text_style.dart';
import 'package:vehicletracking/utils/validators.dart';
import 'package:vehicletracking/view_model/add_number_view_model.dart';
import 'package:vehicletracking/widgets/app_button.dart';
import 'package:vehicletracking/widgets/app_text_form_field.dart';

class ParkingSlotScreen extends StatefulWidget {
  final duration, location, vehicleType, slotType, slotQuntity, placeId;
  final subId;
  final dataVehicle;
  const ParkingSlotScreen(
      {Key key,
      this.duration,
      this.location,
      this.vehicleType,
      this.slotType,
      this.slotQuntity,
      this.placeId,
      this.subId,
      this.dataVehicle})
      : super(key: key);

  @override
  State<ParkingSlotScreen> createState() => _ParkingSlotScreenState();
}

class _ParkingSlotScreenState extends State<ParkingSlotScreen> {
  TextEditingController vehicleNumber = TextEditingController();

  AddNumberViewModel addNumberViewModel = Get.put(AddNumberViewModel());
  List vehicleNumberList = [];
  List vehicleNumberList1 = [];
  List selectIndex = [];
  List selectIndex1 = [];
  int Counter = 1;
  dynamic parkingSlot;
  bool types = false;
  List parkingBike;
  int selectedBike = 0;
  int selectedCar = 0;
  List selectedSlot = [];
  List parkingCar;
  bool x = false;

  getParkingSlot() async {
    setState(() {
      x = false;
    });
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var request = await http.get(
        Uri.parse(
            'https://i.invoiceapi.ml/api/customer/place/edit/${widget.placeId}'),
        headers: headers);

    if (request.statusCode == 200) {
      var data = jsonDecode(request.body);
      parkingSlot = await data;
      log('RESSOR :- ${parkingSlot}');
      parkingBike = parkingSlot['parking_place_slot_list']['two_wheeler'];
      parkingCar = parkingSlot['parking_place_slot_list']['four_wheeler'];

      log('BIKE PARKING :- ${parkingBike}');
      log('FOUR PARKING :- ${parkingCar}');

      setState(() {
        x = true;
      });
    } else {
      CommonSnackBar.commonSnackBar(message: request.reasonPhrase);
      setState(() {
        x = false;
      });
    }
  }

  @override
  void initState() {
    vehicleNumberList.insert(Counter - 1, vehicleNumber);
    getParkingSlot();

    // selectedSlot = [int.parse(widget.slotQuntity)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('VEHICLE TYPE : ${widget.slotQuntity}');
    log('VEHICLE TYPE : ${widget.dataVehicle}');
    log('VEHICLE TYPE : ${widget.vehicleType}');
    log('VEHICLE TYPE : ${widget.placeId}');
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: blackColor,
          ),
        ),
        title: Text(
          'Parking Slot',
          style: AppTextStyle.normalSemiBold8.copyWith(fontSize: 18),
        ),
      ),
      body: x == true
          ? Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppAsset.bgGroundTop,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 22.0,
                      right: 22.0,
                      top: 120,
                    ),
                    child: Divider(
                      height: 2,
                      color: borderGreyColor,
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 1.7,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          /// BIKE
                          // widget.dataVehicle == 'two_wheeler' ||
                          //         widget.dataVehicle == 'Two Wheel'
                          //     ?
                          GridView.builder(
                            shrinkWrap: true,

                            itemCount: parkingBike.length,
                            // shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4),
                            itemBuilder: (context, index) {
                              log('get Type :==== ${widget.dataVehicle}');
                              return Column(
                                children: [
                                  Text(parkingBike[index]['parking_slot_name']),
                                  height05,
                                  GestureDetector(
                                    onTap: () {
                                      if (widget.vehicleType == 'Two Wheel' ||
                                          widget.vehicleType == 'two_wheeler') {
                                        if (parkingBike[index]['status'] == 1) {
                                          CommonSnackBar.commonSnackBar(
                                              message: 'This slot is selected');
                                        } else {
                                          setState(() {
                                            selectedBike = index;
                                            types = false;
                                          });
                                          log('VALUE TYPE :- $selectedBike');
                                          try {
                                            if (selectedSlot.length <
                                                int.parse(widget.slotQuntity)) {
                                              showAddDialog();
                                            } else {
                                              CommonSnackBar.commonSnackBar(
                                                  message: 'Not allow');
                                            }
                                          } catch (e) {
                                            CommonSnackBar.commonSnackBar(
                                                message: 'Not allow');
                                          }
                                        }
                                      } else {
                                        CommonSnackBar.commonSnackBar(
                                            message: 'slot is disable');
                                      }
                                    },
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: selectIndex.contains(index)
                                            ? Colors.red
                                            : widget.vehicleType ==
                                                        'Four Wheel' ||
                                                    widget.vehicleType ==
                                                        'four_wheeler'
                                                ? Colors.grey.shade300
                                                : parkingBike[index]
                                                            ['status'] ==
                                                        1
                                                    ? Colors.grey
                                                    : parkingBike[index][
                                                                    'vehicle_type'] ==
                                                                'two_wheeler' ||
                                                            parkingBike[index][
                                                                    'vehicle_type'] ==
                                                                'Two Wheel'
                                                        ? Colors.green
                                                        : Colors.grey,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          parkingBike[index]['vehicle_type'] ==
                                                  'two_wheeler'
                                              ? AppAsset.bike
                                              : AppAsset.newcar,
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                          // : SizedBox(),

                          /// CAR

                          GridView.builder(
                            itemCount: parkingCar.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Text(parkingCar[index]['parking_slot_name']),
                                  height05,
                                  GestureDetector(
                                    onTap: () {
                                      if (widget.vehicleType == 'Four Wheel' ||
                                          widget.vehicleType ==
                                              'four_wheeler') {
                                        if (parkingCar[index]['status'] == 1) {
                                          CommonSnackBar.commonSnackBar(
                                              message: 'This slot is selected');
                                        } else {
                                          setState(() {
                                            selectedCar = index;
                                            types = true;
                                          });
                                          log('VALUE TYPE :- $types');
                                          try {
                                            if (selectedSlot.length <
                                                int.parse(widget.slotQuntity)) {
                                              showAddDialog();
                                            } else {
                                              CommonSnackBar.commonSnackBar(
                                                  message: 'Not allow');
                                            }
                                          } catch (e) {
                                            CommonSnackBar.commonSnackBar(
                                                message: 'Not allow');
                                          }
                                        }
                                      } else {
                                        CommonSnackBar.commonSnackBar(
                                            message: 'slot is disable');
                                      }
                                    },
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: selectIndex1.contains(index)
                                            ? Colors.red
                                            : widget.vehicleType ==
                                                        'Two Wheel' ||
                                                    widget.vehicleType ==
                                                        'two_wheeler'
                                                ? Colors.grey.shade300
                                                : parkingCar[index]['status'] ==
                                                        1
                                                    ? Colors.grey
                                                    : parkingCar[index][
                                                                    'vehicle_type'] ==
                                                                'four_wheeler' ||
                                                            parkingCar[index][
                                                                    'vehicle_type'] ==
                                                                'Four Wheel'
                                                        ? Colors.green
                                                        : Colors.grey,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          parkingCar[index]['vehicle_type'] ==
                                                  'four_wheeler'
                                              ? AppAsset.newcar
                                              : AppAsset.bike,
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                          height25,
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: greyColor,
                            ),
                          ),
                          width05,
                          const Text('Reserved')
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: appColor,
                            ),
                          ),
                          width05,
                          const Text('Selected')
                        ],
                      )
                    ],
                  ),
                  height25,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: greenColor,
                            ),
                          ),
                          width05,
                          const Text('Available')
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: greyColor.withOpacity(0.2),
                            ),
                          ),
                          width05,
                          const Text('Disabled')
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    child: AppFillButton(
                      title: 'Next',
                      onTap: () async {
                        log('LEANGHT:- ${selectedSlot.length}');
                        if (selectedSlot.length ==
                            int.parse(widget.slotQuntity)) {
                          if (vehicleNumber.text.isNotEmpty) {
                            vehicleNumberList1.clear();
                            for (int i = 0; i < vehicleNumberList.length; i++) {
                              vehicleNumberList1.insert(i,
                                  '"${vehicleNumberList[i].text.toString()}"');
                            }

                            log('VEHICLE LIST:- $vehicleNumberList1');
                            log('HELLO LISTS :- ${vehicleNumberList1}');
                            await addNumberViewModel.addNumberViewModel(model: {
                              'vehicle_number': '$vehicleNumberList1'
                            });
                            if (addNumberViewModel
                                    .addNumberApiResponse.status ==
                                Status.COMPLETE) {
                              log('SELECTED TYPE:- ${selectedSlot}');

                              Get.to(
                                () => ChoosePlanScreen(
                                  slotList: selectedSlot,
                                  subId: widget.subId,
                                  placeId: PreferenceManager.getPlaceId(),
                                  duration: widget.duration,
                                  location: widget.location,
                                  vehicleType: widget.vehicleType,
                                  vehicleNumber: vehicleNumberList1,
                                  slotType: widget.slotType,
                                  slotQuntity: widget.slotQuntity,
                                ),
                              );
                            }
                          } else {
                            CommonSnackBar.commonSnackBar(
                                message: 'Add number');
                          }
                        } else if (selectedSlot.length >=
                            int.parse(widget.slotQuntity)) {
                          CommonSnackBar.commonSnackBar(
                              message: 'you select more than slot quantity');
                        } else {
                          CommonSnackBar.commonSnackBar(
                              message: 'you select less than slot quantity');
                        }
                      },
                      radius: 10,
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  void showAddDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState1) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 16,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: Counter,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          AppTextField(
                            labelText: 'Vehicle Number',
                            controller: vehicleNumberList[index],
                          ),
                          height15,
                        ],
                      );
                    },
                  ),
                  height15,
                  GestureDetector(
                    onTap: () {
                      setState1(() {
                        try {
                          if (selectedSlot.length <
                              int.parse(widget.slotQuntity)) {
                            Counter++;

                            vehicleNumberList.insert(
                                Counter - 1, TextEditingController());
                          } else {
                            CommonSnackBar.commonSnackBar(message: 'Not allow');
                          }
                        } catch (e) {}
                      });
                      log('Vehicle List :- $vehicleNumberList');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const Icon(
                          Icons.add,
                          color: appColor,
                        ),
                        Text(
                          'Add More',
                          style: AppTextStyle.normalSemiBold16.copyWith(
                            color: appColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  height15,
                  Row(
                    children: [
                      Expanded(
                        child: AppBorderButton(
                          onTap: () {
                            // selectedSlot = {};
                            Get.back();
                          },
                          title: 'Back',
                          height: 45,
                          radius: 10,
                        ),
                      ),
                      width10,
                      Expanded(
                        child: AppFillButton(
                          onTap: () async {
                            if (vehicleNumber.text.isNotEmpty) {
                              if (types == false) {
                                log('SELECT SLOT :- ${selectedSlot.length}');
                                log('SELECT SLOT :- ${int.parse(widget.slotQuntity)}');
                                try {
                                  if (selectedSlot.length <
                                      int.parse(widget.slotQuntity)) {
                                    selectedSlot.add({
                                      '"parking_name"':
                                          '"${parkingBike[selectedBike]['parking_slot_name']}"',
                                      '"vehicle_type"':
                                          '"${parkingBike[selectedBike]['vehicle_type']}"',
                                    }.toString().trim());

                                    selectIndex.add(selectedBike);
                                    selectedSlot =
                                        selectedSlot.toSet().toList();
                                    selectIndex = selectIndex.toSet().toList();
                                    log('SELECT SLOT :- ${selectedSlot.length}');

                                    log('SELECTED SLOT :- ${selectedSlot}');
                                  } else {
                                    // CommonSnackBar.commonSnackBar(
                                    //     message: 'Not allow');
                                    log('Not allow');
                                  }
                                } catch (e) {
                                  log('ERROR :- $e');
                                }
                                Get.back();
                              } else {
                                try {
                                  if (selectedSlot.length <
                                      int.parse(widget.slotQuntity)) {
                                    selectedSlot.add({
                                      '"parking_name"':
                                          '"${parkingCar[selectedCar]['parking_slot_name']}"',
                                      '"vehicle_type"':
                                          '"${parkingCar[selectedCar]['vehicle_type']}"',
                                    }.toString().trim());
                                    selectIndex1.add(selectedCar);
                                    selectedSlot =
                                        selectedSlot.toSet().toList();
                                    selectIndex1 =
                                        selectIndex1.toSet().toList();

                                    log('SELECTED SLOT :- ${selectedSlot}');
                                  }
                                } catch (e) {}
                                Get.back();
                              }
                            } else {
                              log('ENTER NO');
                            }
                          },
                          title: 'Add',
                          height: 45,
                          radius: 10,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() => setState(() {}));
  }
}
