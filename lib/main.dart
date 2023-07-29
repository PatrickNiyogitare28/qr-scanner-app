import 'package:flutter/material.dart';
import 'package:scan_app/app/common/utils/initializer.dart';
import 'package:scan_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

import 'app/modules/scanner/controllers/scanner_controller.dart';
import 'app/modules/widgets/base_widget.dart';

void main() {
  Initializer.init(() {
    Get.put(QRScannerController());
    runApp(const MyApp());
  });
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
