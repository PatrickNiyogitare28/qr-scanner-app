import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String description;
  final DateTime? eventDate;
  final String eventStatus;
  final bool firebaseSynced;
  final int id;
  final bool isEventPaid;
  final String name;
  final String? posterImgUrl;
  final String slug;
  final int userId;
  final String venue;

  Event({
    required this.description,
    required this.eventDate,
    required this.eventStatus,
    required this.firebaseSynced,
    required this.id,
    required this.isEventPaid,
    required this.name,
    required this.posterImgUrl,
    required this.slug,
    required this.userId,
    required this.venue,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      description: map['description'],
      eventDate: (map['event_date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      eventStatus: map['event_status'],
      firebaseSynced: map['firebase_synced'],
      id: map['id'],
      isEventPaid: map['is_event_paid'],
      name: map['name'],
      posterImgUrl: map['poster_img_url'] as String?,
      slug: map['slug'],
      userId: map['user_id'],
      venue: map['venue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'eventDate': eventDate?.toUtc().toIso8601String(),
      'eventStatus': eventStatus,
      'firebaseSynced': firebaseSynced,
      'id': id,
      'isEventPaid': isEventPaid,
      'name': name,
      'posterImgUrl': posterImgUrl,
      'slug': slug,
      'userId': userId,
      'venue': venue,
    };
  }
}
