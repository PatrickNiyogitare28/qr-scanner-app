import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket {
  final int? clientId;
  final String? companyName;
  final DateTime? createdAt;
  final String? email;
  final int eventId;
  final bool? firebaseSynced;
  final String? fullName;
  final int id;
  final bool? isEmailSent;
  final bool? isSmsSent;
  final String? phoneNumber;
  final String? status;
  final int? ticketId;
  final String? title;
  final int? transactionId;
  final DateTime? updatedAt;
  final int? userId;
  late final bool? validity;

  Ticket({
    required this.clientId,
    required this.companyName,
    required this.createdAt,
    required this.email,
    required this.eventId,
    required this.firebaseSynced,
    required this.fullName,
    required this.id,
    required this.isEmailSent,
    required this.isSmsSent,
    required this.phoneNumber,
    required this.status,
    required this.ticketId,
    required this.title,
    required this.transactionId,
    required this.updatedAt,
    required this.userId,
    required this.validity,
  });

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      clientId: map['client_id'],
      companyName: map['company_name'],
      createdAt: (map['created_at'] as Timestamp).toDate(),
      email: map['email'],
      eventId: map['event_id'],
      firebaseSynced: map['firebase_synced'],
      fullName: map['full_name'],
      id: map['id'],
      isEmailSent: map['is_email_sent'],
      isSmsSent: map['is_sms_sent'],
      phoneNumber: map['phone_number'],
      status: map['status'],
      ticketId: map['ticket_id'],
      title: map['title'],
      transactionId: map['transaction_id'],
      updatedAt: (map['updated_at'] as Timestamp).toDate(),
      userId: map['user_id'],
      validity: map['validity'],
    );
  }


  factory Ticket.fromJson(Map<String, dynamic> map) {
  return Ticket(
    clientId: map['clientId'] ?? null,
    companyName: map['companyName'] ?? null,
    createdAt: (map['createdAt'] != null)
        ? DateTime.parse(map['createdAt'] as String)
        : null,
    email: map['email'] ?? null,
    eventId: map['eventId'] ?? 0,
    firebaseSynced: map['firebaseSynced'] ?? false,
    fullName: map['fullName'] ?? null,
    id: map['id'] ?? 0,
    isEmailSent: map['isEmailSent'] ?? false,
    isSmsSent: map['isSmsSent'] ?? false,
    phoneNumber: map['phoneNumber'] ?? null,
    status: map['status'] ?? null,
    ticketId: map['ticketId'] ?? null,
    title: map['title'] ?? null,
    transactionId: map['transactionId'] ?? 0,
    updatedAt: (map['updatedAt'] != null)
        ? DateTime.parse(map['updatedAt'] as String)
        : null,
    userId: map['userId'] ?? 0,
    validity: map['validity'] ?? false,
  );
}


  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'companyName': companyName,
      'createdAt': createdAt?.toUtc().toIso8601String(),
      'email': email,
      'eventId': eventId,
      'firebaseSynced': firebaseSynced,
      'fullName': fullName,
      'id': id,
      'isEmailSent': isEmailSent,
      'isSmsSent': isSmsSent,
      'phoneNumber': phoneNumber,
      'status': status,
      'ticketId': ticketId,
      'title': title,
      'transactionId': transactionId,
      'updatedAt': updatedAt?.toUtc().toIso8601String(),
      'userId': userId,
      'validity': validity,
    };
  }
}
