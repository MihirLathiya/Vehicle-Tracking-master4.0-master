import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/response_model/login_res_model.dart';
import 'package:vehicletracking/pages/auth/forgot_password_screen.dart';
import 'package:vehicletracking/pages/auth/sign_up.dart';
import 'package:vehicletracking/pages/subscribed/slot_details_screen.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';
import 'package:vehicletracking/utils/app_colors.dart';
import 'package:vehicletracking/utils/app_static_decoration.dart';
import 'package:vehicletracking/utils/validators.dart';
import 'package:vehicletracking/view_model/log_in_view_model.dart';
import 'package:vehicletracking/widgets/app_button.dart';
import 'package:vehicletracking/widgets/app_comman_widget.dart';

import '../../utils/app_assets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  LogInViewViewModel logInViewViewModel = Get.put(LogInViewViewModel());
  TextEditingController accountNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppAsset.bgGroundTop,
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                AppAsset.loginImage,
              ),
              customHeight(20),
              const Text(
                "LogIn",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              customHeight(6),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Welcome Back, We are Glad to See You Again!",
                  style: TextStyle(fontSize: 11),
                  textAlign: TextAlign.center,
                ),
              ),
              customHeight(47),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: accountNumber,
                  decoration: InputDecoration(
                    labelText: 'Account Number*',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: borderGreyColor),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: appColor),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              customHeight(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: password,
                  obscureText: visible,
                  decoration: InputDecoration(
                    hintText: "Enter Your Password Here..",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          visible = !visible;
                        });
                      },
                      child: Icon(
                        visible == true
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: borderGreyColor),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: appColor),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              customHeight(13),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const ForgotPasswordScreen());
                    },
                    child: const Text("Forgot Password?"),
                  ),
                ),
              ),
              height25,
              GetBuilder<LogInViewViewModel>(
                builder: (controller) {
                  return controller.isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: AppFillButton(
                            onTap: () async {
                              await logInViewViewModel.logInViewViewModel(
                                  model: {
                                    'account_number': accountNumber.text.trim(),
                                    'password': password.text.trim()
                                  });
                              if (logInViewViewModel.logInApiResponse.status ==
                                  Status.COMPLETE) {
                                var uniqueId = DateTime.now().second.toString();

                                LogInResponseModel register =
                                    logInViewViewModel.logInApiResponse.data;
                                CommonSnackBar.commonSnackBar(
                                    message: '${register.message}');
                                PreferenceManager.setAccountNo(
                                    register.userDetail.accountNumber);
                                PreferenceManager.setCompanyAddress(
                                    '${register.userDetail.companyAddress}');
                                PreferenceManager.setCompanyName(
                                    '${register.userDetail.companyName}');
                                PreferenceManager.setEmail(
                                    '${register.userDetail.email}');
                                PreferenceManager.setName(
                                    '${register.userDetail.firstName}');
                                PreferenceManager.setWhatsApp(
                                    '${register.userDetail.whatappNumber}');
                                PreferenceManager.setNumber(
                                    '${register.userDetail.mobileNumber}');
                                PreferenceManager.setLogin(true);
                                PreferenceManager.setBariear(
                                    '${register.accessToken}');
                                // await Workmanager().registerOneOffTask(
                                //   uniqueId,
                                //   task,
                                //   initialDelay: Duration(seconds: 5),
                                //   backoffPolicyDelay: Duration(seconds: 5),
                                // );
                                Get.offAll(() => const SlotDetailsScreen(
                                      isSubscribed: true,
                                    ));
                                controller.updateLoading(false);
                              } else if (logInViewViewModel
                                      .logInApiResponse.status ==
                                  Status.ERROR) {
                                CommonSnackBar.commonSnackBar(
                                    message: 'Something went wrong');
                                controller.updateLoading(false);
                              }
                            },
                            title: "Log In",
                          ),
                        );
                },
              ),
              height20,
              appRichText(
                "Don’t have an account?  ",
                "SignUp",
                onTap: () async {
                  Get.to(() => const SignUpScreen());
                },
              ),
              height20,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppAsset.bottomLine,
            // height: 70.0,
            width: double.infinity,
          ),
          customHeight(35.0),
        ],
      ),
    );
  }
}
