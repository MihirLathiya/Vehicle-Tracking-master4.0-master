import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vehicletracking/pages/payment/payment_screen.dart';
import 'package:vehicletracking/utils/app_assets.dart';
import 'package:vehicletracking/utils/app_colors.dart';
import 'package:vehicletracking/utils/app_static_decoration.dart';
import 'package:vehicletracking/utils/app_text_style.dart';
import 'package:vehicletracking/widgets/app_button.dart';

class OrderSummaryScreen extends StatefulWidget {
  final duration,
      location,
      vehicleType,
      slotType,
      slotQuntity,
      placeId,
      planPrice,
      subId;
  final totalCount;
  final totalAccessPrice;
  final slotList;
  final access;

  final vehicleNumber, accessController, accessPrice;
  final price;
  const OrderSummaryScreen(
      {Key key,
      this.duration,
      this.location,
      this.vehicleType,
      this.slotType,
      this.slotQuntity,
      this.placeId,
      this.vehicleNumber,
      this.accessController,
      this.price,
      this.accessPrice,
      this.planPrice,
      this.totalCount,
      this.totalAccessPrice,
      this.subId,
      this.slotList,
      this.access})
      : super(key: key);

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    log('DATA ${widget.access}');
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Order Summary',
          style: AppTextStyle.normalSemiBold16.copyWith(color: whiteColor),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            padding: const EdgeInsets.only(bottom: 70),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAsset.paymentbackground),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    membershipPlan(),
                    height10,
                    totalControls(),
                    height10,
                    priceDetails(),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70,
              color: blackColor.withOpacity(0.20),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Text(
                    '${widget.totalCount}/-',
                    style: AppTextStyle.bold16.copyWith(color: whiteColor),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 130,
                    height: 40,
                    child: AppFillButton(
                      radius: 10,
                      onTap: () {
                        log('DURATION ${widget.duration}');
                        log('location ${widget.location}');
                        log('vehicleType ${widget.vehicleType}');
                        log('slotType ${widget.slotType}');
                        log('slotQuntity ${widget.slotQuntity}');
                        log('vehicleNumber ${widget.vehicleNumber}');
                        log('price ${widget.price}');
                        log('access Controller ${widget.accessController}');
                        log(' slotList: selectedSlot, ${widget.slotList}');
                        Get.to(() => PaymentScreen(
                            slotList: widget.slotList,
                            subId: widget.subId,
                            total: widget.totalCount,
                            placeId: widget.placeId,
                            accessController: widget.accessController,
                            slotQuntity: widget.slotQuntity,
                            slotType: widget.slotType,
                            vehicleNumber: widget.vehicleNumber,
                            vehicleType: widget.vehicleType,
                            location: widget.location,
                            duration: widget.duration,
                            price: widget.price));
                      },
                      title: 'Continue',
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget membershipPlan() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: containerGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            'Gold Membership',
            style: AppTextStyle.normalRegular14.copyWith(color: whiteColor),
          ),
          const Spacer(),
          Text(
            '${widget.planPrice}/-',
            style: AppTextStyle.bold16.copyWith(color: whiteColor),
          ),
        ],
      ),
    );
  }

  Widget totalControls() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: containerGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${(widget.accessController as List).length} Access Controls',
                style: AppTextStyle.normalRegular14.copyWith(color: whiteColor),
              ),
              const Spacer(),
              Text(
                '${widget.totalAccessPrice}/-',
                style: AppTextStyle.bold16.copyWith(color: whiteColor),
              ),
            ],
          ),
          height10,
          Column(
            children: List.generate(
              (widget.accessController as List).length,
              (index) => Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAsset.cameraIcon,
                      color: whiteColor,
                      height: 16,
                    ),
                    width15,
                    Text(
                      '${widget.access[index]}',
                      style: AppTextStyle.normalRegular14
                          .copyWith(color: whiteColor),
                    ),
                    const Spacer(),
                    Text(
                      '${widget.accessPrice[index]}/-',
                      style: AppTextStyle.normalSemiBold12
                          .copyWith(color: whiteColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget priceDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: containerGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Details (2 items)',
            style: AppTextStyle.bold14.copyWith(color: whiteColor),
          ),
          height20,
          Row(
            children: [
              Text(
                'Gold Membership',
                style: AppTextStyle.normalRegular14.copyWith(color: whiteColor),
              ),
              const Spacer(),
              Text(
                '${widget.planPrice}/-',
                style:
                    AppTextStyle.normalSemiBold12.copyWith(color: whiteColor),
              ),
            ],
          ),
          Column(
            children: List.generate(
              (widget.accessController as List).length,
              (index) => Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAsset.cameraIcon,
                      color: whiteColor,
                      height: 16,
                    ),
                    width15,
                    Text(
                      '${widget.access[index]}',
                      style: AppTextStyle.normalRegular14
                          .copyWith(color: whiteColor),
                    ),
                    const Spacer(),
                    Text(
                      '${widget.accessPrice[index]}/-',
                      style: AppTextStyle.normalSemiBold12
                          .copyWith(color: whiteColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
