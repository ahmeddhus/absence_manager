// Mocks generated by Mockito 5.4.5 from annotations
// in absence_manager/test/data/repositories/member/member_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:absence_manager/core/network/network_checker.dart' as _i7;
import 'package:absence_manager/data/services/api/member_remote_service.dart'
    as _i2;
import 'package:absence_manager/data/services/api/model/member/member_api_model.dart'
    as _i4;
import 'package:absence_manager/data/services/local/member_local_service.dart'
    as _i5;
import 'package:absence_manager/data/services/local/model/member/member_cache_model.dart'
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

/// A class which mocks [MemberRemoteService].
///
/// See the documentation for Mockito's code generation for more information.
class MockMemberRemoteService extends _i1.Mock
    implements _i2.MemberRemoteService {
  MockMemberRemoteService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.MemberApiModel>> fetchMembers() =>
      (super.noSuchMethod(
            Invocation.method(#fetchMembers, []),
            returnValue: _i3.Future<List<_i4.MemberApiModel>>.value(
              <_i4.MemberApiModel>[],
            ),
          )
          as _i3.Future<List<_i4.MemberApiModel>>);
}

/// A class which mocks [MemberLocalService].
///
/// See the documentation for Mockito's code generation for more information.
class MockMemberLocalService extends _i1.Mock
    implements _i5.MemberLocalService {
  MockMemberLocalService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> saveMembers(List<_i6.MemberCacheModel>? members) =>
      (super.noSuchMethod(
            Invocation.method(#saveMembers, [members]),
            returnValue: _i3.Future<void>.value(),
            returnValueForMissingStub: _i3.Future<void>.value(),
          )
          as _i3.Future<void>);

  @override
  _i3.Future<List<_i6.MemberCacheModel>> getCachedMembers() =>
      (super.noSuchMethod(
            Invocation.method(#getCachedMembers, []),
            returnValue: _i3.Future<List<_i6.MemberCacheModel>>.value(
              <_i6.MemberCacheModel>[],
            ),
          )
          as _i3.Future<List<_i6.MemberCacheModel>>);
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
