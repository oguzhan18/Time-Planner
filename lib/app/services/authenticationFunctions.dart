import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/models/userModel.dart';

class AuthenticationFunctions {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<UserModel> getUserData() async {
    User currentUser = firebaseAuth.currentUser!;
    DocumentSnapshot userDocumentSnapshot =
        await firebaseFirestore.collection('users').doc(currentUser.uid).get();
    return UserModel.fromSnap(userDocumentSnapshot);
  }

  Future<String> signUpUser({
    required String userName,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      _storeUserDataOnFirebase(
        email,
        userName,
        userCredential.user!.uid,
        phone,
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return "An error occurred while trying to sign you up. Please try again later.";
    }
  }

  Future<void> _storeUserDataOnFirebase(
      String email, String userName, String id, String phone) async {
    UserModel tempUserModel = UserModel.name(
      email: email,
      userName: userName,
      userId: id,
      phone: phone,
    );
    await firebaseFirestore.collection('users').doc(id).set(
          tempUserModel.toJson(),
        );
    return;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return "An error occurred while tring to log you in, please try again later!";
    }
  }

  Future<String> deleteUser() async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .delete();
      await firebaseAuth.currentUser!.delete();
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return "An error occurred while deleting your user. Please contact admin.";
    }
  }
}
