import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_planner/app/data/models/taskModel.dart';
import 'package:uuid/uuid.dart';

class PostingFunctions {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> addATask(
      {required String title,
      required String description,
      required DateTime eventDate,
      required String status}) async {
    try {
      String taskId = const Uuid().v1();
      TaskModel taskModel = TaskModel.name(
        id: taskId,
        title: title,
        description: description,
        eventDate: eventDate,
        status: status,
      );
      firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('tasks')
          .doc(taskId)
          .set(taskModel.toJson());
      return "Success";
    } on FirebaseException catch (e) {
      return e.message.toString();
    } catch (e) {
      return "An error occurred while trying to store your task! Please try again later.";
    }
  }

  changeTaskStatus(String status, String taskId) {
    firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .doc(taskId)
        .update({'status': status});
  }

  Future<void> deleteTodoTask(String taskId) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .doc(taskId)
        .delete();
    return;
  }

  Future<void> deleteUserData() async {
    firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .get()
        .then(
      (snapshot) async {
        TaskModel tempTaskModel;
        for (var element in snapshot.docs) {
          tempTaskModel = TaskModel.fromSnap(element);
          await deleteTodoTask(tempTaskModel.id);
        }
      },
    );
  }
}
