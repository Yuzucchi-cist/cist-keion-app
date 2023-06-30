import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../feature/auth/data/datasources/remote/firebase_auth_data_source.dart';
import '../feature/auth/data/datasources/remote/firestore_data_source.dart';
import '../feature/auth/data/factories/belonging_factory.dart';
import '../feature/auth/data/factories/institute_grade_factory.dart';
import '../feature/auth/data/factories/member_factory.dart';
import '../feature/auth/data/factories/user_state_factory.dart';
import '../feature/auth/data/repositories/auth_repository_impl.dart';
import '../feature/auth/domain/usecases/initialize_auth.dart';
import '../feature/auth/domain/usecases/login.dart';
import '../feature/auth/domain/usecases/register_member.dart';
import '../feature/reservation/data/datasources/reservation_local_data_source.dart';
import '../feature/reservation/data/datasources/reservation_remote_data_source.dart';
import '../feature/reservation/data/factories/institute_time_factory.dart';
import '../feature/reservation/data/factories/reservation_factory.dart';
import '../feature/reservation/data/factories/reserved_member_factory.dart';
import '../feature/reservation/data/repositories/reservation_repository_impl.dart';
import '../feature/reservation/domain/usecases/add_reservations.dart';
import '../feature/reservation/domain/usecases/delete_reservations.dart';
import '../feature/reservation/domain/usecases/get_reservations_next_week.dart';
import '../feature/reservation/domain/usecases/get_reservations_this_week.dart';
import 'network/network_info.dart';

final connectivityProvider = Provider((ref) => Connectivity());
final networkInfoProvider =
    Provider((ref) => NetworkInfoImpl(ref.watch(connectivityProvider)));

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final firebaseAuthDataSourceProvider = Provider(
    (ref) => FirebaseAuthDataSourceImpl(auth: ref.watch(firebaseAuthProvider)));
final firestoreDataSourceProvider = Provider(
    (ref) => FirestoreDataSourceImpl(firestore: ref.watch(firestoreProvider)));

final instituteGradeFactoryProvider =
    Provider((ref) => InstituteGradeFactoryImpl());
final userStateFactoryProvider = Provider((ref) => UserStateFactoryImpl());
final belongingFactoryProvider = Provider((ref) => BelongingFactoryImpl());
final memberFactoryProvider = Provider((ref) => MemberFactory(
      instituteGradeFactory: ref.watch(instituteGradeFactoryProvider),
      userStateFactory: ref.watch(userStateFactoryProvider),
      belongingFactory: ref.watch(belongingFactoryProvider),
    ));

final authRepositoryProvider = Provider(
  (ref) => AuthRepositoryImpl(
    networkInfo: ref.watch(networkInfoProvider),
    authDataSource: ref.watch(firebaseAuthDataSourceProvider),
    storeDataSource: ref.watch(firestoreDataSourceProvider),
    memberFactory: ref.watch(memberFactoryProvider),
  ),
);

final registerMemberProvider = Provider(
    (ref) => RegisterMember(authRepository: ref.watch(authRepositoryProvider)));
final loginProvider =
    Provider((ref) => Login(authRepository: ref.watch(authRepositoryProvider)));
final initializeProvider = Provider(
    (ref) => InitializeAuth(authRepository: ref.watch(authRepositoryProvider)));

// reservation
final sharedPreferencesProvider =
    Provider<SharedPreferences>((_) => throw UnimplementedError());
final remoteDataSourceProvider = Provider(
    (ref) => RemoteDataSourceImpl(firestore: ref.watch(firestoreProvider)));
final localDataSourceProvider = Provider((ref) =>
    ReservationLocalDataSourceImpl(
        sharedPreferences: ref.watch(sharedPreferencesProvider)));

final reservedMemberFactoryProvider =
    Provider((ref) => ReservedMemberFactory());
final instituteTimeFactoryProvider = Provider((ref) => InstituteTimeFactory());
final reservationFactoryProvider = Provider((ref) => ReservationFactory(
    reservedMemberFactory: ref.watch(reservedMemberFactoryProvider),
    instituteTimeFactory: ref.watch(instituteTimeFactoryProvider)));

final reservationRepositoryProvider = Provider((ref) =>
    ReservationRepositoryImpl(
        remoteDataSource: ref.watch(remoteDataSourceProvider),
        localDataSource: ref.watch(localDataSourceProvider),
        networkInfo: ref.watch(networkInfoProvider),
        reservationFactory: ref.watch(reservationFactoryProvider)));

final getReservationsThisWeekProvider = Provider((ref) =>
    GetReservationsThisWeek(
        reservationRepository: ref.watch(reservationRepositoryProvider)));

final getReservationsNextWeekProvider = Provider((ref) =>
    GetReservationsNextWeek(
        reservationRepository: ref.watch(reservationRepositoryProvider)));

final addReservationsProvider = Provider((ref) => AddReservations(
    reservationRepository: ref.watch(reservationRepositoryProvider)));

final deleteReservationsProvider = Provider((ref) => DeleteReservations(
    reservationRepository: ref.watch(reservationRepositoryProvider)));
