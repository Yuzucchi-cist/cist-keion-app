import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/exception/firestore_exception.dart';
import '../models/suggestion_model.dart';

const suggestionCollectionName = 'suggestion';

abstract class SuggestionRemoteDataSource {
  Future<void> add(SuggestionModel suggestionModel);
}

class SuggestionRemoteDataSourceImpl implements SuggestionRemoteDataSource {
  SuggestionRemoteDataSourceImpl({required this.firestore});

  final FirebaseFirestore firestore;
  @override
  Future<void> add(SuggestionModel suggestionModel) async {
    try {
      firestore
          .collection(suggestionCollectionName)
          .add(suggestionModel.toJson());
    } on FirebaseException catch (e) {
      throw FirestoreException(e.code);
    }
  }
}
