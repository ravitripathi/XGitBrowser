// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RepoListModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<RepoListModel> _$repoListModelSerializer =
    new _$RepoListModelSerializer();

class _$RepoListModelSerializer implements StructuredSerializer<RepoListModel> {
  @override
  final Iterable<Type> types = const [RepoListModel, _$RepoListModel];
  @override
  final String wireName = 'RepoListModel';

  @override
  Iterable<Object> serialize(Serializers serializers, RepoListModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.html_url != null) {
      result
        ..add('html_url')
        ..add(serializers.serialize(object.html_url,
            specifiedType: const FullType(String)));
    }
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.fork != null) {
      result
        ..add('fork')
        ..add(serializers.serialize(object.fork,
            specifiedType: const FullType(bool)));
    }
    if (object.language != null) {
      result
        ..add('language')
        ..add(serializers.serialize(object.language,
            specifiedType: const FullType(String)));
    }
    if (object.watchers != null) {
      result
        ..add('watchers')
        ..add(serializers.serialize(object.watchers,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  RepoListModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RepoListModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'html_url':
          result.html_url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'fork':
          result.fork = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'language':
          result.language = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'watchers':
          result.watchers = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$RepoListModel extends RepoListModel {
  @override
  final int id;
  @override
  final String name;
  @override
  final String html_url;
  @override
  final String description;
  @override
  final bool fork;
  @override
  final String language;
  @override
  final int watchers;

  factory _$RepoListModel([void Function(RepoListModelBuilder) updates]) =>
      (new RepoListModelBuilder()..update(updates)).build();

  _$RepoListModel._(
      {this.id,
      this.name,
      this.html_url,
      this.description,
      this.fork,
      this.language,
      this.watchers})
      : super._();

  @override
  RepoListModel rebuild(void Function(RepoListModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RepoListModelBuilder toBuilder() => new RepoListModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RepoListModel &&
        id == other.id &&
        name == other.name &&
        html_url == other.html_url &&
        description == other.description &&
        fork == other.fork &&
        language == other.language &&
        watchers == other.watchers;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, id.hashCode), name.hashCode),
                        html_url.hashCode),
                    description.hashCode),
                fork.hashCode),
            language.hashCode),
        watchers.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RepoListModel')
          ..add('id', id)
          ..add('name', name)
          ..add('html_url', html_url)
          ..add('description', description)
          ..add('fork', fork)
          ..add('language', language)
          ..add('watchers', watchers))
        .toString();
  }
}

class RepoListModelBuilder
    implements Builder<RepoListModel, RepoListModelBuilder> {
  _$RepoListModel _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _html_url;
  String get html_url => _$this._html_url;
  set html_url(String html_url) => _$this._html_url = html_url;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  bool _fork;
  bool get fork => _$this._fork;
  set fork(bool fork) => _$this._fork = fork;

  String _language;
  String get language => _$this._language;
  set language(String language) => _$this._language = language;

  int _watchers;
  int get watchers => _$this._watchers;
  set watchers(int watchers) => _$this._watchers = watchers;

  RepoListModelBuilder();

  RepoListModelBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _html_url = _$v.html_url;
      _description = _$v.description;
      _fork = _$v.fork;
      _language = _$v.language;
      _watchers = _$v.watchers;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RepoListModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$RepoListModel;
  }

  @override
  void update(void Function(RepoListModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RepoListModel build() {
    final _$result = _$v ??
        new _$RepoListModel._(
            id: id,
            name: name,
            html_url: html_url,
            description: description,
            fork: fork,
            language: language,
            watchers: watchers);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
