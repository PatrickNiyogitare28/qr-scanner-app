import 'package:scan_app/app/modules/event/bindings/event_binding.dart';
import 'package:scan_app/app/modules/home/bindings/home_binding.dart';
import 'package:scan_app/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';

import 'package:scan_app/app/modules/event/views/event_view.dart';

part 'app_routes.dart';

abstract class AppPages {
  const AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
     GetPage(
      name: _Paths.EVENT,
      page: () => const EventView(),
      binding: EventBinding(),
    ),
  ];
}
