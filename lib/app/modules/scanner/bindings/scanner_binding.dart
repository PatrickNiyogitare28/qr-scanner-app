import 'package:get/get.dart';
import 'package:scan_app/app/modules/scanner/controllers/scanner_controller.dart';

class QRScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QRScannerController>(
      () => QRScannerController(),
    );
  }
}
