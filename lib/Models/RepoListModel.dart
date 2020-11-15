import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'RepoListModel.g.dart';

abstract class RepoListModel
    implements Built<RepoListModel, RepoListModelBuilder> {
  static Serializer<RepoListModel> get serializer => _$repoListModelSerializer;

  @nullable
  int get id;

  @nullable
  String get name;

  @nullable
  String get html_url;

  @nullable
  String get description;

  @nullable
  bool get fork;

  @nullable
  String get language;

  @nullable
  int get watchers;

  RepoListModel._();

  factory RepoListModel([void Function(RepoListModelBuilder) updates]) =
      _$RepoListModel;
}
