class RepoListModel {
  int id;
  String name;
  String html_url;
  String description;
  bool fork;
  String language;
  int watchers;

  RepoListModel(this.id, this.name, this.html_url, this.description, this.fork,
      this.language, this.watchers);

  factory RepoListModel.fromJson(dynamic json) {
    return RepoListModel(
        json['id'] as int,
        json['name'] as String,
        json['html_url'] as String,
        json['description'] as String,
        json['fork'] as bool,
        json['language'] as String,
        json['watchers'] as int);
  }
}
