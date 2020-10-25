import 'package:cross_git_browser/FollowingListModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Url.dart';

class FollowingList extends StatefulWidget {
  final String username;
  FollowingList(this.username);

  @override
  _FollowingListState createState() => _FollowingListState();
}

class _FollowingListState extends State<FollowingList> {
  List<FollowingListModel> followingList = [];
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: followingList.length,
      scrollDirection: Axis.horizontal,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = followingList[index];

        return FollowingListItem(item: item);
      },
    ));
  }

  @override
  void initState() {
    super.initState();
    getFollowers();
  }

  void getFollowers() async {
    String urlString = Url(this.widget.username).getFollowing();
    var res = await http.get(Uri.encodeFull(urlString),
        headers: {"Accept": "application/json"});
    setState(() {
      var resBody = json.decode(res.body) as List;
      followingList =
          resBody.map((user) => FollowingListModel.fromJson(user)).toList();
      print(res.body);
      loading = false;
    });

    // Connector().get()
  }
}

class FollowingListItem extends StatelessWidget {
  const FollowingListItem({
    Key key,
    @required this.item,
  }) : super(key: key);

  final FollowingListModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 150.0,
        height: 150.0,
        child: Card(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 4.0),
                  boxShadow: [BoxShadow(blurRadius: 4.0)],
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  image: DecorationImage(
                      image: NetworkImage(item.avatar_url), fit: BoxFit.fill),
                ),
              ),
              Text(item.login),
            ],
          ),
        ),
      ),
    );
  }
}
