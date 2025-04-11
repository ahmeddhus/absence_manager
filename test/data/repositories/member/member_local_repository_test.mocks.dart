// Mocks generated by Mockito 5.4.5 from annotations
// in absence_manager/test/data/repositories/member/member_local_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:absence_manager/data/services/api/model/member/member_api_model.dart'
    as _i5;
import 'package:absence_manager/data/services/local/local_json_loader.dart'
    as _i2;
import 'package:absence_manager/data/services/local/local_member_service.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeLocalJsonLoader_0 extends _i1.SmartFake
    implements _i2.LocalJsonLoader {
  _FakeLocalJsonLoader_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [LocalMemberService].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalMemberService extends _i1.Mock
    implements _i3.LocalMemberService {
  MockLocalMemberService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.LocalJsonLoader get loader =>
      (super.noSuchMethod(
            Invocation.getter(#loader),
            returnValue: _FakeLocalJsonLoader_0(
              this,
              Invocation.getter(#loader),
            ),
          )
          as _i2.LocalJsonLoader);

  @override
  _i4.Future<List<_i5.MemberApiModel>> fetchMembers() =>
      (super.noSuchMethod(
            Invocation.method(#fetchMembers, []),
            returnValue: _i4.Future<List<_i5.MemberApiModel>>.value(
              <_i5.MemberApiModel>[],
            ),
          )
          as _i4.Future<List<_i5.MemberApiModel>>);
}
