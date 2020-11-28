import 'dart:convert';

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cross_git_browser/serializers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Models/RepoListModel.dart';
import 'Models/SearchResultModel.dart';
import 'RepoList/RepoItemWidget.dart';
import 'Url.dart';

class AllRepoPage extends StatefulWidget {
  final String username;
  AllRepoPage(this.username);

  @override
  _AllRepoPageState createState() => _AllRepoPageState();
}

class _AllRepoPageState extends State<AllRepoPage> {
  ScrollController controller;
  List<RepoListModel> repoList = [];
  List<RepoListModel> tempList = [];
  bool loading = false;
  bool incrementalLoading = false;
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
      body: Stack(children: [
        Center(child: loading ? CircularProgressIndicator() : null),
        Container(
            child: loading
                ? null
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: gridWidget(),
                      ),
                      SafeArea(
                        bottom: true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: incrementalLoading
                                  ? CircularProgressIndicator()
                                  : null,
                            )
                          ],
                        ),
                      )
                    ],
                  )),
      ]),
    );
  }

  Widget gridWidget() {
    final bool isLargeScreen =
        (getWindowType(context) >= AdaptiveWindowType.medium);
    return StaggeredGridView.countBuilder(
        controller: controller,
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
        crossAxisSpacing: 4.0);
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
    controller = new ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    //Regarding extentAfter. It approaches zero as you reach the bottom of your list or grid
    //It zero at the last item(s)
    // print(controller.position.extentAfter);
    if (controller.position.extentAfter < 100) {
      //When the extent approaches 100, fetch other rows
      getRepos();
    }
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
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
      incrementalLoading = true;
    });
    String urlString =
        Url(this.widget.username).getRepos(page: page, perPage: 40);
    var res = await Network.getDataFor(urlString, context);
    var resBody = json.decode(res.body) as List;
    setState(() {
      var receivedValue = resBody
          .map((user) =>
              serializers.deserializeWith(RepoListModel.serializer, user))
          .toList();
      repoList.addAll(receivedValue);
      incrementalLoading = false;
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
    var res = await Network.getDataFor(urlString, context);
    var resBody = json.decode(res.body);
    tempList = repoList;
    var receivedValue =
        serializers.deserializeWith(SearchResultModel.serializer, resBody);
    if (receivedValue.items.length > 0) {
      repoList = [];
      setState(() {
        repoList.addAll(receivedValue.items);
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        animType: AnimType.SCALE,
        title: "No results",
        desc:
            "There seem to be no repos by this user matching your entered term",
      ).show();
    }
  }
}
