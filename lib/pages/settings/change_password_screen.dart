import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/response_model/create_password_res_model.dart';
import 'package:vehicletracking/pages/auth/sign_in.dart';
import 'package:vehicletracking/pages/settings/edit_profile_screen.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';
import 'package:vehicletracking/utils/app_assets.dart';
import 'package:vehicletracking/utils/app_colors.dart';
import 'package:vehicletracking/utils/app_static_decoration.dart';
import 'package:vehicletracking/utils/app_text_style.dart';
import 'package:vehicletracking/utils/validators.dart';
import 'package:vehicletracking/view_model/create_password_view_model.dart';
import 'package:vehicletracking/widgets/app_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  bool cPass = true;
  bool c1Pass = true;
  CreatePasswordViewModel createPasswordViewModel =
      Get.put(CreatePasswordViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            color: blackColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Image.asset(
              AppAsset.changePassword,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 340),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey1,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Get.to(() => const EditProfileScreen());
                              },
                              child: Text(
                                'Change Password',
                                style: AppTextStyle.normalSemiBold8
                                    .copyWith(fontSize: 20),
                              ),
                            ),
                          ),
                          height10,
                          Text(
                            'Your new password must be different from previously used passwords.',
                            style: AppTextStyle.normalRegular14
                                .copyWith(color: greyColor),
                          ),
                          height25,
                          TextField(
                            controller: newPasswordController,
                            obscureText: cPass,
                            decoration: InputDecoration(
                              labelText: 'Create New Password',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: greyColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: appColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    cPass = !cPass;
                                  });
                                },
                                icon: Icon(
                                  cPass
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: blackColor,
                                ),
                              ),
                            ),
                          ),
                          height25,
                          TextField(
                            controller: confirmPasswordController,
                            obscureText: c1Pass,
                            decoration: InputDecoration(
                              labelText: 'Confirm New Password',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: greyColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: appColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    c1Pass = !c1Pass;
                                  });
                                },
                                icon: Icon(
                                  c1Pass
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: blackColor,
                                ),
                              ),
                            ),
                          ),
                          height25,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppFillButton(
              title: 'Reset password',
              onTap: () async {
                if (_formKey1.currentState.validate()) {
                  await createPasswordViewModel.createPasswordViewModel(model: {
                    'account_number': '${PreferenceManager.getAccountNo()}',
                    'password': newPasswordController.text.trim(),
                    'password_confirmation':
                        confirmPasswordController.text.trim()
                  });

                  if (createPasswordViewModel
                          .createPasswordApiResponse.status ==
                      Status.COMPLETE) {
                    CreatePasswordResponseModel createPassword =
                        createPasswordViewModel.createPasswordApiResponse.data;
                    CommonSnackBar.commonSnackBar(
                        message: createPassword.message);
                    Get.offAll(() => const SignInScreen());
                    // controller.updateLoading(false);
                  } else if (createPasswordViewModel
                          .createPasswordApiResponse.status ==
                      Status.ERROR) {
                    CommonSnackBar.commonSnackBar(
                        message: 'Something went wrong');
                    // controller.updateLoading(false);
                  }
                }
              },
              radius: 10,
            ),
          ],
        ),
      ),
    );
  }
}
