// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.
// @dart = 2.12

import 'dart:core';
import 'package:backendless_sdk/backendless_sdk.dart' as prefix0;
import 'package:test_login/DAO/Personal.dart' as prefix1;

// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const
// ignore_for_file: implementation_imports

// ignore:unused_import
import 'package:reflectable/mirrors.dart' as m;
// ignore:unused_import
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
// ignore:unused_import
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.Reflector(): r.ReflectorData(
      <m.TypeMirror>[
        r.NonGenericClassMirrorImpl(
            r'Personal',
            r'.Personal',
            7,
            0,
            const prefix0.Reflector(),
            const <int>[0, 1, 2, 9, 10, 11, 12, 13, 14],
            const <int>[
              15,
              16,
              17,
              18,
              19,
              3,
              4,
              5,
              6,
              7,
              8,
              9,
              10,
              11,
              12,
              13
            ],
            const <int>[],
            -1,
            {},
            {},
            {
              r'': (bool b) => (objectId, name, lastName) =>
                  b ? prefix1.Personal(objectId, name, lastName) : null
            },
            -1,
            -1,
            const <int>[-1],
            const <Object>[prefix0.reflector],
            null)
      ],
      <m.DeclarationMirror>[
        r.VariableMirrorImpl(r'objectId', 32773, 0, const prefix0.Reflector(),
            -1, 1, 1, null, const []),
        r.VariableMirrorImpl(r'name', 32773, 0, const prefix0.Reflector(), -1,
            1, 1, null, const []),
        r.VariableMirrorImpl(r'lastName', 32773, 0, const prefix0.Reflector(),
            -1, 1, 1, null, const []),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 0, 3),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 0, 4),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 1, 5),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 1, 6),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 2, 7),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 2, 8),
        r.MethodMirrorImpl(r'namePersonal', 131075, 0, -1, 1, 1, null,
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'objectIdPersonal', 131075, 0, -1, 1, 1, null,
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'lastNamePersonal', 131075, 0, -1, 1, 1, null,
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'setName=', 262148, 0, -1, 2, 2, null,
            const <int>[6], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'setLastName=', 262148, 0, -1, 2, 2, null,
            const <int>[7], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'', 0, 0, -1, 0, 0, null, const <int>[0, 1, 2],
            const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'==', 131074, -1, -1, 3, 3, null, const <int>[8],
            const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'toString', 131074, -1, -1, 1, 1, null,
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'noSuchMethod', 65538, -1, -1, -1, -1, null,
            const <int>[9], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'hashCode', 131075, -1, -1, 4, 4, null,
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'runtimeType', 131075, -1, -1, 5, 5, null,
            const <int>[], const prefix0.Reflector(), const [])
      ],
      <m.ParameterMirror>[
        r.ParameterMirrorImpl(r'objectId', 33798, 14, const prefix0.Reflector(),
            -1, 1, 1, null, const [], null, null),
        r.ParameterMirrorImpl(r'name', 33798, 14, const prefix0.Reflector(), -1,
            1, 1, null, const [], null, null),
        r.ParameterMirrorImpl(r'lastName', 33798, 14, const prefix0.Reflector(),
            -1, 1, 1, null, const [], null, null),
        r.ParameterMirrorImpl(r'_objectId', 32870, 4, const prefix0.Reflector(),
            -1, 1, 1, null, const [], null, null),
        r.ParameterMirrorImpl(r'_name', 32870, 6, const prefix0.Reflector(), -1,
            1, 1, null, const [], null, null),
        r.ParameterMirrorImpl(r'_lastName', 32870, 8, const prefix0.Reflector(),
            -1, 1, 1, null, const [], null, null),
        r.ParameterMirrorImpl(r'newName', 32774, 12, const prefix0.Reflector(),
            -1, 1, 1, null, const [], null, null),
        r.ParameterMirrorImpl(r'newLastName', 32774, 13,
            const prefix0.Reflector(), -1, 1, 1, null, const [], null, null),
        r.ParameterMirrorImpl(r'other', 32774, 15, const prefix0.Reflector(),
            -1, 6, 6, null, const [], null, null),
        r.ParameterMirrorImpl(r'invocation', 32774, 17,
            const prefix0.Reflector(), -1, 7, 7, null, const [], null, null)
      ],
      <Type>[
        prefix1.Personal,
        String,
        const m.TypeValue<void>().type,
        bool,
        int,
        Type,
        Object,
        Invocation
      ],
      1,
      {
        r'==': (dynamic instance) => (x) => instance == x,
        r'toString': (dynamic instance) => instance.toString,
        r'noSuchMethod': (dynamic instance) => instance.noSuchMethod,
        r'hashCode': (dynamic instance) => instance.hashCode,
        r'runtimeType': (dynamic instance) => instance.runtimeType,
        r'objectId': (dynamic instance) => instance.objectId,
        r'name': (dynamic instance) => instance.name,
        r'lastName': (dynamic instance) => instance.lastName,
        r'namePersonal': (dynamic instance) => instance.namePersonal,
        r'objectIdPersonal': (dynamic instance) => instance.objectIdPersonal,
        r'lastNamePersonal': (dynamic instance) => instance.lastNamePersonal
      },
      {
        r'objectId=': (dynamic instance, value) => instance.objectId = value,
        r'name=': (dynamic instance, value) => instance.name = value,
        r'lastName=': (dynamic instance, value) => instance.lastName = value,
        r'setName=': (dynamic instance, value) => instance.setName = value,
        r'setLastName=': (dynamic instance, value) =>
            instance.setLastName = value
      },
      null,
      [])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}
