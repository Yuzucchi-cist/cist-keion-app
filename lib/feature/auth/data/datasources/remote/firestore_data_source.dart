import '../../models/firestore/firestore_user_model.dart';

abstract class FirestoreDataSource {
  Future<FirestoreUserModel> getMemberByStudentNumber(String studentNumber);
}
