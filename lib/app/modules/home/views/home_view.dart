import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scan_app/app/common/modals/Ticket.dart';
import 'package:scan_app/app/modules/home/controllers/home_controller.dart';
import 'package:scan_app/app/modules/scanner/views/scanner_view.dart';
import 'package:scan_app/app/modules/widgets/custom_appbar_widget.dart';
import 'package:get/get.dart';
import 'package:scan_app/app/modules/widgets/search_input.dart';
import 'package:scan_app/app/modules/widgets/ticket_info.dart';

class Event {
  final String title;
  final List<Ticket> tickets;

  Event({required this.title, required this.tickets});
}

class HomeView extends GetView<HomeController> {
  // bool isSearching = false;
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Event> dummyEvents = [
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

    void _performSearch(String query) {
      // Implement your search logic here
    }

    return Scaffold(
      appBar: CustomAppbarWidget(
        addBackButton: false,
        title: 'Events',
        centerTitle: false,
      ),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(16.0), child: SearchInput()),
        Expanded(
          child: ListView.builder(
            itemCount: dummyEvents.length,
            itemBuilder: (context, eventIndex) {
              final event = dummyEvents[eventIndex];
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
                  title: Text(event.title),
                  children: event.tickets.asMap().entries.map((entry) {
                    final index = entry.key;
                    final ticket = entry.value;
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TicketInfo(
                            index: index,
                            ticketId: ticket.ticketId,
                            fullName: ticket.fullName,
                            scannedDate: ticket.scannedDate,
                            scannedTime: ticket.scannedTime,
                            amountPaid: ticket.amountPaid));
                  }).toList(),
                ),
              );
            },
          ),
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
