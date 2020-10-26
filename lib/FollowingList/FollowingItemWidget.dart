import 'package:flutter/material.dart';
import 'FollowingListModel.dart';

class FollowingItemWidget extends StatelessWidget {
  final FollowingListModel item;
  final bool isSelected;
  FollowingItemWidget({this.item, this.isSelected});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      height: 150.0,
      child: Card(
        color: isSelected ? Colors.blue : Colors.white,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4.0),
                boxShadow: [
                  isSelected
                      ? BoxShadow(blurRadius: 0.0)
                      : BoxShadow(blurRadius: 4.0)
                ],
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                image: DecorationImage(
                    image: NetworkImage(item.avatar_url), fit: BoxFit.fill),
              ),
            ),
            Text(
              item.login,
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
