import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsuiapi/DetalisScreen.dart';
import 'package:share_plus/share_plus.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Map<String, dynamic> articles;

  Future<void> fileData() async {
    http.Response response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=tesla&from=&sortBy=publishedAt&apiKey=7561fba3f6c34b308887883255892322"));
    articles = jsonDecode(response.body);
    print(articles);
  }

  List<Widget> name = [
    Text("HOME"),
    Text("NEWS"),
    Text("SHOW"),
    Text("EXTRA"),
    Text("STYLE"),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Icon(Icons.menu),
          title: Center(child: Text("EVOKE")),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            )
          ],
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.black54,
            labelPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            indicatorColor: Colors.blue,
            // labelStyle: TextStyle(color: Colors.white),
            labelColor: Colors.black,
            tabs: List.generate(name.length, (index) => name[index]),
          ),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: 100,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  Map<String, dynamic> user = articles['articles'][index];
                  print(user);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => DetalisScreen(
                            image: user['urlToImage'],
                            name: user['description'],
                            fname: user['source']['name'],
                            detail: user['content'],
                            url: user['url'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: 360,
                      margin: EdgeInsets.symmetric(vertical: 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black, blurRadius: 0.5)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                    image:
                                        NetworkImage("${user['urlToImage']}"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${user['content']}",
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text("${user['publishedAt']}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: fileData(),
        ),
      ),
    );
  }
}
