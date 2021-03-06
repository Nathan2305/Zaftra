// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.
// @dart = 2.12

import 'dart:core';
import 'package:RestaurantAdmin/DAO/Dishes.dart' as prefix1;
import 'package:backendless_sdk/backendless_sdk.dart' as prefix0;

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
            r'Dishes',
            r'.Dishes',
            7,
            0,
            const prefix0.Reflector(),
            const <int>[0, 1, 2, 3, 12, 13, 14, 15, 16, 17, 18, 19, 20],
            const <int>[
              21,
              22,
              23,
              24,
              25,
              4,
              5,
              6,
              7,
              8,
              9,
              10,
              11,
              12,
              13,
              14,
              15,
              16,
              17,
              18,
              19
            ],
            const <int>[],
            -1,
            {},
            {},
            {r'': (bool b) => () => b ? prefix1.Dishes() : null},
            -1,
            -1,
            const <int>[-1],
            const <Object>[prefix0.reflector],
            null)
      ],
      <m.DeclarationMirror>[
        r.VariableMirrorImpl(r'category', 32773, 0, const prefix0.Reflector(),
            -1, 1, 1, null, const []),
        r.VariableMirrorImpl(r'name', 32773, 0, const prefix0.Reflector(), -1,
            1, 1, null, const []),
        r.VariableMirrorImpl(r'price', 32773, 0, const prefix0.Reflector(), -1,
            2, 2, null, const []),
        r.VariableMirrorImpl(r'description', 32773, 0,
            const prefix0.Reflector(), -1, 1, 1, null, const []),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 0, 4),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 0, 5),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 1, 6),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 1, 7),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 2, 8),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 2, 9),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 3, 10),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 3, 11),
        r.MethodMirrorImpl(r'getCategory', 131075, 0, -1, 1, 1, null,
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'getName', 131075, 0, -1, 1, 1, null, const <int>[],
            const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'getPrice', 131075, 0, -1, 2, 2, null,
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'getDescription', 131075, 0, -1, 1, 1, null,
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'setDescription=', 262148, 0, -1, 3, 3, null,
            const <int>[4], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'setCategory=', 262148, 0, -1, 3, 3, null,
            const <int>[5], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'setName=', 262148, 0, -1, 3, 3, null,
            const <int>[6], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'setPrice=', 262148, 0, -1, 3, 3, null,
            const <int>[7], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'', 64, 0, -1, 0, 0, null, const <int>[],
            const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'==', 131074, -1, -1, 4, 4, null, const <int>[8],
            const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'toString', 131074, -1, -1, 1, 1, null,
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'noSuchMethod', 65538, -1, -1, -1, -1, null,
            const <int>[9], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'hashCode', 131075, -1, -1, 5, 5, null,
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'runtimeType', 131075, -1, -1, 6, 6, null,
            const <int>[], const prefix0.Reflector(), const [])
      ],
      <m.ParameterMirror>[
        r.ParameterMirrorImpl(r'_category', 32870, 5, const prefix0.Reflector(),
            -1, 1, 1, null, const [], null, null),
        r.ParameterMirrorImpl(r'_name', 32870, 7, const prefix0.Reflector(), -1,
            1, 1, null, const [], null, null),
        r.ParameterMirrorImpl(r'_price', 32870, 9, const prefix0.Reflector(),
            -1, 2, 2, null, const [], null, null),
        r.ParameterMirrorImpl(r'_description', 32870, 11,
            const prefix0.Reflector(), -1, 1, 1, null, const [], null, null),
        r.ParameterMirrorImpl(r'newDescription', 32774, 16,
            const prefix0.Reflector(), -1, 1, 1, null, const [], null, null),
        r.ParameterMirrorImpl(r'newCategory', 32774, 17,
            const prefix0.Reflector(), -1, 1, 1, null, const [], null, null),
        r.ParameterMirrorImpl(r'newName', 32774, 18, const prefix0.Reflector(),
            -1, 1, 1, null, const [], null, null),
        r.ParameterMirrorImpl(r'newPrice', 32774, 19, const prefix0.Reflector(),
            -1, 2, 2, null, const [], null, null),
        r.ParameterMirrorImpl(r'other', 32774, 21, const prefix0.Reflector(),
            -1, 7, 7, null, const [], null, null),
        r.ParameterMirrorImpl(r'invocation', 32774, 23,
            const prefix0.Reflector(), -1, 8, 8, null, const [], null, null)
      ],
      <Type>[
        prefix1.Dishes,
        String,
        double,
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
        r'category': (dynamic instance) => instance.category,
        r'name': (dynamic instance) => instance.name,
        r'price': (dynamic instance) => instance.price,
        r'description': (dynamic instance) => instance.description,
        r'getCategory': (dynamic instance) => instance.getCategory,
        r'getName': (dynamic instance) => instance.getName,
        r'getPrice': (dynamic instance) => instance.getPrice,
        r'getDescription': (dynamic instance) => instance.getDescription
      },
      {
        r'category=': (dynamic instance, value) => instance.category = value,
        r'name=': (dynamic instance, value) => instance.name = value,
        r'price=': (dynamic instance, value) => instance.price = value,
        r'description=': (dynamic instance, value) =>
            instance.description = value,
        r'setDescription=': (dynamic instance, value) =>
            instance.setDescription = value,
        r'setCategory=': (dynamic instance, value) =>
            instance.setCategory = value,
        r'setName=': (dynamic instance, value) => instance.setName = value,
        r'setPrice=': (dynamic instance, value) => instance.setPrice = value
      },
      null,
      [])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}
