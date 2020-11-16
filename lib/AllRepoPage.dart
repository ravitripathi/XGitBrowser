import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'Models/RepoListModel.dart';
import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Url.dart';
import 'package:cross_git_browser/serializers.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'RepoList/RepoItemWidget.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'Models/SearchResultModel.dart';

class AllRepoPage extends StatefulWidget {
  final String username;
  AllRepoPage(this.username);

  @override
  _AllRepoPageState createState() => _AllRepoPageState();
}

class _AllRepoPageState extends State<AllRepoPage> {
  List<RepoListModel> repoList = [];
  List<RepoListModel> tempList = [];
  bool loading = false;
  SearchBar searchBar;
  int page = 0;

  AppBar buildAppBar(BuildContext context) {
    final user = widget.username;
    return new AppBar(
        title: new Text("$user's repos"),
        actions: [searchBar.getSearchAction(context)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      body: gridWidget(),
    );
  }

  Widget gridWidget() {
    final bool isLargeScreen =
        (getWindowType(context) >= AdaptiveWindowType.medium);
    return Stack(children: [
      Center(child: loading ? CircularProgressIndicator() : null),
      Container(
        child: loading
            ? null
            : StaggeredGridView.countBuilder(
                itemCount: repoList.length,
                crossAxisCount: isLargeScreen ? 4 : 2,
                itemBuilder: (BuildContext context, int index) {
                  final item = repoList[index];
                  return GestureDetector(
                    onTap: () {
                      openLink(item.html_url);
                    },
                    child: RepoItemWidget(item: item),
                  );
                },
                staggeredTileBuilder: (int index) {
                  return StaggeredTile.fit(1);
                },
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0),
      ),
    ]);
  }

  void openLink(String urlString) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("XGitBrowser"),
          ),
          body: SafeArea(
            child: WebView(
              initialUrl: urlString,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    repoList = [];
    getRepos();
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: (value) => searchForRepo(value),
        buildDefaultAppBar: buildAppBar);
  }

  @override
  void didUpdateWidget(covariant AllRepoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    repoList = [];
    getRepos();
  }

  void getRepos() async {
    page++;
    setState(() {
      loading = true;
    });
    String urlString = Url(this.widget.username).getRepos();
    urlString = urlString + "?page=$page";
    var res = await http.get(Uri.encodeFull(urlString),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body) as List;
    setState(() {
      var receivedValue = resBody
          .map((user) =>
              serializers.deserializeWith(RepoListModel.serializer, user))
          .toList();
      repoList.addAll(receivedValue);
      loading = false;
    });
  }

  void searchForRepo(String name) async {
    if (loading || name.isEmpty) {
      setState(() {
        repoList = tempList;
        tempList = [];
      });
      return;
    }
    if (name.length <= 2) {
      return;
    }
    setState(() {
      loading = true;
    });
    String urlString = Url(this.widget.username).searchForRepo(name);
    var res = await http.get(Uri.encodeFull(urlString),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    print(res.body);
    tempList = repoList;
    repoList = [];
    setState(() {
      var receivedValue =
          serializers.deserializeWith(SearchResultModel.serializer, resBody);
      print("Printing values: ");
      print(receivedValue.items);
      repoList.addAll(receivedValue.items);
      loading = false;
    });
  }
}
