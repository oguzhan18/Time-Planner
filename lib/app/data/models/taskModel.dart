// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  late String title;
  late String description;
  late DateTime eventDate;
  late String status;
  late String id;

  TaskModel.name({
    required this.title,
    required this.description,
    required this.eventDate,
    required this.status,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'eventDate': eventDate,
        'status': status,
        'id': id,
      };

  static TaskModel fromSnap(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return TaskModel.name(
      id: snapshot['id'],
      status: snapshot['status'],
      title: snapshot['title'],
      description: snapshot['description'],
      eventDate: (snapshot['eventDate'] as Timestamp).toDate(),
    );
  }
}
