import 'package:equatable/equatable.dart';

import '../../../../core/factories/data_factory.dart';
import '../../../domain/entity/auth/member.dart';
import '../../model/auth/authentication_user_model.dart';
import '../../model/member_detail/member_detail_model.dart';
import '../member_detail/belonging_factory.dart';
import '../member_detail/institute_grade_factory.dart';
import '../member_detail/user_state_factory.dart';

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
    final authUserModel = AuthenticationUserModel.fromStudentNumber(
        studentNumber: entity.studentNumber, isEmailVerify: entity.isVerified);
    final memberDetailModel = MemberDetailModel(
        id: entity.memberId,
        studentNumber: entity.studentNumber,
        name: entity.name,
        instituteGrade: instituteGrade,
        userState: userState,
        belongings: belongings);
    return Models(
        authUserModel: authUserModel, memberDetailModel: memberDetailModel);
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
    final memberDetailModel = model.memberDetailModel;
    final instituteGrade =
        instituteGradeFactory.createFromModel(memberDetailModel.instituteGrade);
    final userState =
        userStateFactory.createFromModel(memberDetailModel.userState);
    final belongings = memberDetailModel.belongings
        .map((model) => belongingFactory.createFromModel(model))
        .toList();
    return Member(
      memberId: memberDetailModel.id,
      studentNumber: authUserModel.studentNumber,
      name: memberDetailModel.name,
      instituteGrade: instituteGrade,
      userState: userState,
      isVerified: authUserModel.isEmailVerify,
      belongings: belongings,
      isAdmin: memberDetailModel.isAdmin,
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
  const Models({required this.authUserModel, required this.memberDetailModel});

  final AuthenticationUserModel authUserModel;
  final MemberDetailModel memberDetailModel;

  @override
  List<Object?> get props => [authUserModel, memberDetailModel];
}
