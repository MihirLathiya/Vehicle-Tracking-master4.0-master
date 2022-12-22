import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/response_model/get_parking_slot_res_model.dart';
import 'package:vehicletracking/pages/not_subscribed/subscription_screen.dart';
import 'package:vehicletracking/pages/settings/setting_screen.dart';
import 'package:vehicletracking/pages/subscribed/go_to_your_subcription_screen.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';
import 'package:vehicletracking/utils/app_assets.dart';
import 'package:vehicletracking/utils/app_colors.dart';
import 'package:vehicletracking/utils/app_static_decoration.dart';
import 'package:vehicletracking/utils/app_text_style.dart';
import 'package:vehicletracking/utils/validators.dart';
import 'package:vehicletracking/view_model/get_parking_slot_view_model.dart';
import 'package:vehicletracking/view_model/image_controller.dart';
import 'package:vehicletracking/widgets/app_button.dart';

class SlotDetailsScreen extends StatefulWidget {
  final bool isSubscribed;
  const SlotDetailsScreen({Key key, this.isSubscribed}) : super(key: key);

  @override
  State<SlotDetailsScreen> createState() => _SlotDetailsScreenState();
}

class _SlotDetailsScreenState extends State<SlotDetailsScreen> {
  GetParkingSlotViewModel getParkingSlotViewModel =
      Get.put(GetParkingSlotViewModel());
  TextEditingController description = TextEditingController();
  ImageController imageController = Get.put(ImageController());
  List parkingPlace = [];
  dynamic location;
  bool enabled = false;
  getParkingPlace() async {
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var request = http.Request('GET',
        Uri.parse('https://i.invoiceapi.ml/api/customer/getParkingPlace'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var parkingPlace1 = jsonDecode(await response.stream.bytesToString());

      print('----parkingPlace1--${parkingPlace1['data']}');

      await parkingPlace1['data'].forEach((value) {
        print('value===> ${value}');

        parkingPlace
            .add('${value['id']}  ${value['name']}   ${value['base_amount']}');
      });
      setState(() {});
      print('PARKING PLACE :- ${parkingPlace}');
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    log('PREFRENCE :- ${PreferenceManager.getBariear()}');
    imageController.apiCalling();
    getParkingPlace();
    log('DTAA :- ${PreferenceManager.getAccountNo()} , ${PreferenceManager.getPlaceId()}');
    getParkingSlotViewModel.getParkingSlotViewModel(
      accountNo: PreferenceManager.getAccountNo(),
      placeId: '${PreferenceManager.getPlaceId() ?? '1'}',
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('ACCOUNT NO:- ${PreferenceManager.getAccountNo()}');
    return Scaffold(
      body: Stack(
        // alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.asset(
            AppAsset.bgGroundTop,
            width: Get.width,
            fit: BoxFit.fitWidth,
            // height: Get.height,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: GetBuilder<GetParkingSlotViewModel>(
                          builder: (controller) {
                            if (controller.getParkingSlotApiResponse.status
                                    .toString() ==
                                Status.LOADING.toString()) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (controller.getParkingSlotApiResponse.status
                                    .toString() ==
                                Status.COMPLETE.toString()) {
                              GetParkingSlotResponseModel response =
                                  controller.getParkingSlotApiResponse.data;
                              controller.updateText(response.data.description);
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      '${response.data.image}',
                                      width: Get.width,
                                      height: 220,
                                      fit: BoxFit.fitWidth,
                                      // height: Get.height,
                                    ),
                                  ),
                                  height15,
                                  welcomeWidget(),
                                  height15,
                                  availableSlotsWidget(
                                      bike: response.data.twoWheeler == null ||
                                              PreferenceManager.getPlaceId() ==
                                                  null ||
                                              PreferenceManager.getPlaceId() ==
                                                  ''
                                          ? '0'
                                          : '${response.data.twoWheeler}',
                                      car: response.data.fourWheeler == null ||
                                              PreferenceManager.getPlaceId() ==
                                                  null ||
                                              PreferenceManager.getPlaceId() ==
                                                  ''
                                          ? '0'
                                          : '${response.data.fourWheeler}'),
                                  height15,
                                  monthlySubscriptionWidget(
                                      '${response.data.subscription}'),
                                  height15,
                                  descriptionWidget(response),
                                ],
                              );
                            }
                            // else {
                            return Center(
                              child: Text(
                                'Try Again...',
                              ),
                            );
                            // }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GetBuilder<ImageController>(
            builder: (controller) {
              if (controller.loading == true) {
                return SizedBox();
              } else {
                return SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                            () => SettingScreen(),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: CachedNetworkImage(
                            height: 45,
                            width: 45,
                            imageUrl: '${controller.url}',
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Icon(Icons.menu),
                            ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    Shimmer.fromColors(
                              baseColor: Colors.white.withOpacity(0.4),
                              highlightColor: Colors.white.withOpacity(0.2),
                              enabled: true,
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
      bottomNavigationBar: button(),
    );
  }

  Widget welcomeWidget() {
    return Container(
      width: Get.width,
      height: 120,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(
          color: borderGreyColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Welcome, User!',
            style: AppTextStyle.normalSemiBold20,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButton(
                  value: PreferenceManager.getName1() == null
                      ? location
                      : PreferenceManager.getName1(),
                  isExpanded: true,
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text('Location',
                        style: AppTextStyle.normalRegular14
                            .copyWith(color: greyColor)),
                  ),
                  underline: const SizedBox(),
                  onChanged: (val) async {
                    setState(
                      () {
                        location = val.toString();
                        log('LOCATION DATA :- ${location.toString().split('  ').first}');
                        PreferenceManager.setName1(location);
                        PreferenceManager.setPlaceId(
                            location.toString().split('  ').first);
                        PreferenceManager.setPlaceName(
                            location.toString().split('  ')[1]);
                      },
                    );
                    log('LOCATION :- ${PreferenceManager.getPlaceName()}');

                    await getParkingSlotViewModel.getParkingSlotViewModel(
                        accountNo: PreferenceManager.getAccountNo(),
                        placeId: '${PreferenceManager.getPlaceId()}',
                        loading: false);
                  },
                  items: parkingPlace.map(
                    (val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                              '${val.toString().split('  ')[1]} ${val.toString().split('  ')[2]}'),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget availableSlotsWidget({car, bike}) {
    return Container(
      width: Get.width,
      height: 110,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(
          color: borderGreyColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Available Parking Slots',
            style: AppTextStyle.normalRegular14.copyWith(
              color: greyColor,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width / 2 - 32,
                child: Row(
                  children: [
                    Image.asset(
                      AppAsset.motorCycle,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '$bike',
                      style: AppTextStyle.normalRegular16,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width / 2 - 32,
                child: Row(
                  children: [
                    Image.asset(
                      AppAsset.car,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '$car',
                      style: AppTextStyle.normalRegular16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget monthlySubscriptionWidget(x) {
    return Container(
      width: Get.width,
      height: 85,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(
          color: borderGreyColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Current monthly Subscription',
            style: AppTextStyle.normalRegular14.copyWith(
              color: greyColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '$x',
            style: AppTextStyle.normalRegular16,
          ),
        ],
      ),
    );
  }

  Widget descriptionWidget(GetParkingSlotResponseModel response) {
    return Container(
      width: Get.width,
      height: 130,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(
          color: borderGreyColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            maxLines: 3,
            style: AppTextStyle.normalRegular14.copyWith(
              color: blackColor,
            ),
            enabled: enabled,
            // controller: getParkingSlotViewModel.des,
            controller: TextEditingController(
                text: PreferenceManager.getPlaceId() == null ||
                        PreferenceManager.getPlaceId() == ''
                    ? ''
                    : response.data.description),
            decoration: InputDecoration(
              hintText: 'Description',
              hintStyle: AppTextStyle.normalRegular14.copyWith(
                color: greyColor,
              ),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppFillButton(
            onTap: () {
              setState(() {});
              // widget.isSubscribed == true
              //     ?
              // if (PreferenceManager.getPlaceId() != null) {
              Get.to(() => const GotoYourSubscriptionScreen());
              // } else {
              //   CommonSnackBar.commonSnackBar(message: 'Select place first');
              // }

              // : Get.to(() => const SubScriptionScreen());
            },
            title: 'Go to Your Subscription',
            width: Get.width,
            height: 50,
            radius: 10,
          ),
          // if (widget.isSubscribed == true)
          height15,
          // if (widget.isSubscribed == true)
          AppBorderButton(
            onTap: () {
              if (PreferenceManager.getPlaceId() != null) {
                Get.to(() => SubScriptionScreen());
              } else {
                CommonSnackBar.commonSnackBar(message: 'Select place first');
              }
            },
            title: 'Add Another Subscription ',
            width: Get.width,
            height: 50,
            radius: 10,
          ),
        ],
      ),
    );
  }
}
