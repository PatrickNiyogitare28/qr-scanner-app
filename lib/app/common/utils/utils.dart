import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scan_app/app/common/utils/exports.dart';
import 'package:scan_app/app/modules/widgets/custom_inkwell_widget.dart';
import 'package:scan_app/app/modules/widgets/custom_text_button.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class Utils {

  static void showDialog(
    String? message, {
    String title = Strings.error,
    bool success = false,
    VoidCallback? onTap,
  }) =>
      Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: () async {
          Get.back();

          onTap?.call();

          return true;
        },
        title: success ? Strings.success : title,
        content: Text(
          message ?? Strings.somethingWentWrong,
          textAlign: TextAlign.center,
          maxLines: 6,
          style: AppTextStyle.semiBoldStyle.copyWith(
            color: AppColors.mineShaft,
            fontSize: Dimens.fontSize16,
          ),
        ),
        confirm: Align(
          alignment: Alignment.centerRight,
          child: CustomInkwellWidget.text(
            onTap: () {
              Get.back();

              onTap?.call();
            },
            title: Strings.ok,
            textStyle: AppTextStyle.buttonTextStyle.copyWith(
              fontSize: Dimens.fontSize18,
            ),
          ),
        ),
      );

  static void showIconDialog(
    String title,
    String message, {
    Widget? imageWidget,
    VoidCallback? onTap,
  }) =>
      Get.dialog(
        AlertDialog(
          title:
              imageWidget ?? const Icon(Icons.done), //add your icon/image here
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyle.semiBoldStyle.copyWith(
                  color: Colors.black,
                  fontSize: Dimens.fontSize24,
                ),
              ),
              SizedBox(height: 10.w),
              Text(message,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regularStyle.copyWith(
                    color: AppColors.mineShaft,
                    fontSize: Dimens.fontSize16,
                  )),
              SizedBox(height: 20.w),
              CustomTextButton(
                title: Strings.ok,
                onPressed: () {
                  Get.back();

                  onTap?.call();
                },
              ),
            ],
          ),
        ),
        barrierDismissible: false,
      );

  static void timePicker(
    Function(String time) onSelectTime, {
    TimeOfDay? initialTime,
  }) {
    showTimePicker(
      context: Get.overlayContext!,
      initialTime: initialTime ??
          TimeOfDay.fromDateTime(
            DateTime.now(),
          ),
    ).then((v) {
      if (v != null) {
        final _now = DateTime.now();
        final _dateTime = DateTime(
          _now.year,
          _now.month,
          _now.day,
          v.hour,
          v.minute,
        );

        onSelectTime(_dateTime.formatedDate(dateFormat: 'hh:mm aa'));
      }
    });
  }

  static String getRandomString(
    int length, {
    bool isNumber = true,
  }) {
    final _chars = isNumber ? '1234567890' : 'abcdefghijklmnopqrstuvwxyz';
    final _rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(
            _chars.length,
          ),
        ),
      ),
    );
  }

  static void loadingDialog() {
    closeDialog();

    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      name: 'loadingDialog',
    );
  }

  static void closeDialog() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  static void closeSnackbar() {
    if (Get.isSnackbarOpen == true) {
      Get.back();
    }
  }

  static void showSnackbar(String? message) {
    closeSnackbar();

    Get.rawSnackbar(message: message);
  }

  static void closeKeyboard() {
    final currentFocus = Get.focusScope!;
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static void goBackToScreen(String routeName) {
    Get.until(
      (route) => route.settings.name == routeName,
    );
  }

  static Future<void> showImagePicker({
    required Function(File image) onGetImage,
  }) {
    return showModalBottomSheet<void>(
      context: Get.context!,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    getImage(source: 2).then((v) {
                      if (v != null) {
                        onGetImage(v);
                        Get.back();
                      }
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image,
                        size: 60.w,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        Strings.gallery,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semiBoldStyle.copyWith(
                          color: AppColors.mineShaft,
                          fontSize: Dimens.fontSize16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    getImage().then((v) {
                      if (v != null) {
                        onGetImage(v);
                        Get.back();
                      }
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.camera,
                        size: 60.w,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        Strings.camera,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semiBoldStyle.copyWith(
                          color: AppColors.mineShaft,
                          fontSize: Dimens.fontSize16,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static Future<File?> getImage({int source = 1}) async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: source == 1 ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 60,
    );

    if (pickedFile != null) {
      final image = File(pickedFile.path);
    return image;
  }
}
}