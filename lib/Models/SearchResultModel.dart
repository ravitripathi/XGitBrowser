import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:cross_git_browser/Models/RepoListModel.dart';
import 'package:cross_git_browser/RepoList/RepoList.dart';

part 'SearchResultModel.g.dart';

abstract class SearchResultModel
    implements Built<SearchResultModel, SearchResultModelBuilder> {
  static Serializer<SearchResultModel> get serializer =>
      _$searchResultModelSerializer;

  @nullable
  int get total_count;

  @nullable
  bool get incomplete_results;

  @nullable
  BuiltList<RepoListModel> get items;

  SearchResultModel._();

  factory SearchResultModel([void Function(SearchResultModelBuilder) updates]) =
      _$SearchResultModel;
}
