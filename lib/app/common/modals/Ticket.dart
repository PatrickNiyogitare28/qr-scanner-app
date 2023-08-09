class Ticket {
  final String ticketId;
  final String amountPaid;
  final int numberOfTickets;
  final String fullName;
  final String scannedDate;
  final String scannedTime;

  Ticket({
    required this.ticketId,
    required this.amountPaid,
    required this.numberOfTickets,
    required this.fullName,
    required this.scannedDate,
    required this.scannedTime,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      ticketId: json['ticketId'],
      amountPaid: json['amountPaid'],
      numberOfTickets: json['numberOfTickets'],
      fullName: json['fullName'],
      scannedDate: json['scannedDate'],
      scannedTime: json['scannedTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'amountPaid': amountPaid,
      'numberOfTickets': numberOfTickets,
      'fullName': fullName,
      'scannedDate': scannedDate,
      'scannedTime': scannedTime,
    };
  }
}
