import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../feature/data/datasource/authentication_data_source.dart';
import '../feature/data/datasource/member_detail_local_data_source.dart';
import '../feature/data/datasource/member_detail_remote_data_source.dart';
import '../feature/data/datasource/reservation_local_data_source.dart';
import '../feature/data/datasource/reservation_remote_data_source.dart';
import '../feature/data/datasource/suggestion_data_source.dart';
import '../feature/data/factory/auth/member_factory.dart';
import '../feature/data/factory/member_detail/belonging_factory.dart';
import '../feature/data/factory/member_detail/institute_grade_factory.dart';
import '../feature/data/factory/member_detail/member_detail_factory.dart';
import '../feature/data/factory/member_detail/user_state_factory.dart';
import '../feature/data/factory/reservation/institute_time_factory.dart';
import '../feature/data/factory/reservation/reservation_factory.dart';
import '../feature/data/factory/reservation/reserved_member_factory.dart';
import '../feature/data/factory/suggestion/suggestion_category_factory.dart';
import '../feature/data/factory/suggestion/suggestion_factory.dart';
import '../feature/data/repository/auth_repository_impl.dart';
import '../feature/data/repository/member_detail_repository_impl.dart';
import '../feature/data/repository/reservation_repository_impl.dart';
import '../feature/data/repository/suggestion_repository_impl.dart';
import '../feature/domain/usecase/auth/get_member_stream.dart';
import '../feature/domain/usecase/auth/initialize_auth.dart';
import '../feature/domain/usecase/auth/login.dart';
import '../feature/domain/usecase/auth/logout.dart';
import '../feature/domain/usecase/auth/register_member.dart';
import '../feature/domain/usecase/member_detail/get_member_detail_from_file.dart';
import '../feature/domain/usecase/reservation/add_reservations.dart';
import '../feature/domain/usecase/reservation/delete_reservations.dart';
import '../feature/domain/usecase/reservation/get_reservations_next_week.dart';
import '../feature/domain/usecase/reservation/get_reservations_this_week.dart';
import '../feature/domain/usecase/suggestion/add_suggestion.dart';
import '../feature/domain/usecase/suggestion/get_suggestions.dart';
import 'network/network_info.dart';

final connectivityProvider = Provider((ref) => Connectivity());
final networkInfoProvider =
    Provider((ref) => NetworkInfoImpl(ref.watch(connectivityProvider)));

final sharedPreferencesProvider =
    Provider<SharedPreferences>((_) => throw UnimplementedError());
final filePickerProvider = Provider<FilePicker>((ref) => FilePicker.platform);

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

// auth
final firebaseAuthDataSourceProvider = Provider((ref) =>
    AuthenticationDataSourceImpl(auth: ref.watch(firebaseAuthProvider)));
final firestoreDataSourceProvider = Provider((ref) =>
    MemberDetailRemoteDataSourceImpl(firestore: ref.watch(firestoreProvider)));

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
    authenticationDataSource: ref.watch(firebaseAuthDataSourceProvider),
    memberDetailDataSource: ref.watch(firestoreDataSourceProvider),
    memberFactory: ref.watch(memberFactoryProvider),
  ),
);

// member_detail
final memberDetailLocalDataSource = Provider((ref) =>
    MemberDetailLocalDataSourceImpl(filePicker: ref.watch(filePickerProvider)));

final memberDetailFactoryProvider = Provider((ref) => MemberDetailFactory(
      instituteGradeFactory: ref.watch(instituteGradeFactoryProvider),
      userStateFactory: ref.watch(userStateFactoryProvider),
      belongingFactory: ref.watch(belongingFactoryProvider),
    ));

final memberDetailRepositoryProvider =
    Provider((ref) => MemberDetailRepositoryImpl(
          memberDetailLLocalDataSource: ref.watch(memberDetailLocalDataSource),
          memberDetailFactory: ref.watch(memberDetailFactoryProvider),
        ));

final getMemberDetailFromFileProvider = Provider((ref) =>
    GetMemberDetailFromFile(
        memberDetailRepository: ref.watch(memberDetailRepositoryProvider)));

final registerMemberProvider = Provider(
    (ref) => RegisterMember(authRepository: ref.watch(authRepositoryProvider)));
final loginProvider =
    Provider((ref) => Login(authRepository: ref.watch(authRepositoryProvider)));
final logoutProvider = Provider(
    (ref) => Logout(authRepository: ref.watch(authRepositoryProvider)));
final initializeProvider = Provider(
    (ref) => InitializeAuth(authRepository: ref.watch(authRepositoryProvider)));
final getAuthStateProvider = Provider((ref) =>
    GetMemberStream(authRepository: ref.watch(authRepositoryProvider)));

// reservation
final reservationRemoteDataSourceProvider = Provider((ref) =>
    ReservationRemoteDataSourceImpl(firestore: ref.watch(firestoreProvider)));
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
        remoteDataSource: ref.watch(reservationRemoteDataSourceProvider),
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

// suggestion
final suggestionRemoteDataSourceProvider = Provider(
    (ref) => SuggestionDataSourceImpl(firestore: ref.watch(firestoreProvider)));

final suggestionCategoryFactoryProvider =
    Provider((ref) => SuggestionCategoryFactory());
final suggestionFactoryProvider = Provider((ref) => SuggestionFactory(
    suggestionCategoryFactory: ref.watch(suggestionCategoryFactoryProvider)));

final suggestionRepositoryProvider = Provider((ref) => SuggestionRepositoryImpl(
    suggestionDataSource: ref.watch(suggestionRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
    suggestionFactory: ref.watch(suggestionFactoryProvider)));

final addSuggestionProvider = Provider((ref) => AddSuggestion(
    suggestionRepository: ref.watch(suggestionRepositoryProvider)));
final getSuggestionsProvider = Provider((ref) => GetSuggestions(
    suggestionRepository: ref.watch(suggestionRepositoryProvider)));
