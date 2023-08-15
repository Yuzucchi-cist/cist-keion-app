import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/exception/firestore_exception.dart';
import '../model/member_detail/member_detail_model.dart';

const authCollectionName = 'users';

abstract class MemberDetailRemoteDataSource {
  Future<MemberDetailModel> getByStudentNumber(String studentNumber);
  Future<List<MemberDetailModel>> getAll();
  Future<List<MemberDetailModel>> add(List<MemberDetailModel> data);
}

class MemberDetailRemoteDataSourceImpl implements MemberDetailRemoteDataSource {
  MemberDetailRemoteDataSourceImpl({required this.firestore});

  final FirebaseFirestore firestore;

  @override
  Future<MemberDetailModel> getByStudentNumber(String studentNumber) async {
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

  @override
  Future<List<MemberDetailModel>> getAll() async {
    try {
      final firestoreDocs =
          (await firestore.collection(authCollectionName).get()).docs;

      return firestoreDocs
          .map((doc) => MemberDetailModel.fromFirestoreJson(doc.id, doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw FirestoreException(e.code);
    }
  }

  @override
  Future<List<MemberDetailModel>> add(List<MemberDetailModel> data) async {
    try {
      final batch = firestore.batch();
      for (final model in data) {
        batch.set(firestore.collection(authCollectionName).doc(),
            model.toFirestoreJson());
      }
      await batch.commit();
      final addedModelStudentNumberList =
          data.map((model) => model.studentNumber);
      final docs = (await firestore
              .collection(authCollectionName)
              .where('student_number', whereIn: addedModelStudentNumberList)
              .get())
          .docs;
      return docs
          .map((doc) => MemberDetailModel.fromFirestoreJson(doc.id, doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw FirestoreException(e.code);
    }
  }
}
