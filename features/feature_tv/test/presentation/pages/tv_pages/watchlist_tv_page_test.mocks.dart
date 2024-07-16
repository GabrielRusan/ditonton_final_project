// Mocks generated by Mockito 5.4.4 from annotations
// in feature_tv/test/presentation/pages/tv_pages/watchlist_tv_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:ui' as _i8;

import 'package:core/core.dart' as _i5;
import 'package:feature_tv/domain/entities/tv.dart' as _i4;
import 'package:feature_tv/domain/usecases/get_watchlist_tvs.dart' as _i2;
import 'package:feature_tv/presentation/provider/watchlist_tv_notifier.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetWatchlistTvs_0 extends _i1.SmartFake
    implements _i2.GetWatchlistTvs {
  _FakeGetWatchlistTvs_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WatchlistTvNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistTvNotifier extends _i1.Mock
    implements _i3.WatchlistTvNotifier {
  MockWatchlistTvNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetWatchlistTvs get getWatchlistTvs => (super.noSuchMethod(
        Invocation.getter(#getWatchlistTvs),
        returnValue: _FakeGetWatchlistTvs_0(
          this,
          Invocation.getter(#getWatchlistTvs),
        ),
      ) as _i2.GetWatchlistTvs);

  @override
  List<_i4.Tv> get watchlistTvs => (super.noSuchMethod(
        Invocation.getter(#watchlistTvs),
        returnValue: <_i4.Tv>[],
      ) as List<_i4.Tv>);

  @override
  _i5.RequestState get watchlistState => (super.noSuchMethod(
        Invocation.getter(#watchlistState),
        returnValue: _i5.RequestState.Empty,
      ) as _i5.RequestState);

  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: _i6.dummyValue<String>(
          this,
          Invocation.getter(#message),
        ),
      ) as String);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  _i7.Future<void> fetchWatchlistTvs() => (super.noSuchMethod(
        Invocation.method(
          #fetchWatchlistTvs,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  void addListener(_i8.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i8.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}