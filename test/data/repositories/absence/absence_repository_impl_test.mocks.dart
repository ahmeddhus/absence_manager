// Mocks generated by Mockito 5.4.5 from annotations
// in absence_manager/test/data/repositories/absence/absence_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:absence_manager/core/network/network_checker.dart' as _i7;
import 'package:absence_manager/data/services/api/absence_remote_service.dart'
    as _i2;
import 'package:absence_manager/data/services/api/model/absence/absence_api_model.dart'
    as _i4;
import 'package:absence_manager/data/services/local/absence_local_service.dart'
    as _i5;
import 'package:absence_manager/data/services/local/model/absence/absence_cache_model.dart'
    as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [AbsenceRemoteService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAbsenceRemoteService extends _i1.Mock
    implements _i2.AbsenceRemoteService {
  MockAbsenceRemoteService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<(int, List<_i4.AbsenceApiModel>)> fetchAbsences({
    required int? page,
    required int? limit,
    String? type,
    String? from,
    String? to,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#fetchAbsences, [], {
              #page: page,
              #limit: limit,
              #type: type,
              #from: from,
              #to: to,
            }),
            returnValue: _i3.Future<(int, List<_i4.AbsenceApiModel>)>.value((
              0,
              <_i4.AbsenceApiModel>[],
            )),
          )
          as _i3.Future<(int, List<_i4.AbsenceApiModel>)>);
}

/// A class which mocks [AbsenceLocalService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAbsenceLocalService extends _i1.Mock
    implements _i5.AbsenceLocalService {
  MockAbsenceLocalService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> saveAbsences(List<_i6.AbsenceCacheModel>? absences) =>
      (super.noSuchMethod(
            Invocation.method(#saveAbsences, [absences]),
            returnValue: _i3.Future<void>.value(),
            returnValueForMissingStub: _i3.Future<void>.value(),
          )
          as _i3.Future<void>);

  @override
  _i3.Future<List<_i6.AbsenceCacheModel>> getCachedAbsences() =>
      (super.noSuchMethod(
            Invocation.method(#getCachedAbsences, []),
            returnValue: _i3.Future<List<_i6.AbsenceCacheModel>>.value(
              <_i6.AbsenceCacheModel>[],
            ),
          )
          as _i3.Future<List<_i6.AbsenceCacheModel>>);
}

/// A class which mocks [NetworkChecker].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkChecker extends _i1.Mock implements _i7.NetworkChecker {
  MockNetworkChecker() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get testUrl =>
      (super.noSuchMethod(
            Invocation.getter(#testUrl),
            returnValue: _i8.dummyValue<String>(
              this,
              Invocation.getter(#testUrl),
            ),
          )
          as String);

  @override
  _i3.Future<bool> get hasConnection =>
      (super.noSuchMethod(
            Invocation.getter(#hasConnection),
            returnValue: _i3.Future<bool>.value(false),
          )
          as _i3.Future<bool>);
}
