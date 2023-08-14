import 'package:cist_keion_app/feature/data/factory/member_detail/user_state_factory.dart';
import 'package:cist_keion_app/feature/data/model/member_detail/user_state_model.dart';
import 'package:cist_keion_app/feature/domain/value/user_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final factory = UserStateFactoryImpl();

  const tValue = UserState.active;
  const tModel = UserStateModel.active;

  group('create', () {
    test('should return user state', () {
      // act
      final result = factory.create('active');
      // assert
      expect(result, tValue);
    });
  });

  group('createFromModel', () {
    test('should return user state from user state model', () {
      // act
      final result = factory.createFromModel(tModel);
      // assert
      expect(result, tValue);
    });
  });

  group('convertToModel', () {
    test('should return user state model from user state', () {
      // act
      final result = factory.convertToModel(tValue);
      // assert
      expect(result, tModel);
    });
  });
}
