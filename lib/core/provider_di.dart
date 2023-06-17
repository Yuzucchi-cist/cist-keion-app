import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../feature/auth/data/datasources/remote/firebase_auth_data_source.dart';
import '../feature/auth/data/datasources/remote/firestore_data_source.dart';
import '../feature/auth/data/factories/belonging_factory.dart';
import '../feature/auth/data/factories/institute_grade_factory.dart';
import '../feature/auth/data/factories/member_factory.dart';
import '../feature/auth/data/factories/user_state_factory.dart';
import '../feature/auth/data/repositories/auth_repository_impl.dart';
import '../feature/auth/domain/usecases/register_member.dart';
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
