import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Network {
  static Future<Response> getDataFor(
      String urlString, BuildContext context) async {
    var res = await http.get(Uri.encodeFull(urlString),
        headers: {"Accept": "application/json"});
    if (res.statusCode != 200) {
      showError(context, res.body);
      return Response("", 500);
    } else {
      return res;
    }
  }

  static void showError(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.SCALE,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Whoops!',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
          SizedBox(
            height: 100.0,
            child: SingleChildScrollView(
              child: Text(
                  "hfkjfkdshkhdskjfjkdsfkjshfkjsdhjkfsdkjfhksdfsdsdljflsfld  dkl  j lfj  jl ldkjf ldksj flkdsj ldsl dsl dl lds lds ldj lkdj kldj kldsj lksd lkdsj lkdsj lsdj ldksj klsj ldks lkds lkdj kldj lkdsj lsdkj lksj ldksj lds jldskj lksdj lskj lkjslk jdsdfsfsffffffffffffffffffffffffffffffffffff  dfsfdsf j fdlsk jdlsk ljfldsj ldsj lds jld jls jlsdj flsdj l sdjlf dslj lsdjlf djsl ls              ldsjf lsdllsk jlskj l jlsdk jlsd jdsflsdflsdjlfjlksdjflsdjlfjsdlfjlksdjflsdjflsdjlfjds"),
            ),
          ),
        ],
      ),
      // title: "Whoops!",
      // desc: res.body,
      btnOkOnPress: () {},
    ).show();
  }
}

class Url {
  final String end_point = "https://api.github.com/users/";
  final String username;
  Url(this.username);

  String getURL() {
    return end_point + username;
  }

  String getGistURL() {
    return getURL() + "/gists";
  }

  String getStarredURL() {
    return getURL() + "/starred";
  }

  String getFollowing() {
    return getURL() + "/following";
  }

  String getRepos({int page = 1, int perPage = 10}) {
    return getURL() + "/repos?page=$page&per_page=$perPage";
  }

  String searchForRepo(String repoName) {
    return "https://api.github.com/search/repositories?q=$repoName+user:$username";
  }
}
