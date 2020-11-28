import 'dart:convert';

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:cross_git_browser/serializers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Models/RepoListModel.dart';
import '../Url.dart';
import 'RepoItemWidget.dart';

class RepoList extends StatefulWidget {
  final String username;
  RepoList(this.username);

  @override
  _RepoListState createState() => _RepoListState();
}

class _RepoListState extends State<RepoList> {
  List<RepoListModel> repoList = [];
  bool loading = false;

  @override
  Widget build(BuildContext context) {
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
  }

  @override
  void didUpdateWidget(covariant RepoList oldWidget) {
    super.didUpdateWidget(oldWidget);
    repoList = [];
    getRepos();
  }

  void getRepos() async {
    setState(() {
      loading = true;
    });
    String urlString = Url(this.widget.username).getRepos();
    var res = await Network.getDataFor(urlString, context);
    if (res.statusCode == 200) {
      var resBody = json.decode(res.body) as List;
      var deserializedResp = resBody
          .map((user) =>
              serializers.deserializeWith(RepoListModel.serializer, user))
          .toList();
      setState(() {
        if (deserializedResp.length > 0) {
          repoList = deserializedResp;
        }
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }
}
