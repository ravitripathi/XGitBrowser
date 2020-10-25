import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Url.dart';
import 'RepoListModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

class RepoItemWidget extends StatelessWidget {
  const RepoItemWidget({
    Key key,
    @required this.item,
  }) : super(key: key);

  final RepoListModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
                shadowColor: Colors.black87,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name,
                          style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(item.description ?? "No Description"),
                      Text("Language: ${item.language}"),
                    ],
                  ),
                )),
          ),
        )
      ],
    );
  }
}
