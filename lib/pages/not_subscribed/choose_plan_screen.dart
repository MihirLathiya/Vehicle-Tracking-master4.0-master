import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/pages/payment/order_summary_screen.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';
import 'package:vehicletracking/utils/app_assets.dart';
import 'package:vehicletracking/utils/app_colors.dart';
import 'package:vehicletracking/utils/app_static_decoration.dart';
import 'package:vehicletracking/utils/app_text_style.dart';
import 'package:vehicletracking/utils/validators.dart';
import 'package:vehicletracking/view_model/access_controller_view_model.dart';
import 'package:vehicletracking/view_model/plan_details_get_repo.dart';
import 'package:vehicletracking/widgets/app_button.dart';

class ChoosePlanScreen extends StatefulWidget {
  final duration, location, vehicleType, slotType, slotQuntity, placeId;
  final vehicleNumber;
  final slotList;
  final subId;
  const ChoosePlanScreen(
      {Key key,
      this.duration,
      this.location,
      this.vehicleType,
      this.slotType,
      this.slotQuntity,
      this.vehicleNumber,
      this.placeId,
      this.subId,
      this.slotList})
      : super(key: key);

  @override
  State<ChoosePlanScreen> createState() => _ChoosePlanScreenState();
}

class _ChoosePlanScreenState extends State<ChoosePlanScreen> {
  PageController controller = PageController();
  RxInt selectedIndex = 0.obs;
  RxList commonCheckboxValue = [
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs
  ].obs;
  RxInt accessControlsCount = 2.obs;
  RxBool accessControlsAdded = false.obs;
  List accesControll = [];
  List accesControllId = [];
  List accesControllPrice = [];
  PlanDetailsViewModel planDetailsViewModel = Get.put(PlanDetailsViewModel());
  AccessController accessController = Get.put(AccessController());
  @override
  void initState() {
    log('PLACE ID :- ${widget.placeId == null ? PreferenceManager.getPlaceId() : widget.placeId}');
    planDetailsViewModel.subscriptionViewModel(
        id: widget.placeId == null
            ? PreferenceManager.getPlaceId()
            : widget.placeId);
    accessController.accessControllerViewModel(
        id: widget.placeId == null
            ? PreferenceManager.getPlaceId()
            : widget.placeId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('SLOT LIST :-${widget.slotList}');
    return Scaffold(
      body: GetBuilder<PlanDetailsViewModel>(
        builder: (subController) {
          if (subController.subscriptionApiResponse.status == Status.LOADING) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (subController.subscriptionApiResponse.status == Status.COMPLETE) {
            dynamic subData = subController.subscriptionApiResponse.data;

            return Stack(
              children: [
                Container(
                  width: Get.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAsset.choosePlan),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomCenter,
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 70, left: 25, right: 25),
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              AppAsset.paymentbackground),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        height20,
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          decoration: BoxDecoration(
                                              color:
                                                  whiteColor.withOpacity(0.14),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Text(
                                            'Silver',
                                            style: AppTextStyle.normalRegular14
                                                .copyWith(color: greyColor),
                                          ),
                                        ),
                                        height20,
                                        Text(
                                          '${subController.planDetails['price']}/-',
                                          style: AppTextStyle.normalSemiBold20
                                              .copyWith(
                                                  fontSize: 35,
                                                  color: appColor),
                                        ),
                                        height10,
                                        Text(
                                          '${subController.planDetails['dutation']}',
                                          style: AppTextStyle.normalRegular14
                                              .copyWith(color: greyColor),
                                        ),
                                        if (accessControlsAdded.value) height20,
                                        if (accessControlsAdded.value == true)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 18,
                                                width: 18,
                                                decoration: const BoxDecoration(
                                                  color: appColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.add_rounded,
                                                  color: whiteColor,
                                                  size: 16,
                                                ),
                                              ),
                                              width15,
                                              Text(
                                                '${accesControll.length} Access Controls Added',
                                                style: AppTextStyle
                                                    .normalSemiBold12
                                                    .copyWith(
                                                  color: whiteColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        customHeight(20),
                                        if (accessControlsAdded.value == true)
                                          Column(
                                            children: [
                                              ...List.generate(
                                                accesControll.length,
                                                (index) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: Text(
                                                    '${accesControll[index]}',
                                                    style: AppTextStyle
                                                        .normalSemiBold12
                                                        .copyWith(
                                                      color: whiteColor,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        customHeight(30),
                                        Text(
                                          'All Parking Services',
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.normalRegular14
                                              .copyWith(
                                                  color: greyColor,
                                                  fontSize: 16),
                                        ),
                                        height05,
                                        Text(
                                          'Subscription Features will show here',
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.normalRegular14
                                              .copyWith(
                                                  color: greyColor,
                                                  fontSize: 16),
                                        ),
                                        height05,
                                        Text(
                                          'Features will show here',
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.normalRegular14
                                              .copyWith(
                                                  color: greyColor,
                                                  fontSize: 16),
                                        ),
                                        height05,
                                        Text(
                                          'All Parking Services',
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.normalRegular14
                                              .copyWith(
                                                  color: greyColor,
                                                  fontSize: 16),
                                        ),
                                        customHeight(30),
                                        GetBuilder<AccessController>(
                                          builder: (controller) {
                                            if (subController
                                                    .subscriptionApiResponse
                                                    .status ==
                                                Status.LOADING) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                            if (subController
                                                    .subscriptionApiResponse
                                                    .status ==
                                                Status.COMPLETE) {
                                              dynamic accessData = controller
                                                  .accessApiResponse.data;
                                              return Center(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showAddDialog(accessData);
                                                  },
                                                  child: Obx(
                                                    () => Container(
                                                      height: 50,
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            accessControlsAdded
                                                                    .value
                                                                ? null
                                                                : appColor,
                                                        border: Border.all(
                                                          color: accessControlsAdded
                                                                  .value
                                                              ? appColor
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Add Access Controls',
                                                          style: AppTextStyle
                                                              .normalSemiBold16
                                                              .copyWith(
                                                            color: whiteColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            return Center(
                                              child:
                                                  Text('Something went wrong'),
                                            );
                                          },
                                        ),
                                        height15,
                                      ],
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 340,
                                  //   height: 500,
                                  //   child:
                                  //   PageView.builder(
                                  //     itemCount:
                                  //         (subData['data'] as List).length,
                                  //     controller: controller,
                                  //     onPageChanged: (index) {
                                  //       selectedIndex.value = index;
                                  //       setState(() {});
                                  //     },
                                  //     itemBuilder:
                                  //         (BuildContext context, int index) {
                                  //       if (subData['data'][index]
                                  //               ['duration'] ==
                                  //           PreferenceManager.getDuration()) {
                                  //         return Container(
                                  //           margin:
                                  //               const EdgeInsets.only(top: 70),
                                  //           width: 340,
                                  //           height: 450,
                                  //           decoration: BoxDecoration(
                                  //             image: const DecorationImage(
                                  //                 image: AssetImage(AppAsset
                                  //                     .paymentbackground),
                                  //                 fit: BoxFit.cover),
                                  //             borderRadius:
                                  //                 BorderRadius.circular(15),
                                  //           ),
                                  //           padding: const EdgeInsets.symmetric(
                                  //               horizontal: 10, vertical: 10),
                                  //           child: Column(
                                  //             mainAxisSize: MainAxisSize.min,
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.center,
                                  //             children: [
                                  //               height20,
                                  //               Container(
                                  //                 padding: const EdgeInsets
                                  //                         .symmetric(
                                  //                     horizontal: 20,
                                  //                     vertical: 5),
                                  //                 decoration: BoxDecoration(
                                  //                     color: whiteColor
                                  //                         .withOpacity(0.14),
                                  //                     borderRadius:
                                  //                         BorderRadius.circular(
                                  //                             30)),
                                  //                 child: Text(
                                  //                   'Silver',
                                  //                   style: AppTextStyle
                                  //                       .normalRegular14
                                  //                       .copyWith(
                                  //                           color: greyColor),
                                  //                 ),
                                  //               ),
                                  //               height20,
                                  //               Text(
                                  //                 '${subData['data'][index]['prize']}/-',
                                  //                 style: AppTextStyle
                                  //                     .normalSemiBold20
                                  //                     .copyWith(
                                  //                         fontSize: 35,
                                  //                         color: appColor),
                                  //               ),
                                  //               height10,
                                  //               Text(
                                  //                 '${subData['data'][index]['duration']}',
                                  //                 style: AppTextStyle
                                  //                     .normalRegular14
                                  //                     .copyWith(
                                  //                         color: greyColor),
                                  //               ),
                                  //               if (accessControlsAdded.value)
                                  //                 height20,
                                  //               if (accessControlsAdded.value)
                                  //                 Row(
                                  //                   mainAxisAlignment:
                                  //                       MainAxisAlignment
                                  //                           .center,
                                  //                   children: [
                                  //                     Container(
                                  //                       height: 18,
                                  //                       width: 18,
                                  //                       decoration:
                                  //                           const BoxDecoration(
                                  //                         color: appColor,
                                  //                         shape:
                                  //                             BoxShape.circle,
                                  //                       ),
                                  //                       child: const Icon(
                                  //                         Icons.add_rounded,
                                  //                         color: whiteColor,
                                  //                         size: 16,
                                  //                       ),
                                  //                     ),
                                  //                     width15,
                                  //                     Text(
                                  //                       '2 Access Controls Added',
                                  //                       style: AppTextStyle
                                  //                           .normalSemiBold12
                                  //                           .copyWith(
                                  //                         color: whiteColor,
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               customHeight(30),
                                  //               Text(
                                  //                 'All Parking Services',
                                  //                 textAlign: TextAlign.center,
                                  //                 style: AppTextStyle
                                  //                     .normalRegular14
                                  //                     .copyWith(
                                  //                         color: greyColor,
                                  //                         fontSize: 16),
                                  //               ),
                                  //               height05,
                                  //               Text(
                                  //                 'Subscription Features will show here',
                                  //                 textAlign: TextAlign.center,
                                  //                 style: AppTextStyle
                                  //                     .normalRegular14
                                  //                     .copyWith(
                                  //                         color: greyColor,
                                  //                         fontSize: 16),
                                  //               ),
                                  //               height05,
                                  //               Text(
                                  //                 'Features will show here',
                                  //                 textAlign: TextAlign.center,
                                  //                 style: AppTextStyle
                                  //                     .normalRegular14
                                  //                     .copyWith(
                                  //                         color: greyColor,
                                  //                         fontSize: 16),
                                  //               ),
                                  //               height05,
                                  //               Text(
                                  //                 'All Parking Services',
                                  //                 textAlign: TextAlign.center,
                                  //                 style: AppTextStyle
                                  //                     .normalRegular14
                                  //                     .copyWith(
                                  //                         color: greyColor,
                                  //                         fontSize: 16),
                                  //               ),
                                  //               customHeight(50),
                                  //               GetBuilder<AccessController>(
                                  //                 builder: (controller) {
                                  //                   if (subController
                                  //                           .subscriptionApiResponse
                                  //                           .status ==
                                  //                       Status.LOADING) {
                                  //                     return Center(
                                  //                       child:
                                  //                           CircularProgressIndicator(),
                                  //                     );
                                  //                   }
                                  //                   if (subController
                                  //                           .subscriptionApiResponse
                                  //                           .status ==
                                  //                       Status.COMPLETE) {
                                  //                     dynamic accessData =
                                  //                         controller
                                  //                             .accessApiResponse
                                  //                             .data;
                                  //                     return Center(
                                  //                       child: GestureDetector(
                                  //                         onTap: () {
                                  //                           showAddDialog(
                                  //                               accessData);
                                  //                         },
                                  //                         child: Obx(
                                  //                           () => Container(
                                  //                             height: 50,
                                  //                             width: 200,
                                  //                             decoration:
                                  //                                 BoxDecoration(
                                  //                               color: accessControlsAdded
                                  //                                       .value
                                  //                                   ? null
                                  //                                   : appColor,
                                  //                               border:
                                  //                                   Border.all(
                                  //                                 color: accessControlsAdded
                                  //                                         .value
                                  //                                     ? appColor
                                  //                                     : Colors
                                  //                                         .transparent,
                                  //                               ),
                                  //                               borderRadius:
                                  //                                   BorderRadius
                                  //                                       .circular(
                                  //                                           30),
                                  //                             ),
                                  //                             child: Center(
                                  //                               child: Text(
                                  //                                 'Add Access Controls',
                                  //                                 style: AppTextStyle
                                  //                                     .normalSemiBold16
                                  //                                     .copyWith(
                                  //                                   color:
                                  //                                       whiteColor,
                                  //                                 ),
                                  //                               ),
                                  //                             ),
                                  //                           ),
                                  //                         ),
                                  //                       ),
                                  //                     );
                                  //                   }
                                  //                   return Center(
                                  //                     child: Text(
                                  //                         'Something went wrong'),
                                  //                   );
                                  //                 },
                                  //               ),
                                  //               height15,
                                  //             ],
                                  //           ),
                                  //         );
                                  //       }
                                  //       return SizedBox();
                                  //     },
                                  //   ),
                                  // ),
                                  Positioned(
                                    bottom: -20,
                                    child: Obx(
                                      () => Container(
                                        height: 50,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            color: accessControlsAdded.value
                                                ? appColor
                                                : whiteColor,
                                            border: Border.all(
                                              color: blackColor,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Center(
                                          child: Text(
                                            'Select',
                                            style: AppTextStyle.normalSemiBold16
                                                .copyWith(
                                              color: accessControlsAdded.value
                                                  ? whiteColor
                                                  : blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          customHeight(50),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: List.generate(
                          //     2,
                          //     (index) {
                          //       return Container(
                          //         height: 15,
                          //         width: 15,
                          //         margin:
                          //             const EdgeInsets.symmetric(horizontal: 5),
                          //         decoration: BoxDecoration(
                          //           border: Border.all(
                          //             color: selectedIndex.value != index
                          //                 ? appColor
                          //                 : whiteColor,
                          //           ),
                          //           shape: BoxShape.circle,
                          //           color: selectedIndex.value == index
                          //               ? appColor
                          //               : whiteColor,
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ),
                          customHeight(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: AppFillButton(
                              radius: 10,
                              onTap: () {
                                var x = 0;
                                log('DURATION ${widget.duration}');
                                log('DURATION ${widget.placeId}');
                                log('location ${widget.location}');
                                log('vehicleType ${widget.vehicleType}');
                                log('slotType ${widget.slotType}');
                                log('slotQuntity ${widget.slotQuntity}');
                                log('vehicleNumber ${widget.vehicleNumber}');
                                log('price ${subController.planDetails['price']}');
                                log('access Controller ${accesControll}');
                                log('SLOT LIST ${widget.slotList}');
                                if (accesControll.isNotEmpty) {
                                  for (int i = 0;
                                      i < accesControllPrice.length;
                                      i++) {
                                    x += int.parse(accesControllPrice[i]);
                                  }
                                  log('TOTAL PRICE :- $x');
                                  log('TOTAL PRICE :- $accesControllId');
                                  Get.to(() => OrderSummaryScreen(
                                        slotList: widget.slotList,
                                        subId: widget.subId,
                                        totalCount: int.parse(subController
                                                .planDetails['price']) +
                                            x,
                                        planPrice:
                                            subController.planDetails['price'],
                                        totalAccessPrice: x,
                                        accessPrice: accesControllPrice,
                                        placeId: widget.placeId,
                                        access: accesControll,
                                        accessController: accesControllId,
                                        slotQuntity: widget.slotQuntity,
                                        slotType: widget.slotType,
                                        vehicleNumber: widget.vehicleNumber,
                                        vehicleType: widget.vehicleType,
                                        location: widget.location,
                                        duration: widget.duration,
                                        price:
                                            subController.planDetails['price'],
                                      ));
                                } else {
                                  CommonSnackBar.commonSnackBar(
                                      message: 'Select access Controls');
                                }
                              },
                              title: "Check Out",
                            ),
                          ),
                          height20,
                        ],
                      ),
                    ),
                  ),
                ),
                appBar(),
              ],
            );
          }
          return Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }

  Widget appBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            height10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                Text(
                  'Choose Plan',
                  style: AppTextStyle.normalSemiBold8.copyWith(fontSize: 18),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void nextPage() {
    controller.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
    setState(() {});
  }

  void previousPage() {
    controller.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
    setState(() {});
  }

  void showAddDialog(accessData) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 16,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -20,
                right: 0,
                left: 0,
                child: Center(
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: appColor,
                      border: Border.all(color: whiteColor),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'Add Access Controls',
                        style: AppTextStyle.normalSemiBold16.copyWith(
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    tableColumn(accessData),
                    const Divider(
                      color: borderGreyColor,
                    ),
                    height10,
                    SizedBox(
                      height: 200,
                      child: tableDataListView(accessData),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AppBorderButton(
                            title: 'Back',
                            radius: 10,
                            height: 45,
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ),
                        width10,
                        Expanded(
                          child: AppFillButton(
                            title: 'Add',
                            height: 45,
                            radius: 10,
                            onTap: () {
                              accessControlsAdded.value = true;
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ).then((value) => setState(() {}));
  }

  Widget tableColumn(accessData) {
    return Row(
      children: [
        const SizedBox(
          width: 50,
        ),
        Expanded(
          child: Text(
            'Accessories',
            textAlign: TextAlign.center,
            style: AppTextStyle.normalSemiBold12.copyWith(color: greyColor),
          ),
        ),
        Expanded(
          child: Text(
            'Deposite',
            textAlign: TextAlign.center,
            style: AppTextStyle.normalSemiBold12.copyWith(color: greyColor),
          ),
        ),
        Expanded(
          child: Text(
            'Refunded Amount',
            textAlign: TextAlign.center,
            style: AppTextStyle.normalSemiBold12.copyWith(color: greyColor),
          ),
        ),
      ],
    );
  }

  Widget tableDataListView(accessData) {
    return ListView.builder(
      itemCount: (accessData['data'] as List).length,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            tableData(
              accessData,
              index,
            ),
            height10,
            const Divider(
              color: borderGreyColor,
            ),
            height10,
          ],
        );
      },
    );
  }

  Widget tableData(
    accessData,
    index,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(
                () => Checkbox(
                  value: commonCheckboxValue[index].value,
                  activeColor: appColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                  fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                    return appColor;
                  }),
                  onChanged: (bool value) {
                    commonCheckboxValue[index].value = value ?? false;
                    if (commonCheckboxValue[index].value == true) {
                      accesControll.add(
                          '"${accessData['data'][index]['control_name']}"');
                      accesControllPrice
                          .add(accessData['data'][index]['controls_prize']);
                      accesControllId
                          .add('"${accessData['data'][index]['controls_id']}"');
                    } else {
                      accesControll.remove(
                          '"${accessData['data'][index]['control_name']}"');
                      accesControllPrice
                          .remove(accessData['data'][index]['controls_prize']);
                      accesControllId.remove(
                          '"${accessData['data'][index]['controls_id']}"');
                    }
                    log('ACCES LIST :- $accesControll');
                    log('ACCES LIST ID :- $accesControllId');
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              SvgPicture.asset(
                AppAsset.cameraIcon,
              ),
              width05,
              Text(
                '${accessData['data'][index]['control_name']}',
                textAlign: TextAlign.center,
                style: AppTextStyle.normalSemiBold14,
              ),
            ],
          ),
        ),
        Expanded(
          child: Text(
            '${accessData['data'][index]['prize']}/-',
            textAlign: TextAlign.center,
            style: AppTextStyle.normalSemiBold14,
          ),
        ),
        Expanded(
          child: Text(
            '${accessData['data'][index]['controls_prize']}/-',
            textAlign: TextAlign.center,
            style: AppTextStyle.normalSemiBold14,
          ),
        ),
      ],
    );
  }
}
