import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicletracking/pages/auth/sign_in.dart';
import 'package:vehicletracking/pages/subscribed/slot_details_screen.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';
import 'package:vehicletracking/utils/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AppAsset.bgGround,
                ),
                fit: BoxFit.fill)),
        child: Stack(
          // alignment: Alignment.center,
          fit: StackFit.passthrough,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 55.0,
              ),
              child: Image.asset(
                AppAsset.logo,
                height: 70.0,
                width: 274.0,
              ),
            ),
            Positioned(
                bottom: 25.0,
                left: 0.0,
                right: 0.0,
                child: Column(
                  children: [
                    Image.asset(
                      AppAsset.bottomLine,
                      // height: 70.0,
                      width: double.infinity,
                    ),
                    const Text(
                      "Copyright(C) 2022 Smart Business Car Park, All rights reserved.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(
        () => PreferenceManager.getLogin() == true
            ? SlotDetailsScreen(
                isSubscribed: true,
              )
            : SignInScreen(),
      );
    });
  }
}
