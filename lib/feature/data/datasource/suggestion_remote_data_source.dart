import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/exception/firestore_exception.dart';
import '../model/suggestion/suggestion_model.dart';

const suggestionCollectionName = 'suggestion';

abstract class SuggestionRemoteDataSource {
  Future<void> add(SuggestionModel suggestionModel);
  Future<List<SuggestionModel>> getAll();
}

class SuggestionRemoteDataSourceImpl implements SuggestionRemoteDataSource {
  SuggestionRemoteDataSourceImpl({required this.firestore});

  final FirebaseFirestore firestore;
  @override
  Future<void> add(SuggestionModel suggestionModel) async {
    try {
      firestore
          .collection(suggestionCollectionName)
          .add(suggestionModel.toFirestoreJson);
    } on FirebaseException catch (e) {
      throw FirestoreException(e.code);
    }
  }

  @override
  Future<List<SuggestionModel>> getAll() async {
    final docs =
        (await firestore.collection(suggestionCollectionName).get()).docs;
    return docs
        .map((doc) => SuggestionModel.fromFirestoreJson(doc.id, doc.data()))
        .toList();
  }
}
