import 'package:cross_git_browser/Url.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Connector.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileHeader extends StatefulWidget {
  final String username;

  ProfileHeader(this.username);

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  var resBody;
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            width: 100,
            height: 100,
            child: loading ? Icon(Icons.account_circle) : null,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 4.0),
              boxShadow: [BoxShadow(blurRadius: 4.0)],
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              image: loading
                  ? null
                  : DecorationImage(
                      image: NetworkImage(resBody['avatar_url']),
                      fit: BoxFit.fill),
            ),
          ),
          // Expanded(
          //   child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loading ? 'Loading' : resBody['name'],
                style: GoogleFonts.roboto(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '@${this.widget.username}',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(color: Colors.blue),
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          // )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    String urlString = Url(this.widget.username).getURL();
    var res = await http.get(Uri.encodeFull(urlString),
        headers: {"Accept": "application/json"});
    setState(() {
      resBody = json.decode(res.body);
      print(res.body);
      loading = false;
    });

    // Connector().get()
  }
  // Future getUser(String y)
}
