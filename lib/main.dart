import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vehicletracking/splash_screen.dart';
import 'package:vehicletracking/utils/app_assets.dart';
import 'package:vehicletracking/utils/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  await GetStorage.init();
  runApp(const VehicleTrackApp());
}

class VehicleTrackApp extends StatefulWidget {
  const VehicleTrackApp({Key key}) : super(key: key);

  @override
  State<VehicleTrackApp> createState() => _VehicleTrackAppState();
}

class _VehicleTrackAppState extends State<VehicleTrackApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: appMaterialColor,
        fontFamily: AppAsset.fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      // getPages: getPages,
      // unknownRoute: GetPage(name: "/not-found", page: () => FourOFourScreen()),
      // initialRoute: Routes.FAQ,
      home: const SplashScreen(),
    );
  }
}

// const task = 'hi';
//
// callbackDispatcher() async {
//   Workmanager().executeTask((taskName, inputData) async {
//     switch (taskName) {
//       case 'hi':
//         await logOutData();
//
//         break;
//       default:
//     }
//     return Future.value(true);
//   });
// }

// logOutRepo() async {
//   var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
//   var request = await http.get(
//       Uri.parse('https://i.invoiceapi.ml/api/customer/logout'),
//       headers: headers);
//
//   if (request.statusCode == 200) {
//     print('HELLO ${await request.body}');
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (context) {
//           return SignInScreen();
//         },
//       ),
//     );
//   } else {
//     print('ERROR ${request.reasonPhrase}');
//   }
// }
//
// logOutData() async {
//   log('HELLO 00');
//   Get.offAll(() => SignInScreen());
// }
