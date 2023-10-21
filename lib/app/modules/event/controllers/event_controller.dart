import 'package:get/get.dart';
import 'package:scan_app/app/common/modals/Event.dart';
import 'package:scan_app/app/common/modals/Ticket.dart';
import 'package:scan_app/app/common/utils/exports.dart';

class EventController extends GetxController {
  final Rx<Event?> selectedEvent = Rx<Event?>(null);
  final RxList<Ticket> associatedTickets = <Ticket>[].obs;

  void loadEventAndTickets() {
    final dynamic arguments = Get.arguments;
  print("Arguments: $arguments"); // Check if you are receiving the arguments

  final dynamic eventMap = arguments['event'];
  print("Event Map: $eventMap"); // Check if you are extracting the event data


    // Fetch the selected event based on eventId (you need to implement this)
    // For demonstration, let's assume a function getEventById(eventId)
    final Event? event = Get.arguments['event'];
    selectedEvent.value = event;

    print("passed event ...");
    print(event!.id);
    print(event!.name);

    // Fetch the associated tickets based on the event's ID (you need to implement this)
    // For demonstration, let's assume a function getTicketsByEventId(eventId)
    final List<Ticket> tickets = getTicketsByEventId(event!.id);
    associatedTickets.assignAll(tickets);
     print("tickets associated");
     print(tickets);
  }

  List<Ticket> getTicketsByEventId(int eventId) {
    final List<Ticket> allTickets = Storage.getValue("tickets") ?? <Ticket>[];

    // Filter and return the tickets associated with the specified event ID
   
    return allTickets.where((ticket) => ticket.eventId == eventId).toList();
  }

  
  @override
  void onReady() {
    super.onReady();
    loadEventAndTickets();
  }
}
