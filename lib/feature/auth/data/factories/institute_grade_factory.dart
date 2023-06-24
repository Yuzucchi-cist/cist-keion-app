import '../../../../core/factories/data_factory.dart';
import '../../domain/values/institute_grade.dart';
import '../models/firestore/institute_grade_model.dart';

abstract class InstituteGradeFactory
    implements DataFactory<InstituteGrade, InstituteGradeModel, String> {}

class InstituteGradeFactoryImpl implements InstituteGradeFactory {
  @override
  InstituteGrade create(String value) {
    return InstituteGrade.values.byName(value);
  }

  @override
  InstituteGrade createFromModel(InstituteGradeModel model) {
    switch (model) {
      case InstituteGradeModel.first:
        return InstituteGrade.first;
      case InstituteGradeModel.second:
        return InstituteGrade.second;
      case InstituteGradeModel.third:
        return InstituteGrade.third;
      case InstituteGradeModel.forth:
        return InstituteGrade.forth;
      case InstituteGradeModel.other:
        return InstituteGrade.other;
    }
  }

  @override
  InstituteGradeModel convertToModel(InstituteGrade time) {
    switch (time) {
      case InstituteGrade.first:
        return InstituteGradeModel.first;
      case InstituteGrade.second:
        return InstituteGradeModel.second;
      case InstituteGrade.third:
        return InstituteGradeModel.third;
      case InstituteGrade.forth:
        return InstituteGradeModel.forth;
      case InstituteGrade.other:
        return InstituteGradeModel.other;
    }
  }
}
