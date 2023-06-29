import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/exception/firestore_exception.dart';
import '../models/reservation_model.dart';

const reservationCollectionName = 'reservations';

abstract class ReservationRemoteDataSource {
  Future<List<ReservationModel>> getReservationsBetween(
      Timestamp startDate, Timestamp endDate);
}

class RemoteDataSourceImpl implements ReservationRemoteDataSource {
  RemoteDataSourceImpl({required this.firestore});

  final FirebaseFirestore firestore;

  @override
  Future<List<ReservationModel>> getReservationsBetween(
      Timestamp startDate, Timestamp endDate) async {
    try {
      final docs = (await firestore
              .collection(reservationCollectionName)
              .where('date', isGreaterThanOrEqualTo: startDate)
              .where('date', isLessThanOrEqualTo: endDate)
              .get())
          .docs;
      return Future.wait(docs.map((doc) async {
        final data = await Future.wait(doc.data().entries.map((e) async {
          return _convertReservedMember(e);
        }));
        return ReservationModel.fromFirestoreJson(
            doc.id, Map.fromEntries(data));
      }).toList());
    } on FirebaseException catch (e) {
      throw FirestoreException(e.code);
    }
  }

  Future<MapEntry<String, dynamic>> _convertReservedMember(
      MapEntry<String, dynamic> entry) async {
    final key = entry.key;
    final value = entry.value;
    if (key == 'reserved_member') {
      return MapEntry(key, {
        'id': ((value as Map)['id'] as DocumentReference).id,
        'name': value['name'],
      });
    }
    return MapEntry(key, value);
  }
}
