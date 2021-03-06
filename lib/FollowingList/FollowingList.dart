import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Url.dart';
import 'FollowingItemWidget.dart';
import 'FollowingListModel.dart';

class FollowingList extends StatefulWidget {
  final String username;
  final Function(String) notifyParent;
  final String selectedUsername;
  FollowingList(this.username, this.notifyParent, this.selectedUsername);

  @override
  _FollowingListState createState() => _FollowingListState();
}

class _FollowingListState extends State<FollowingList> {
  List<FollowingListModel> followingList = [];
  bool loading = false;
  FollowingListModel selectedItem;
  String passedUsername;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: loading ? CircularProgressIndicator() : null),
      Container(
          child: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: followingList.length,
        scrollDirection: Axis.horizontal,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final item = followingList[index];

          return GestureDetector(
            child: FollowingItemWidget(
              item: item,
              isSelected: (item == selectedItem),
            ),
            onTap: () {
              setState(() {
                this.selectedItem = item;
                widget.notifyParent(item.login);
              });
            },
          );
        },
      )),
    ]);
  }

  @override
  void didUpdateWidget(covariant FollowingList oldWidget) {
    passedUsername = widget.selectedUsername;
    super.didUpdateWidget(oldWidget);
    getUsername().then((value) => {
          if (value == passedUsername)
            {
              setState(() {
                this.selectedItem = null;
              })
            }
        });
  }

  @override
  void initState() {
    super.initState();
    getFollowing();
    passedUsername = widget.selectedUsername;
  }

  void getFollowing() async {
    loading = true;
    String urlString = Url(this.widget.username).getFollowing();
    var res = await Network.getDataFor(urlString, context);
    if (res.statusCode == 200) {
      setState(() {
        var resBody = json.decode(res.body) as List;
        followingList =
            resBody.map((user) => FollowingListModel.fromJson(user)).toList();
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }
}
