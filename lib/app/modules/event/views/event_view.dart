import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:scan_app/app/common/modals/Event.dart';
import 'package:scan_app/app/modules/event/controllers/event_controller.dart';
import 'package:scan_app/app/modules/widgets/custom_appbar_widget.dart';
import 'package:scan_app/app/modules/widgets/custom_text_field_widget.dart';
import 'package:scan_app/app/modules/widgets/search_input.dart';
import 'package:scan_app/app/modules/widgets/ticket_info.dart';
import 'package:scan_app/app/routes/app_pages.dart';

class EventView extends GetView<EventController> {
  const EventView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Get the arguments passed from the previous screen
      Get.put(EventController());
      

    final dynamic arguments = Get.arguments;
    if (arguments == null || !(arguments is Map<String, dynamic>)) {
      // Handle invalid or missing arguments here
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Invalid arguments'),
        ),
      );
    }

    // Extract the event from the arguments
    final dynamic eventMap = arguments['event'];
    controller.loadEventAndTickets();
    // final event = Event.fromJson(eventMap);

    return Scaffold(
      appBar: CustomAppbarWidget(
        onBackPress: () {
          // Get.toNamed(Routes.HOME);
          Get.back();
        },
        title: controller.selectedEvent.value?.name,
        // title: event?.title ?? 'Event',
      ),
      body: Column(
        children: [
           Padding(
            padding: EdgeInsets.all(16),
            // child: CustomTextFieldWidget(
            //   labelText: "Ticket Id, customer name ...",
            //   autovalidateMode: AutovalidateMode.disabled,
            // ),
            child: SearchInput(onSearch: controller.searchQuery),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: 
               (controller.associatedTickets.isEmpty) ? 
              const Center(
                  child: Text("No tickets"),
                )
              :
              Obx(() {return ListView.builder(
              itemCount: controller.filteredTickets.value.length ?? 0,
              itemBuilder: (context, index) {
                final ticket = controller.associatedTickets.value[index];
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TicketInfo(
                      index: index,
                      ticketId: ticket.id.toString() ?? '',
                      fullName: ticket?.fullName ?? '',
                      scannedTimestamp: ticket?.createdAt.toString() ?? '',
                      // scannedTime: "11: 00" ?? '',
                      amountPaid: "1000 RWF" ?? '',
                    ),
                  ),
                );
              },
            );})
          ),
        ],
      ),
      // body: Center(child: Text("Event page"),),
    );
  }
}
