// Mocks generated by Mockito 5.4.1 from annotations
// in cist_keion_app/test/feature/auth/domain/usecases/login_test.dart.
// Do not manually edit this file.

// @dart=2.19

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:cist_keion_app/core/error/failure/failure.dart' as _i5;
import 'package:cist_keion_app/feature/auth/domain/entities/member.dart' as _i6;
import 'package:cist_keion_app/feature/auth/domain/repositories/auth_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i3.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>> registerMember(
    String? studentNumber,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #registerMember,
          [
            studentNumber,
            password,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>.value(
            _FakeEither_0<_i5.Failure, _i2.Unit>(
          this,
          Invocation.method(
            #registerMember,
            [
              studentNumber,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Member>> login(
    String? studentNumber,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [
            studentNumber,
            password,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Member>>.value(
            _FakeEither_0<_i5.Failure, _i6.Member>(
          this,
          Invocation.method(
            #login,
            [
              studentNumber,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Member>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>> logout(String? studentNumber) =>
      (super.noSuchMethod(
        Invocation.method(
          #logout,
          [studentNumber],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>.value(
            _FakeEither_0<_i5.Failure, _i2.Unit>(
          this,
          Invocation.method(
            #logout,
            [studentNumber],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>> sendEmailVerify(
          String? studentNumber) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendEmailVerify,
          [studentNumber],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>.value(
            _FakeEither_0<_i5.Failure, _i2.Unit>(
          this,
          Invocation.method(
            #sendEmailVerify,
            [studentNumber],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Member>> getCurrentMember() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentMember,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Member>>.value(
            _FakeEither_0<_i5.Failure, _i6.Member>(
          this,
          Invocation.method(
            #getCurrentMember,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Member>>);
  @override
  _i4.Stream<_i2.Either<_i5.Failure, _i6.Member>> getAuthChange() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAuthChange,
          [],
        ),
        returnValue: _i4.Stream<_i2.Either<_i5.Failure, _i6.Member>>.empty(),
      ) as _i4.Stream<_i2.Either<_i5.Failure, _i6.Member>>);
}
