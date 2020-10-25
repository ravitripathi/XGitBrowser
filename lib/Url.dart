class Url {
  final String end_point = "https://api.github.com/users/";
  final String username;
  Url(this.username);

  String getURL() {
    return end_point + username;
  }

  String getGistURL() {
    return getURL() + "/gists";
  }

  String getStarredURL() {
    return getURL() + "/starred";
  }

  String getFollowing() {
    return getURL() + "/following";
  }

  String getRepos() {
    return getURL() + "/repos";
  }
}
