import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cross_git_browser/Models/RepoListModel.dart';

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
  List<RepoListModel> get items;

  SearchResultModel._();

  factory SearchResultModel([void Function(SearchResultModelBuilder) updates]) =
      _$SearchResultModel;
}
