import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Models/RepoListModel.dart';

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
                elevation: 7.0,
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
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(item.description ?? "No Description"),
                      SizedBox(
                        height: 4.0,
                      ),
                      (item.language != null)
                          ? Text("Language: ${item.language}")
                          : Container(),
                    ],
                  ),
                )),
          ),
        )
      ],
    );
  }
}
