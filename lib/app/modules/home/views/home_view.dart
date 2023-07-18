import 'package:flutter/material.dart';
import 'package:scan_app/app/common/modals/Ticket.dart';
import 'package:scan_app/app/common/utils/exports.dart';
import 'package:scan_app/app/modules/home/controllers/home_controller.dart';
import 'package:scan_app/app/modules/widgets/custom_appbar_widget.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Ticket> dummyTickets = [
    Ticket(title: 'Sample Ticket 1', personName: 'John Doe', time: '9:00 AM'),
    Ticket(title: 'Sample Ticket 2', personName: 'Jane Smith', time: '11:30 AM'),
    Ticket(title: 'Sample Ticket 3', personName: 'Bob Johnson', time: '2:45 PM'),
    Ticket(title: 'Sample Ticket 3', personName: 'Bob Johnson', time: '2:45 PM'),
    Ticket(title: 'Sample Ticket 3', personName: 'Bob Johnson', time: '2:45 PM'),
    Ticket(title: 'Sample Ticket 3', personName: 'Bob Johnson', time: '2:45 PM'),
    Ticket(title: 'Sample Ticket 3', personName: 'Bob Johnson', time: '2:45 PM'),
    Ticket(title: 'Sample Ticket 3', personName: 'Bob Johnson', time: '2:45 PM'),
    Ticket(title: 'Sample Ticket 3', personName: 'Bob Johnson', time: '2:45 PM'),
    Ticket(title: 'Sample Ticket 3', personName: 'Bob Johnson', time: '2:45 PM'),
    Ticket(title: 'Sample Ticket 3', personName: 'Bob Johnson', time: '2:45 PM'),
    // Add more dummy tickets here as needed
  ];


    return Scaffold(
      appBar: CustomAppbarWidget(
        addBackButton: false,
        title: 'Tickets',
        centerTitle: false,
      ),
      body:ListView.builder(
      itemCount: dummyTickets.length,
      itemBuilder: (context, index) {
        final ticket = dummyTickets[index];
        return ListTile(
          title: Text(ticket.title),
          subtitle: Text('${ticket.personName} • ${ticket.time}'),
          onTap: () {
            // Add your navigation logic here if needed
          },
        );
      },
    ),
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your scanning logic here
          // This will be triggered when the button is pressed
        },
        child: Icon(Icons.qr_code),
      ),
    );
  }
}
