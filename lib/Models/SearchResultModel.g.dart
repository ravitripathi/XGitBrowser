// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchResultModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SearchResultModel> _$searchResultModelSerializer =
    new _$SearchResultModelSerializer();

class _$SearchResultModelSerializer
    implements StructuredSerializer<SearchResultModel> {
  @override
  final Iterable<Type> types = const [SearchResultModel, _$SearchResultModel];
  @override
  final String wireName = 'SearchResultModel';

  @override
  Iterable<Object> serialize(Serializers serializers, SearchResultModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.total_count != null) {
      result
        ..add('total_count')
        ..add(serializers.serialize(object.total_count,
            specifiedType: const FullType(int)));
    }
    if (object.incomplete_results != null) {
      result
        ..add('incomplete_results')
        ..add(serializers.serialize(object.incomplete_results,
            specifiedType: const FullType(bool)));
    }
    if (object.items != null) {
      result
        ..add('items')
        ..add(serializers.serialize(object.items,
            specifiedType: const FullType(
                BuiltList, const [const FullType(RepoListModel)])));
    }
    return result;
  }

  @override
  SearchResultModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SearchResultModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'total_count':
          result.total_count = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'incomplete_results':
          result.incomplete_results = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'items':
          result.items.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(RepoListModel)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$SearchResultModel extends SearchResultModel {
  @override
  final int total_count;
  @override
  final bool incomplete_results;
  @override
  final BuiltList<RepoListModel> items;

  factory _$SearchResultModel(
          [void Function(SearchResultModelBuilder) updates]) =>
      (new SearchResultModelBuilder()..update(updates)).build();

  _$SearchResultModel._({this.total_count, this.incomplete_results, this.items})
      : super._();

  @override
  SearchResultModel rebuild(void Function(SearchResultModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SearchResultModelBuilder toBuilder() =>
      new SearchResultModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchResultModel &&
        total_count == other.total_count &&
        incomplete_results == other.incomplete_results &&
        items == other.items;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, total_count.hashCode), incomplete_results.hashCode),
        items.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SearchResultModel')
          ..add('total_count', total_count)
          ..add('incomplete_results', incomplete_results)
          ..add('items', items))
        .toString();
  }
}

class SearchResultModelBuilder
    implements Builder<SearchResultModel, SearchResultModelBuilder> {
  _$SearchResultModel _$v;

  int _total_count;
  int get total_count => _$this._total_count;
  set total_count(int total_count) => _$this._total_count = total_count;

  bool _incomplete_results;
  bool get incomplete_results => _$this._incomplete_results;
  set incomplete_results(bool incomplete_results) =>
      _$this._incomplete_results = incomplete_results;

  ListBuilder<RepoListModel> _items;
  ListBuilder<RepoListModel> get items =>
      _$this._items ??= new ListBuilder<RepoListModel>();
  set items(ListBuilder<RepoListModel> items) => _$this._items = items;

  SearchResultModelBuilder();

  SearchResultModelBuilder get _$this {
    if (_$v != null) {
      _total_count = _$v.total_count;
      _incomplete_results = _$v.incomplete_results;
      _items = _$v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchResultModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SearchResultModel;
  }

  @override
  void update(void Function(SearchResultModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SearchResultModel build() {
    _$SearchResultModel _$result;
    try {
      _$result = _$v ??
          new _$SearchResultModel._(
              total_count: total_count,
              incomplete_results: incomplete_results,
              items: _items?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SearchResultModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
