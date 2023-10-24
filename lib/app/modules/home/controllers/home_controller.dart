import 'package:easy_debounce/easy_debounce.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart'; // Import for internet connectivity
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scan_app/app/common/modals/Event.dart';
import 'package:scan_app/app/common/modals/Ticket.dart';
import 'package:scan_app/app/common/utils/exports.dart'; // Import for Firestore

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Connectivity _connectivity = Connectivity();

  RxList<Event> events = RxList<Event>();
  RxList<Event> filteredEvents = RxList<Event>();
  RxList<Ticket> tickets = RxList<Ticket>();
  RxBool isLoading = true.obs; 
  RxString searchQuery = ''.obs;
  final RxList<Ticket> associatedTickets = <Ticket>[].obs;


  @override
  void onReady() {
    super.onReady();
    fetchDataAndStore();
  }

    @override
    void onInit() {
    super.onInit();
    ever(searchQuery, (_) {
      EasyDebounce.debounce(
    'search_event_debounce',                 // <-- An ID for this particular debouncer
    Duration(milliseconds: 500),    // <-- The debounce duration
    () => searchEvents(searchQuery.value)               // <-- The target method
    );
    });
  }

  void searchEvents(String query) {
    if (query.isEmpty) {
      // Reset the events to the full list when the query is empty
      filteredEvents.assignAll(events);
    } else {
      // Filter events based on the search query
      final filtered = events.where((event) {
        return event.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      filteredEvents.assignAll(filtered);
    }
  }

  Future<bool> isInternetConnected() async {
    var result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

Future<void> fetchEventsAndTickets() async {
  if (await isInternetConnected()) {
      // Set isLoading to true when fetching starts
      isLoading.value = true;

      try {
        // Fetch events
        QuerySnapshot eventSnapshot = await _firestore.collection('events').get();
        events.assignAll(eventSnapshot.docs.map((doc) => Event.fromMap(doc.data() as Map<String, dynamic>)).toList());
        filteredEvents.assignAll(events);

        QuerySnapshot ticketsSnapshot = await _firestore.collection('tickets').get();
        tickets.assignAll(ticketsSnapshot.docs.map((doc) => Ticket.fromMap(doc.data() as Map<String, dynamic>)).toList());

        // Store the data in storage
        storeEvents(events);
        storeTickets(tickets);
      } finally {
        // Set isLoading to false when fetching is complete (success or failure)
        isLoading.value = false;
      }
    }
}
  void storeEvents(List<Event> events) {
  final eventsJson = events.map((event) => event.toJson()).toList();
  Storage.saveValue("events", eventsJson);
}

  void storeTickets(List<Ticket> tickets) {
  final ticketsJson = tickets.map((ticket) => ticket.toJson()).toList();
  Storage.saveValue("tickets", ticketsJson);
}

  void fetchDataAndStore() async {
    await fetchEventsAndTickets();
  }

  void getTicketsByEventId(int eventId) {
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

  associatedTickets.assignAll(filteredTickets);
}
}
