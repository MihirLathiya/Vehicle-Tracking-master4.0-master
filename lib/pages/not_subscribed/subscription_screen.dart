import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/pages/not_subscribed/choose_plan_screen.dart';
import 'package:vehicletracking/pages/not_subscribed/parking_slot_screen.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';
import 'package:vehicletracking/utils/app_assets.dart';
import 'package:vehicletracking/utils/app_colors.dart';
import 'package:vehicletracking/utils/app_static_decoration.dart';
import 'package:vehicletracking/utils/app_text_style.dart';
import 'package:vehicletracking/utils/validators.dart';
import 'package:vehicletracking/view_model/add_number_view_model.dart';
import 'package:vehicletracking/view_model/plan_details_get_repo.dart';
import 'package:vehicletracking/widgets/app_button.dart';
import 'package:vehicletracking/widgets/app_text_form_field.dart';

class SubScriptionScreen extends StatefulWidget {
  final subId, slotType;
  const SubScriptionScreen({Key key, this.subId, this.slotType})
      : super(key: key);

  @override
  State<SubScriptionScreen> createState() => _SubScriptionScreenState();
}

class _SubScriptionScreenState extends State<SubScriptionScreen> {
  String duration;
  // String location;
  String vehicleType;
  String typeOfSlot;
  String qty;
  bool isLoading = true;
  TextEditingController qtyController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  List parkingPlace = [];
  List slotList = [];
  List data;
  getParkingPlace() async {
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var request = http.Request('GET',
        Uri.parse('https://i.invoiceapi.ml/api/customer/getParkingPlace'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var parkingPlace1 = jsonDecode(await response.stream.bytesToString());

      print('----parkingPlace1--${parkingPlace1['data']}');

      parkingPlace1['data'].forEach((value) {
        print('value===> ${value}');

        parkingPlace.add('${value['id']} ${value['name']}');
      });
      setState(() {});
      print('PARKING PLACE :- ${parkingPlace}');
    } else {
      print(response.reasonPhrase);
    }
  }

  TextEditingController vehicleNumber = TextEditingController();
  PlanDetailsViewModel planDetailsViewModel = Get.put(PlanDetailsViewModel());

  AddNumberViewModel addNumberViewModel = Get.put(AddNumberViewModel());

  List vehicleNumberList = [];
  List vehicleNumberList1 = [];
  int Counter = 1;

  @override
  void initState() {
    vehicleNumberList.insert(Counter - 1, vehicleNumber);
    planDetailsViewModel.subscriptionViewModel(
        id: '${PreferenceManager.getPlaceId()}');
    locationController.text = PreferenceManager.getPlaceName();
    typeOfSlot = widget.slotType;
    getParkingPlace();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Stack(
              children: [
                Stack(
                  children: [
                    Container(
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
                    ),
                    Image.asset(
                      AppAsset.subscriptionTopImage,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 10,
                    top: 280,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Subscription',
                          style: AppTextStyle.bold20,
                        ),
                      ),
                      height15,
                      height20,

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: locationController,
                          keyboardType: TextInputType.number,
                          readOnly: true,
                          decoration: InputDecoration(
                            label: const Text('Location*'),
                            contentPadding: const EdgeInsets.all(
                              20,
                            ),
                            hintText: 'Location*',
                            hintStyle: AppTextStyle.normalRegular14
                                .copyWith(color: greyColor),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      height15,
                      StatefulBuilder(
                        builder: (context, state) {
                          Future.delayed(Duration.zero, () {
                            state(() {});
                          });
                          return DropdownButtonHideUnderline(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      'Duration*',
                                      style: AppTextStyle.normalRegular14
                                          .copyWith(
                                              color: greyColor, fontSize: 16),
                                    ),
                                  ),
                                  suffixIcon: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: blackColor,
                                    ),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                ),
                                iconSize: 0.0,
                                hint: duration == null
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text('Duration',
                                            style: AppTextStyle.normalRegular14
                                                .copyWith(color: greyColor)),
                                      )
                                    : Text(
                                        duration.toString(),
                                        style:
                                            const TextStyle(color: blackColor),
                                      ),
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(30),
                                style: const TextStyle(color: blackColor),
                                items: planDetailsViewModel.planDuration.map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(val),
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      duration = val.toString();
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      height20,
                      // DropdownButtonHideUnderline(
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 10),
                      //     child: DropdownButtonFormField(
                      //       value: location,
                      //       decoration: InputDecoration(
                      //         label: Padding(
                      //           padding:
                      //               const EdgeInsets.symmetric(horizontal: 10),
                      //           child: Text(
                      //             'Location*',
                      //             style: AppTextStyle.normalRegular14
                      //                 .copyWith(color: greyColor, fontSize: 16),
                      //           ),
                      //         ),
                      //         suffixIcon: const Padding(
                      //           padding: EdgeInsets.all(10.0),
                      //           child: Icon(
                      //             Icons.keyboard_arrow_down_outlined,
                      //             color: blackColor,
                      //           ),
                      //         ),
                      //         border: const OutlineInputBorder(
                      //           borderRadius: BorderRadius.all(
                      //             Radius.circular(15.0),
                      //           ),
                      //         ),
                      //       ),
                      //       iconSize: 0.0,
                      //       hint:
                      //           // location == null
                      //           //     ?
                      //           Padding(
                      //         padding:
                      //             const EdgeInsets.symmetric(horizontal: 10.0),
                      //         child: Text(
                      //           'Location',
                      //           style: AppTextStyle.normalRegular14.copyWith(
                      //             color: greyColor,
                      //           ),
                      //         ),
                      //       ),
                      //       // : Text(
                      //       //     location.toString(),
                      //       //     style: const TextStyle(color: blackColor),
                      //       //   ),
                      //       isExpanded: true,
                      //       borderRadius: BorderRadius.circular(30),
                      //       style: const TextStyle(color: blackColor),
                      //       items: parkingPlace.map(
                      //         (val) {
                      //           return DropdownMenuItem(
                      //             value: val,
                      //             child: Padding(
                      //               padding: const EdgeInsets.symmetric(
                      //                   horizontal: 15),
                      //               child: Text(val),
                      //             ),
                      //           );
                      //         },
                      //       ).toList(),
                      //       onChanged: (val) {
                      //         setState(
                      //           () {
                      //             location = val.toString();
                      //           },
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),
                      DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              label: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Type Of Slot*',
                                  style: AppTextStyle.normalRegular14
                                      .copyWith(color: greyColor, fontSize: 16),
                                ),
                              ),
                              suffixIcon: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: blackColor,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                            ),
                            iconSize: 0.0,
                            hint: typeOfSlot == null
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text('Type Of Slot',
                                        style: AppTextStyle.normalRegular14
                                            .copyWith(color: greyColor)),
                                  )
                                : Text(
                                    typeOfSlot.toString(),
                                    style: const TextStyle(color: blackColor),
                                  ),
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(30),
                            style: const TextStyle(color: blackColor),
                            items: ['Reserved', 'Open'].map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(val),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  typeOfSlot = val.toString();
                                  log('TYPE OF SLOT :- ${typeOfSlot}');
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      height20,
                      DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              label: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Vehicle Type*',
                                  style: AppTextStyle.normalRegular14
                                      .copyWith(color: greyColor, fontSize: 16),
                                ),
                              ),
                              suffixIcon: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: blackColor,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                            ),
                            iconSize: 0.0,
                            hint: vehicleType == null
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text('Vehicle Type',
                                        style: AppTextStyle.normalRegular14
                                            .copyWith(color: greyColor)),
                                  )
                                : Text(
                                    vehicleType.toString(),
                                    style: const TextStyle(color: blackColor),
                                  ),
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(30),
                            style: const TextStyle(color: blackColor),
                            items: ['Two Wheel', 'Four Wheel'].map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(val),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  vehicleType = val.toString();
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      height20,

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: qtyController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: const Text('Slot Quantity*'),
                            contentPadding: const EdgeInsets.all(
                              20,
                            ),
                            hintText: 'Slot Quantity',
                            hintStyle: AppTextStyle.normalRegular14
                                .copyWith(color: greyColor),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      height20,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AppFillButton(
                          title: "Next",
                          radius: 10,
                          onTap: () async {
                            if (typeOfSlot == 'Open') {
                              showAddDialog();
                            } else if (duration != null &&
                                    locationController.text != null &&
                                    qtyController.text != null &&
                                    vehicleType != null &&
                                    typeOfSlot == 'Reserved' ||
                                typeOfSlot == 'reserved') {
                              // String placeId = location.split(' ').first;
                              // log(' PlaceId :- ${placeId}');
                              log('DONES1');
                              PreferenceManager.setDuration(duration);

                              Get.to(
                                () => ParkingSlotScreen(
                                  subId: widget.subId,
                                  placeId: '${PreferenceManager.getPlaceId()}',
                                  duration: duration,
                                  location: locationController.text,
                                  slotQuntity: qtyController.text,
                                  vehicleType: vehicleType,
                                  slotType: typeOfSlot.toLowerCase(),
                                ),
                              );
                            } else {
                              CommonSnackBar.commonSnackBar(
                                  message: 'Please fill details');
                            }

                            log('BARRIRE :- ${PreferenceManager.getBariear()}');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_rounded,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAddDialog() {
    showDialog(
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
                        Counter++;
                        vehicleNumberList.insert(
                            Counter - 1, TextEditingController());
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
                              vehicleNumberList1.clear();
                              for (int i = 0;
                                  i < vehicleNumberList.length;
                                  i++) {
                                vehicleNumberList1.insert(
                                    i, '"${vehicleNumberList[i].text}"');
                              }
                              log('HELLO LISTS :- ${vehicleNumberList1}');
                              await addNumberViewModel.addNumberViewModel(
                                  model: {
                                    'vehicle_number': '$vehicleNumberList1'
                                  });
                              if (addNumberViewModel
                                      .addNumberApiResponse.status ==
                                  Status.COMPLETE) {
                                PreferenceManager.setDuration(duration);

                                PreferenceManager.setDuration(duration);

                                slotList.add({
                                  '"parking_name"': '"NA"',
                                  '"vehicle_type"': '"$vehicleType"'
                                }.toString());
                                Get.to(() => ChoosePlanScreen(
                                      slotList: slotList,
                                      placeId: PreferenceManager.getPlaceId(),
                                      duration: duration,
                                      location: locationController.text,
                                      vehicleType: vehicleType,
                                      vehicleNumber: vehicleNumberList1,
                                      slotType: typeOfSlot.toLowerCase(),
                                      slotQuntity: qtyController.text,
                                    ));
                              } else {
                                CommonSnackBar.commonSnackBar(
                                    message: 'Try Again...');
                              }
                            } else {
                              log('ENTER NO');
                            }
                          },
                          title: 'Next',
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
    );
  }
}
