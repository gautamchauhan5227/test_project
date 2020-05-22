import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

class postview extends StatefulWidget {
  @override
  _postviewState createState() => _postviewState();
}

class _postviewState extends State<postview> {
  var sharimg = "ShareImage";
  var shartext = "ShareText";
  var text = "Text";
  var img = "Image";
  var vid = "Video";
  var typeuser = "Celebrity";

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.add_a_photo,
          size: 30.0,
          color: Colors.black,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.message,
              size: 30.0,
              color: Colors.black,
            ),
          )
        ],
      ),
      bottomNavigationBar: new BottomAppBar(
        elevation: 20.0,
        notchMargin: 2.0,
        shape: CircularNotchedRectangle(),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.home,
                size: 25.0,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.search,
                size: 25.0,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Container(
                width: deviceSize.width * 0.1,
                height: deviceSize.height * 0.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("img/pro.jpg"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          new FutureBuilder<List<Post>>(
            future: fetchPosts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Post> posts = snapshot.data;
                return new Column(
                    children: posts
                        .map((post) => new Column(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16.0, 16.0, 8.0, 16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              new Container(
                                                height: 40.0,
                                                width: 40.0,
                                                decoration: new BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: new DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: new NetworkImage(
                                                          "http://new.comnet.com.sg/TechTest/1.0/Register/ProfileThumbimg?ImageName=${post.profile}")),
                                                ),
                                              ),
                                              new SizedBox(
                                                width: 10.0,
                                              ),
                                              Text('MR. Chauhan'),
                                              new SizedBox(
                                                width: 10.0,
                                              ),
                                              if (post.usertype == typeuser)
                                                Image.asset(
                                                  "img/verify.png",
                                                  height: 15,
                                                  width: 15,
                                                )
                                            ],
                                          ),
                                          new IconButton(
                                            icon: Icon(Icons.more_vert),
                                            onPressed: null,
                                          )
                                        ],
                                      ),
                                    ),
                                    if (post.feedtype == img ||
                                        post.feedtype == sharimg)
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: new Image.network(
                                          "http://new.comnet.com.sg/TechTest/1.0/Feed/Feedimg?ImageName=${post.feedvalue}",
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    else if (post.feedtype == text ||
                                        post.feedtype == shartext)
                                      Flexible(
                                          fit: FlexFit.loose,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: new Text(
                                              "${post.feedvalue}",
                                              textAlign: TextAlign.justify,
                                            ),
                                          ))
                                    else
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: new Image.network(
                                          "http://new.comnet.com.sg/TechTest/1.0/Feed/Feedimg?ImageName=${post.videoimg}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              
                                              new Icon(
                                                FontAwesomeIcons.thumbsUp,
                                              ),
                                              new SizedBox(
                                                width: 16.0,
                                              ),
                                              new Icon(
                                                  FontAwesomeIcons.thumbsDown),
                                              new SizedBox(
                                                width: 16.0,
                                              ),
                                              new Icon(
                                                FontAwesomeIcons.comment,
                                              ),
                                              new SizedBox(
                                                width: 16.0,
                                              ),
                                              new Icon(FontAwesomeIcons.share),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text("${post.posttime}",
                                          style: TextStyle(color: Colors.grey)),
                                    ),
                                    Divider(
                                      thickness: 2.0,
                                      color: Colors.grey[100],
                                    ),
                                  ],
                                ),
                              ],
                            ))
                        .toList());
              } else if (snapshot.hasError) {
                return Text('Please Turn on Internet or Wifi');
              }
              return new Center(
                child: new Column(
                  children: <Widget>[
                    new Padding(padding: new EdgeInsets.all(50.0)),
                    new CircularProgressIndicator(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ));
  }
}

Future<List<Post>> fetchPosts() async {
  Map<String, String> aheaders = {
    'Content-Type': 'application/json; charset=utf-8',
  };
  final msg = jsonEncode({
    "UserID": "800",
    "PageNo": "1",
    "PageSize": "20",
  });
  http.Response response = await http.post(
      'http://new.comnet.com.sg/TechTest/1.0/Feed/HomepageFeedList',
      headers: aheaders,
      body: msg);
  var responseJson = json.decode(response.body);
  return (responseJson["FeedList"] as List)
      .map((p) => Post.fromJson(p))
      .toList();
}

class Post {
  final String feedvalue, profile, feedtype, videoimg, posttime, usertype;

  Post({
    this.feedvalue,
    this.profile,
    this.feedtype,
    this.videoimg,
    this.posttime,
    this.usertype,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
        profile: json['ProfilePicture'].toString(),
        feedtype: json['FeedType'].toString(),
        feedvalue: json['FeedValue'].toString(),
        videoimg: json['VideoThumbImg'].toString(),
        posttime: json['FeedUpdatedDate'].toString(),
        usertype: json['UserType'].toString());
  }
}
