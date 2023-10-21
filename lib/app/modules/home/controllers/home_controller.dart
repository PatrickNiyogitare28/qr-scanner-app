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
  RxList<Ticket> tickets = RxList<Ticket>();
  RxBool isLoading = true.obs; 
  

  @override
  void onReady() {
    super.onReady();
    fetchDataAndStore();
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

        // Store the data in storage
        storeEvents(events);
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
}
