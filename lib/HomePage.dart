import 'package:cross_git_browser/FollowingList/FollowingList.dart';
import 'package:cross_git_browser/RepoList/RepoList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ProfileHeader.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final String username;

  HomePage({this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedUsername;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("XGitBrowser"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: ProfileHeader(widget.username),
                onTap: () {
                  setState(() {
                    selectedUsername = widget.username;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Following',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ),
              SizedBox(
                child: FollowingList(
                    widget.username, updateRepoList, selectedUsername),
                height: 150.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Repos',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ),
              Flexible(child: RepoList(selectedUsername)),
            ],
          ),
        ));
  }

  void updateRepoList(String childValue) {
    setState(() {
      this.selectedUsername = childValue;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedUsername = widget.username;
  }

  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }
}
