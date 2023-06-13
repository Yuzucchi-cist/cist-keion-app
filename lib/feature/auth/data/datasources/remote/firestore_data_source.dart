import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/error/exception/firestore_exception.dart';
import '../../models/firestore/firestore_user_model.dart';

const authCollectionName = 'auth';

abstract class FirestoreDataSource {
  Future<FirestoreUserModel> getMemberByStudentNumber(String studentNumber);
}

class FirestoreDataSourceImpl implements FirestoreDataSource {
  FirestoreDataSourceImpl({required this.firestore});

  final FirebaseFirestore firestore;

  @override
  Future<FirestoreUserModel> getMemberByStudentNumber(
      String studentNumber) async {
    try {
      final firestoreDocs = (await firestore
              .collection(authCollectionName)
              .where('student_number', isEqualTo: studentNumber)
              .get())
          .docs;
      if (firestoreDocs.isNotEmpty) {
        return FirestoreUserModel.fromFirestoreJson(
            firestoreDocs.first.id, firestoreDocs.first.data());
      } else {
        throw FirestoreException('no-member');
      }
    } on FirebaseException catch (e) {
      throw FirestoreException(e.code);
    }
  }
}
