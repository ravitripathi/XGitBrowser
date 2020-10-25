class FollowingListModel {
  String login;
  int id;
  String avatar_url;
  String html_url;
  String followers_url;
  String following_url;
  String repos_url;

  FollowingListModel(this.login, this.id, this.avatar_url, this.html_url,
      this.followers_url, this.following_url, this.repos_url);

  factory FollowingListModel.fromJson(dynamic json) {
    return FollowingListModel(
        json['login'] as String,
        json['id'] as int,
        json['avatar_url'] as String,
        json['html_url'] as String,
        json['followers_url'] as String,
        json['following_url'] as String,
        json['repos_url'] as String);
  }
  //
  // @override
  // String toString() {
  //   return '{ ${this.name}, ${this.age} }';
  // }
}
