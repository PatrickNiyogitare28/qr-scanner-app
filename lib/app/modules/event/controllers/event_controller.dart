import 'package:get/get.dart';
import 'package:scan_app/app/common/modals/Event.dart';
import 'package:scan_app/app/common/modals/Ticket.dart';
import 'package:scan_app/app/common/utils/exports.dart';

class EventController extends GetxController {
  final Rx<Event?> selectedEvent = Rx<Event?>(null);
  final RxList<Ticket> associatedTickets = <Ticket>[].obs;

  void loadEventAndTickets() {
   final dynamic arguments = Get.arguments;
   final dynamic eventMap = arguments['event'];

    final Event? event = Get.arguments['event'];
    selectedEvent.value = event;
   
    final List<Ticket> tickets = getTicketsByEventId(event!.id);
    associatedTickets.assignAll(tickets);
  }


List<Ticket> getTicketsByEventId(int eventId) {
  final List<dynamic> dynamicTickets = Storage.getValue("tickets") ?? <Ticket>[];
  final List<Ticket> tickets = dynamicTickets
    .map((dynamic ticketData) {
        return Ticket.fromJson(ticketData);
    })
    .where((ticket) => ticket != null) // Filter out null entries
    .cast<Ticket>() // Cast to List<Ticket>
    .toList();

  List<Ticket> filteredTickets = tickets
      .where((ticket) => ticket.eventId == eventId)
      .cast<Ticket>()
      .toList();

  return filteredTickets;
}



//   List<Ticket>? getTicketsByEventId(int eventId) {
//   final List allTickets = (Storage.getValue("tickets") as List<dynamic>)
//       .map((dynamic ticketData) => Ticket.fromMap(ticketData))
//       .toList();
  
//   return allTickets.where((ticket) => ticket.eventId == eventId).toList();
// }

  
  @override
  void onReady() {
    super.onReady();
    loadEventAndTickets();
  }
}
