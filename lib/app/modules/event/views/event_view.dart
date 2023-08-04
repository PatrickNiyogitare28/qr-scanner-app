import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:scan_app/app/modules/home/views/home_view.dart';
import 'package:scan_app/app/modules/widgets/custom_appbar_widget.dart';
import 'package:scan_app/app/modules/widgets/custom_text_field_widget.dart';
import 'package:scan_app/app/modules/widgets/ticket_info.dart';
import 'package:scan_app/app/routes/app_pages.dart';

class EventView extends StatelessWidget {
  const EventView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the arguments passed from the previous screen
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
    final event = arguments['event'] as Event?;

    return Scaffold(
      appBar: CustomAppbarWidget(
        onBackPress: () {
          Get.toNamed(Routes.HOME);
        },
        title: event?.title ?? 'Event',
      ),
      body:  Column(
        children: [
        const Padding(
          padding:  EdgeInsets.all(16),
          child:  CustomTextFieldWidget(labelText: "Ticket Id, customer name ...", autovalidateMode: AutovalidateMode.disabled,),
        ),
        const SizedBox(height: 10,),
        Expanded(
          child: ListView.builder(
            itemCount: event?.tickets.length ?? 0,
            itemBuilder: (context, index) {
              final ticket = event?.tickets[index];
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
                    ticketId: ticket?.ticketId ?? '',
                    fullName: ticket?.fullName ?? '',
                    scannedDate: ticket?.scannedDate ?? '',
                    scannedTime: ticket?.scannedTime ?? '',
                    amountPaid: ticket?.amountPaid ?? '',
                  ),
                ),
              );
            },
          ),
        ),

        ],
      ),
    );
  }
}
