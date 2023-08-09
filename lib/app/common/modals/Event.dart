import 'package:scan_app/app/common/modals/Ticket.dart';

class Event {
  final String title;
  final List<Ticket> tickets;

  Event({required this.title, required this.tickets});

 factory Event.fromJson(Map<String, dynamic> json) {
  final List<dynamic> ticketJsonList = json['tickets'];
  final List<Ticket> ticketList = ticketJsonList.map((ticketJson) => Ticket.fromJson(ticketJson as Map<String, dynamic>)).toList();

  return Event(
    title: json['title'],
    tickets: ticketList,
  );
}


  Map<String, dynamic> toJson() {
    final List ticketJsonList = tickets.map((ticket) => ticket.toJson()).toList();

    return {
      'title': title,
      'tickets': ticketJsonList,
    };
  }
}
