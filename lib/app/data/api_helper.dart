import 'package:get/get.dart';

export 'package:scan_app/app/common/utils/extensions.dart';
// export 'package:scan_app/app/common/utils/utilss.dart';

abstract class ApiHelper {
  static ApiHelper get to => Get.find();

  Future<Response> getPosts();
}
