import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:get/get_core/get_core.dart";
import "package:qr_code_scanner/qr_code_scanner.dart";
import "package:get/get.dart";
import "package:scan_app/app/common/utils/exports.dart";
import "package:scan_app/app/routes/app_pages.dart";

class ScanQrPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  Barcode? result;
  QRViewController? controller;
  // GetxController homeController = HomeController as GetxController;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final List<dynamic> events = Storage.getValue("events");

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          if (result!.code == "ABCD1234") {
            Fluttertoast.showToast(
                msg: "Success! Ticket is valid",
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                webPosition: 'center');
            Get.toNamed(Routes.EVENT, arguments: {'event': events[0]});
          } else {
            Fluttertoast.showToast(
                msg: "Failed! Ticket expired or used ",
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                webPosition: 'center');
            //  Get.toNamed(Routes.EVENT, arguments: {
            //    'event': events[0]
            //  });// Close the bottom sheet
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.orange,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 250,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
