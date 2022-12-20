import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/pages/auth/sign_in.dart';
import 'package:vehicletracking/utils/app_colors.dart';
import 'package:vehicletracking/utils/app_static_decoration.dart';
import 'package:vehicletracking/utils/app_text_style.dart';
import 'package:vehicletracking/utils/validators.dart';
import 'package:vehicletracking/view_model/forgot_password_view_model.dart';
import 'package:vehicletracking/widgets/app_button.dart';
import 'package:vehicletracking/widgets/app_comman_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  ForgotPasswordViewViewModel forgotPasswordViewViewModel =
      Get.put(ForgotPasswordViewViewModel());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 898;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 500 * height,
              width: Get.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/png/fg.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/png/Nomatchfound.png',
                    height: 198 * height,
                    width: 271,
                  ),
                  SizedBox(
                    height: 15 * height,
                  ),
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: 'inter',
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    'Do not worry! We will help you recover ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff8B8A8A),
                      fontFamily: 'inter',
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'your password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff8B8A8A),
                          fontFamily: 'inter',
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/image/png/Key.png',
                        height: 13,
                        width: 13,
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50 * height,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Reset Via Email',
                    style: AppTextStyle.bold20,
                  ),
                  height10,
                  Text(
                    'Enter the email associated with your account and we will send you a link to rest your password.',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.normalRegular14.copyWith(
                      color: greyColor,
                    ),
                  ),
                  height25,
                  TextFormField(
                    controller: emailController,
                    style: AppTextStyle.normalRegular16.copyWith(
                      color: blackColor,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter Your Email ID",
                      hintStyle: AppTextStyle.normalRegular16.copyWith(
                        color: greyColor,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 10),
                        child: Icon(
                          Icons.mail_outline_rounded,
                          color: borderGreyColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: borderGreyColor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20 * height,
                  ),
                  GetBuilder<ForgotPasswordViewViewModel>(
                    builder: (controller) {
                      return controller.isLoading == true
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : AppFillButton(
                              title: 'Confirm',
                              onTap: () async {
                                if (emailController.text.isNotEmpty) {
                                  await forgotPasswordViewViewModel
                                      .forgotPasswordViewViewModel(model: {
                                    'email': '${emailController.text.trim()}'
                                  });

                                  if (forgotPasswordViewViewModel
                                          .forgotPasswordApiResponse.status ==
                                      Status.COMPLETE) {
                                    CommonSnackBar.commonSnackBar(
                                        message:
                                            'reset password link sent to your email');
                                    Get.offAll(() => SignInScreen());
                                  } else if (forgotPasswordViewViewModel
                                          .forgotPasswordApiResponse.status ==
                                      Status.ERROR) {
                                    controller.updateLoading(false);
                                    CommonSnackBar.commonSnackBar(
                                        message: 'Something went wrong');
                                  }
                                } else {
                                  CommonSnackBar.commonSnackBar(
                                      message: 'Enter Email');
                                }
                              },
                            );
                    },
                  ),
                  SizedBox(
                    height: 20 * height,
                  ),
                  appRichText(
                    "Didn’t Receive the Link? ",
                    "Resend",
                    decoration: TextDecoration.underline,
                    onTap: () async {
                      if (emailController.text.isNotEmpty) {
                        await forgotPasswordViewViewModel
                            .forgotPasswordViewViewModel(model: {
                          'email': '${emailController.text.trim()}'
                        });

                        if (forgotPasswordViewViewModel
                                .forgotPasswordApiResponse.status ==
                            Status.COMPLETE) {
                          CommonSnackBar.commonSnackBar(
                              message:
                                  'reset password link sent to your email');
                          Get.offAll(() => SignInScreen());
                        } else if (forgotPasswordViewViewModel
                                .forgotPasswordApiResponse.status ==
                            Status.ERROR) {
                          forgotPasswordViewViewModel.updateLoading(false);
                          CommonSnackBar.commonSnackBar(
                              message: 'Something went wrong');
                        }
                      } else {
                        CommonSnackBar.commonSnackBar(message: 'Enter Email');
                      }
                    },
                  ),
                  height25,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
