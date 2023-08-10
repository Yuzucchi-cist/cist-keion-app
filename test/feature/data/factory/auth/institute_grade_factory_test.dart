import 'package:cist_keion_app/feature/data/factory/auth/institute_grade_factory.dart';
import 'package:cist_keion_app/feature/data/model/auth/member_detail/institute_grade_model.dart';
import 'package:cist_keion_app/feature/domain/value/institute_grade.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final factory = InstituteGradeFactoryImpl();

  const tValue = InstituteGrade.first;
  const tModel = InstituteGradeModel.first;

  group('create', () {
    test('should return institute grade', () {
      // act
      final result = factory.create('first');
      // assert
      expect(result, tValue);
    });
  });

  group('createFromModel', () {
    test('should return member', () {
      // act
      final result = factory.createFromModel(tModel);
      // assert
      expect(result, tValue);
    });
  });

  group('convertToModel', () {
    test('should return model', () {
      // act
      final result = factory.convertToModel(tValue);
      // assert
      expect(result, tModel);
    });
  });
}
