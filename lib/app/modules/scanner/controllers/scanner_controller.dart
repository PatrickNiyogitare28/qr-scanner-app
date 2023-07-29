import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:get/get.dart';

class QRScannerController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController? controller;
  bool scanInProgress = true;
  bool isCameraRunning = false;

  @override
  void onClose() {
    // Dispose the QRViewController when the controller is closed
    controller?.dispose();
    super.onClose();
  }

  void pauseCamera() {
    if (controller != null) {
      controller!.pauseCamera();
      isCameraRunning = false;
      update(); // Notify GetX that the state has changed
    }
  }

  void resumeCamera() {
    if (controller != null) {
      controller!.resumeCamera();
      isCameraRunning = true;
      update(); // Notify GetX that the state has changed
    }
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // Handle the scanned QR code data here
      print(scanData.code);
    });
    isCameraRunning = true;
    update(); // Notify GetX that the state has changed
  }
}


