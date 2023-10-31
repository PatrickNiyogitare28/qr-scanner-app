import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:get/get.dart';
import 'package:scan_app/app/common/modals/Ticket.dart';
import 'package:scan_app/app/common/utils/exports.dart'; // Import your utility functions

class QRScannerController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController? controller;
  bool scanInProgress = true;
  bool isCameraRunning = false;
  // List<Ticket> tickets = [];

  @override
  void onInit() {
    super.onInit();
    // tickets = getTicketsByEventId(0); // Replace 0 with the actual event ID you want to check
  }

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
    checkTicketValidity(scanData.code!);
  });
  isCameraRunning = true;
  update(); // Notify GetX that the state has changed
}


  void checkTicketValidity(String scannedCode) {
  final List<dynamic> dynamicTickets = Storage.getValue("tickets") ?? <Ticket>[];
  final List<Ticket> tickets = dynamicTickets
      .map((dynamic ticketData) {
        return Ticket.fromJson(ticketData);
      })
      .where((ticket) => ticket != null)
      .cast<Ticket>()
      .toList();

  Ticket matchedTicket = tickets.firstWhere(
    (ticket) => ticket.id == scannedCode,
    orElse: () => Ticket(
      clientId: -1,
      companyName: "",
      createdAt: DateTime(2000),
      email: "",
      eventId: -1,
      firebaseSynced: false,
      fullName: "",
      id: "",
      isEmailSent: false,
      isSmsSent: false,
      phoneNumber: "",
      status: "",
      ticketId: -1,
      title: "",
      transactionId: -1,
      updatedAt: DateTime(2000),
      userId: -1,
      validity: false,
    ), // Replace with your default ticket
  );

  if (matchedTicket.id != -1 && matchedTicket.validity == true) {
    // Valid ticket
    Fluttertoast.showToast(
      msg: "Success! Ticket is valid",
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      webPosition: 'center',
    );
    // Update the matchedTicket's validity
    matchedTicket.validity = false;

    // Update the list of tickets with the modified matchedTicket
    final updatedTickets = tickets.map((ticket) {
      if (ticket.id == matchedTicket.id) {
        return matchedTicket;
      }
      return ticket;
    }).toList();
 
    Storage.saveValue("tickets", updatedTickets);
  } else {
    // Invalid ticket
    Fluttertoast.showToast(
      msg: "Failed! Ticket expired or used",
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      webPosition: 'center',
    );
  }
}
   
}
