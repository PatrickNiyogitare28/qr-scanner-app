import 'package:easy_debounce/easy_debounce.dart';
import 'package:get/get.dart';
import 'package:scan_app/app/common/modals/Event.dart';
import 'package:scan_app/app/common/modals/Ticket.dart';
import 'package:scan_app/app/common/utils/exports.dart';

class EventController extends GetxController {
  final Rx<Event?> selectedEvent = Rx<Event?>(null);
  final RxList<Ticket> associatedTickets = <Ticket>[].obs;
  final RxList<Ticket> filteredTickets = <Ticket>[].obs;

   final RxString searchQuery = ''.obs; // Add an observable for the search query

  // Search method for tickets
  void searchTickets(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      // If the query is empty, show all associated tickets
      filteredTickets.assignAll(associatedTickets);
    } else {
      // Filter associatedTickets based on the search query
      final filtered = associatedTickets
          .where((ticket) => ticket.fullName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      filteredTickets.assignAll(filtered);
    }
  }

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

   @override
      void onInit() {
      super.onInit();
      ever(searchQuery, (_) {
        EasyDebounce.debounce(
      'search_ticket_debounce',                 // <-- An ID for this particular debouncer
      Duration(milliseconds: 500),    // <-- The debounce duration
      () => searchTickets(searchQuery.value)               // <-- The target method
      );
      });
    }
}
