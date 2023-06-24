import 'package:equatable/equatable.dart';

import '../../../../core/factories/data_factory.dart';
import '../../domain/entities/member.dart';
import '../models/firebase_auth/firebase_auth_user_model.dart';
import '../models/firestore/firestore_user_model.dart';
import 'belonging_factory.dart';
import 'institute_grade_factory.dart';
import 'user_state_factory.dart';

class MemberFactory implements DataFactory<Member, Models, Params> {
  MemberFactory({
    required this.instituteGradeFactory,
    required this.userStateFactory,
    required this.belongingFactory,
  });

  final InstituteGradeFactory instituteGradeFactory;
  final UserStateFactory userStateFactory;
  final BelongingFactory belongingFactory;
  @override
  Models convertToModel(Member entity) {
    final instituteGrade =
        instituteGradeFactory.convertToModel(entity.instituteGrade);
    final userState = userStateFactory.convertToModel(entity.userState);
    final belongings = entity.belongings
        .map((entity) => belongingFactory.convertToModel(entity))
        .toList();
    final authUserModel = FirebaseAuthUserModel.fromStudentNumber(
        studentNumber: entity.studentNumber, isEmailVerify: entity.isVerified);
    final storeUserModel = FirestoreUserModel(
        id: entity.memberId,
        studentNumber: entity.studentNumber,
        name: entity.name,
        instituteGrade: instituteGrade,
        userState: userState,
        belongings: belongings);
    return Models(authUserModel: authUserModel, storeUserModel: storeUserModel);
  }

  @override
  Member create(Params params) {
    final instituteGrade = instituteGradeFactory.create(params.instituteGrade);
    final userState = userStateFactory.create(params.userState);
    final belongings = params.belongingParams
        .map((belongingParam) => belongingFactory.create(belongingParam))
        .toList();
    return Member(
        memberId: params.memberId,
        studentNumber: params.studentNumber,
        name: params.name,
        instituteGrade: instituteGrade,
        userState: userState,
        isVerified: params.isVerified,
        belongings: belongings);
  }

  @override
  Member createFromModel(Models model) {
    final authUserModel = model.authUserModel;
    final storeUserModel = model.storeUserModel;
    final instituteGrade =
        instituteGradeFactory.createFromModel(storeUserModel.instituteGrade);
    final userState =
        userStateFactory.createFromModel(storeUserModel.userState);
    final belongings = storeUserModel.belongings
        .map((model) => belongingFactory.createFromModel(model))
        .toList();
    return Member(
      memberId: storeUserModel.id,
      studentNumber: authUserModel.studentNumber,
      name: storeUserModel.name,
      instituteGrade: instituteGrade,
      userState: userState,
      isVerified: authUserModel.isEmailVerify,
      belongings: belongings,
    );
  }
}

class Params {
  Params({
    required this.memberId,
    required this.studentNumber,
    required this.name,
    required this.instituteGrade,
    required this.userState,
    required this.isVerified,
    required this.belongingParams,
  });

  final String memberId;
  final String studentNumber;
  final String name;
  final String instituteGrade;
  final String userState;
  final bool isVerified;
  final List<BelongingParams> belongingParams;
}

class Models extends Equatable {
  const Models({required this.authUserModel, required this.storeUserModel});

  final FirebaseAuthUserModel authUserModel;
  final FirestoreUserModel storeUserModel;

  @override
  List<Object?> get props => [authUserModel, storeUserModel];
}
