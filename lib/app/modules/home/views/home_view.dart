import 'package:flutter/material.dart';
import 'package:scan_app/app/common/utils/exports.dart';
import 'package:scan_app/app/modules/home/controllers/home_controller.dart';
import 'package:scan_app/app/modules/widgets/custom_appbar_widget.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        addBackButton: false,
        title: 'Scan app',
      ),
      body:Center(
        child: Text("The Ticket Scan App."),
      )
    );
  }
}
