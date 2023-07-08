// Mocks generated by Mockito 5.4.1 from annotations
// in cist_keion_app/test/feature/suggestion/domain/usecases/get_suggestions_test.dart.
// Do not manually edit this file.

// @dart=2.19

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:cist_keion_app/core/error/failure/failure.dart' as _i5;
import 'package:cist_keion_app/feature/suggestion/domain/entities/suggestion.dart'
    as _i6;
import 'package:cist_keion_app/feature/suggestion/domain/repositories/suggestion_repository.dart'
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

/// A class which mocks [SuggestionRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSuggestionRepository extends _i1.Mock
    implements _i3.SuggestionRepository {
  MockSuggestionRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>> add(
          _i6.Suggestion? suggestion) =>
      (super.noSuchMethod(
        Invocation.method(
          #add,
          [suggestion],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>.value(
            _FakeEither_0<_i5.Failure, _i2.Unit>(
          this,
          Invocation.method(
            #add,
            [suggestion],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Suggestion>>> getAll() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i6.Suggestion>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.Suggestion>>(
          this,
          Invocation.method(
            #getAll,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Suggestion>>>);
}
