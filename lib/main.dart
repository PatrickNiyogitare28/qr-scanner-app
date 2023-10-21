import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:scan_app/app/common/utils/initializer.dart';
import 'package:scan_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/scanner/controllers/scanner_controller.dart';
import 'app/modules/widgets/base_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  
//   Initializer.init(() {
//     Get.put(QRScannerController());
//     runApp(const MyApp());
//   });
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Initialize the GetX controller here before runApp
  Get.put(QRScannerController());

  // Fetch data and store it before running the app
  final homeController = Get.put(HomeController());
  homeController.fetchDataAndStore();


  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, child) => GetMaterialApp(
        title: Strings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        initialBinding: InitialBindings(),
        builder: (_, child) => BaseWidget(
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
