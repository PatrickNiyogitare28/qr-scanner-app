import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scan_app/app/modules/home/controllers/home_controller.dart';
import 'package:scan_app/app/modules/scanner/views/scanner_view.dart';
import 'package:scan_app/app/modules/widgets/custom_appbar_widget.dart';
import 'package:get/get.dart';
import 'package:scan_app/app/modules/widgets/search_input.dart';
import 'package:scan_app/app/modules/widgets/ticket_info.dart';
import 'package:scan_app/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  // bool isSearching = false;
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _performSearch(String query) {
      // Implement your search logic here
    }

    return Scaffold(
      // appBar: CustomAppbarWidget(
      //   addBackButton: false,
      //   title: 'Events',
      //   centerTitle: false,
      // ),
      appBar: AppBar(
        title: Text("Events"),
        centerTitle: false,
      ),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(16.0), child: SearchInput(onSearch: controller.searchQuery,)),
        Expanded(
          child: Obx(() {return controller.isLoading.value ? const Center(
          child: CircularProgressIndicator(), // Show a loading indicator
        ) :  ListView.builder(
            itemCount: controller.filteredEvents.length,
            itemBuilder: (context, eventIndex) {
              final event = controller.filteredEvents[eventIndex];
              return Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  children: const [
                    SlidableAction(
                      onPressed: null,
                      backgroundColor: Color(0xFF7BC043),
                      foregroundColor: Colors.white,
                      icon: Icons.archive,
                      label: 'Archive',
                    ),
                    SlidableAction(
                      onPressed: null,
                      backgroundColor: Color(0xFF0392CF),
                      foregroundColor: Colors.white,
                      icon: Icons.save,
                      label: 'Save',
                    ),
                  ],
                ),
                child: ExpansionTile(
                  title: GestureDetector(
                      onLongPress: () {
                        Get.toNamed(Routes.EVENT, arguments: {'event': event});
                      },
                      onTap: (){
                        controller.getTicketsByEventId(event.id);
                      },
                      child: Text(event.name)),
                      children: controller.associatedTickets.asMap().entries.map((entry) {
                        final index = entry.key;
                        final ticket = entry.value;
                        return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TicketInfo(
                                index: index,
                                ticketId: ticket.id.toString(),
                                fullName: ticket.fullName.toString(),
                                scannedTimestamp: ticket.createdAt.toString(),
                                amountPaid: "1000 RWF"));
                      }).toList(),
                ),
              );
            },
          );}),
        ),
      ]),
 
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your scanning logic here
          // This will be triggered when the button is pressed
          showModalBottomSheet(
              context: context,
              builder: (context) => ScanQrPage(),
              isScrollControlled: true);
        },
        child: const Icon(Icons.qr_code),
      ),
    );
  }
}

