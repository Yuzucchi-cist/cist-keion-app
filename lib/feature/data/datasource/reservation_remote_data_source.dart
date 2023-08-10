import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/exception/firestore_exception.dart';
import '../model/reservation/reservation_model.dart';
import 'member_detail_data_source.dart';

const reservationCollectionName = 'reservations';

abstract class ReservationRemoteDataSource {
  Future<List<ReservationModel>> getReservationsBetween(
      Timestamp startDate, Timestamp endDate);

  Future<void> addReservations(List<ReservationModel> reservations);

  Future<void> deleteReservations(List<String> reservationIds);
}

class ReservationRemoteDataSourceImpl implements ReservationRemoteDataSource {
  ReservationRemoteDataSourceImpl({required this.firestore});

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

  @override
  Future<void> addReservations(List<ReservationModel> reservations) async {
    try {
      final batch = firestore.batch();

      for (final reservation in reservations) {
        final convertedReservationEntry = await Future.wait(
            reservation.toFirestoreJson.entries.map((entry) async {
          final key = entry.key;
          final value = entry.value;
          if (key == 'reserved_member') {
            final documentReference = firestore
                .collection(authCollectionName)
                .doc((value as Map)['id'] as String);
            return MapEntry(key,
                {'id': documentReference, 'name': value['name'] as String});
          } else {
            return MapEntry(key, value);
          }
        }));
        final convertedReservation = Map.fromEntries(convertedReservationEntry);
        batch.set(firestore.collection(reservationCollectionName).doc(),
            convertedReservation);
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      throw FirestoreException(e.code);
    }
  }

  @override
  Future<void> deleteReservations(List<String> reservationIds) async {
    try {
      final batch = firestore.batch();
      for (final id in reservationIds) {
        final doc = firestore.collection(reservationCollectionName).doc(id);
        batch.delete(doc);
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      throw FirestoreException(e.code);
    }
  }
}
