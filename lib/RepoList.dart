import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Url.dart';
import 'RepoListModel.dart';

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

        return SizedBox(
          // height: 100.0,
          child: Expanded(
            child: Card(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name),
                Text(item.description ?? "No Description"),
              ],
            )),
          ),
        );
      },
    ));
  }

  @override
  void initState() {
    super.initState();
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
