import 'package:cist_keion_app/feature/auth/data/factories/user_state_factory.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/user_state_model.dart';
import 'package:cist_keion_app/feature/auth/domain/values/user_state.dart';
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
