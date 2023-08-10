import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/exception/firestore_exception.dart';
import '../model/auth/member_detail/member_detail_model.dart';

const authCollectionName = 'users';

abstract class MemberDetailDataSource {
  Future<MemberDetailModel> getMemberByStudentNumber(String studentNumber);
}

class FirestoreDataSourceImpl implements MemberDetailDataSource {
  FirestoreDataSourceImpl({required this.firestore});

  final FirebaseFirestore firestore;

  @override
  Future<MemberDetailModel> getMemberByStudentNumber(
      String studentNumber) async {
    try {
      final firestoreDocs = (await firestore
              .collection(authCollectionName)
              .where('student_number', isEqualTo: studentNumber)
              .get())
          .docs;
      if (firestoreDocs.isNotEmpty) {
        return MemberDetailModel.fromFirestoreJson(
            firestoreDocs.first.id, firestoreDocs.first.data());
      } else {
        throw FirestoreException('no-member');
      }
    } on FirebaseException catch (e) {
      throw FirestoreException(e.code);
    }
  }
}
