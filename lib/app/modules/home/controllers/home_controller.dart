import 'package:scan_app/app/common/modals/Event.dart';
import 'package:scan_app/app/common/modals/Ticket.dart';
import 'package:scan_app/app/common/storage/storage.dart';
import 'package:scan_app/app/data/api_helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

   final List<Event> events = [
      Event(
        title: 'General Admission (Early Bird)',
        tickets: [
          Ticket(
              ticketId: 'ABC123D',
              amountPaid: '5,000 RWF',
              numberOfTickets: 1,
              fullName: 'Peter Eric',
              scannedDate: 'July 5th, 2023',
              scannedTime: '11:30 AM'),
          Ticket(
              ticketId: 'XYZ456E',
              amountPaid: '7,500 RWF',
              numberOfTickets: 2,
              fullName: 'Alice Johnson',
              scannedDate: 'July 6th, 2023',
              scannedTime: '2:15 PM'),
          Ticket(
              ticketId: 'LMN789F',
              amountPaid: '3,000 RWF',
              numberOfTickets: 1,
              fullName: 'John Smith',
              scannedDate: 'July 7th, 2023',
              scannedTime: '4:45 PM'),
        ],
      ),
      Event(title: 'Women in Tech 2023', tickets: [
        Ticket(
            ticketId: 'PQR012G',
            amountPaid: '10,000 RWF',
            numberOfTickets: 3,
            fullName: 'Emily Adams',
            scannedDate: 'July 8th, 2023',
            scannedTime: '10:00 AM'),
        Ticket(
            ticketId: 'JKL345H',
            amountPaid: '6,500 RWF',
            numberOfTickets: 2,
            fullName: 'Michael Brown',
            scannedDate: 'July 9th, 2023',
            scannedTime: '1:30 PM'),
        Ticket(
            ticketId: 'EFG678I',
            amountPaid: '4,500 RWF',
            numberOfTickets: 1,
            fullName: 'Sophia Williams',
            scannedDate: 'July 10th, 2023',
            scannedTime: '3:20 PM'),
      ]),
      Event(title: 'Extended Google IO 23', tickets: [
        Ticket(
            ticketId: 'MNO901J',
            amountPaid: '8,000 RWF',
            numberOfTickets: 2,
            fullName: 'James Wilson',
            scannedDate: 'July 11th, 2023',
            scannedTime: '9:45 AM'),
      ])
      // Add more dummy events here as needed
    ];

  final RxList _dataList = RxList();
  List<dynamic> get dataList => _dataList;
  set dataList(List<dynamic> dataList) => _dataList.addAll(dataList);

  @override
  void onReady() {
    super.onReady();

    getTickets();
  }

  void getTickets() {
    // _apiHelper.getPosts().futureValue(
    //       (value) => dataList = value,
    //       retryFunction: getPosts,
    //     );
    Storage.saveValue("events", this.events);
  }

  void onEditProfileClick() {
    Get.back();
  }

  void onFaqsClick() {
    Get.back();
  }

  void onLogoutClick() {
    Storage.clearStorage();
    // Get.offAllNamed(Routes.HOME);
    //Specify the INITIAL SCREEN you want to display to the user after logout
  }
}
