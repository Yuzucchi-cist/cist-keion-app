import '../../../../core/factories/data_factory.dart';
import '../../../domain/entity/member_detail/member_detail.dart';
import '../../model/member_detail/member_detail_model.dart';
import 'belonging_factory.dart';
import 'institute_grade_factory.dart';
import 'user_state_factory.dart';

class MemberDetailFactory
    implements
        DataFactory<MemberDetail, MemberDetailModel, MemberDetailParams> {
  MemberDetailFactory(
      {required this.instituteGradeFactory,
      required this.userStateFactory,
      required this.belongingFactory});

  final InstituteGradeFactory instituteGradeFactory;
  final UserStateFactory userStateFactory;
  final BelongingFactory belongingFactory;

  @override
  MemberDetailModel convertToModel(MemberDetail entity) {
    return MemberDetailModel(
      id: entity.id,
      studentNumber: entity.studentNumber,
      name: entity.name,
      instituteGrade:
          instituteGradeFactory.convertToModel(entity.instituteGrade),
      userState: userStateFactory.convertToModel(entity.userState),
      belongings: entity.belongings
          .map((belonging) => belongingFactory.convertToModel(belonging))
          .toList(),
    );
  }

  @override
  MemberDetail create(MemberDetailParams params) {
    return MemberDetail(
      id: params.id,
      studentNumber: params.studentNumber,
      name: params.name,
      instituteGrade: instituteGradeFactory.create(params.userState),
      userState: userStateFactory.create(params.userState),
      isAdmin: params.isAdmin,
      belongings: params.belongingParams
          .map((belongingParam) => belongingFactory.create(belongingParam))
          .toList(),
    );
  }

  @override
  MemberDetail createFromModel(MemberDetailModel model) {
    return MemberDetail(
      id: model.id,
      studentNumber: model.studentNumber,
      name: model.name,
      instituteGrade:
          instituteGradeFactory.createFromModel(model.instituteGrade),
      isAdmin: model.isAdmin,
      belongings: model.belongings
          .map((belongingModel) =>
              belongingFactory.createFromModel(belongingModel))
          .toList(),
    );
  }
}

class MemberDetailParams {
  MemberDetailParams({
    required this.id,
    required this.studentNumber,
    required this.name,
    required this.instituteGrade,
    required this.userState,
    required this.isAdmin,
    required this.belongingParams,
  });

  final String id;
  final String studentNumber;
  final String name;
  final String instituteGrade;
  final String userState;
  final bool isAdmin;
  final List<BelongingParams> belongingParams;
}
