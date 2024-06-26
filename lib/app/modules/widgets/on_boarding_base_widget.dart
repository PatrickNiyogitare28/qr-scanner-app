import 'package:flutter/material.dart';
import 'package:scan_app/app/data/interface_controller/api_interface_controller.dart';
import 'package:scan_app/app/modules/widgets/custom_retry_widget.dart';
import 'package:get/get.dart';

export 'package:scan_app/app/common/utils/exports.dart';

class OnBoardingBaseWidget extends GetView<ApiInterfaceController> {
  ///A widget with custom background and custom retry button widget.
  ///You've to add "backgroundColor: Colors.transparent" in Scaffold
  ///in order to see backgroundImage properly.

  final Widget child;
  final Color? backgroundColor;
  final bool addBackgroundImage;
  final Alignment alignment;

  const OnBoardingBaseWidget({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.addBackgroundImage = false,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.error != null
          ? SafeArea(
              child: CustomRetryWidget(
                onPressed: () {
                  controller.error = null;
                  if (controller.retry != null) {
                    controller.retry!();
                  }
                },
              ),
            )
          : Container(
              height: Get.height,
              alignment: alignment,
              decoration: BoxDecoration(
                color: (!addBackgroundImage && backgroundColor == null)
                    ? Colors.white
                    : backgroundColor,
                // image: !addBackgroundImage
                //     ? null
                //     : DecorationImage(
                //         fit: BoxFit.cover,
                //         image: AssetImage(AppImages.backgroundImage),
                //       ),
                //
                //add background here
              ),
              child: SafeArea(
                child: child,
              ),
            ),
    );
  }
}
