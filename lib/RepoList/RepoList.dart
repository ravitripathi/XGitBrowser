import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Url.dart';
import 'RepoListModel.dart';
import 'package:webview_flutter/webview_flutter.dart';
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
    return Container(
        child: ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: repoList.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = repoList[index];

        return GestureDetector(
            onTap: () {
              openLink(item.html_url);
            },
            child: RepoItemWidget(item: item));
      },
    ));
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
    String urlString = Url(this.widget.username).getRepos();
    var res = await http.get(Uri.encodeFull(urlString),
        headers: {"Accept": "application/json"});
    setState(() {
      var resBody = json.decode(res.body) as List;
      repoList = resBody.map((user) => RepoListModel.fromJson(user)).toList();
      print(res.body);
      loading = false;
    });
  }
}
