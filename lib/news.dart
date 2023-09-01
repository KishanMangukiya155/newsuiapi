import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late List name;
  Future<void> filData() async {
    http.Response response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    name = jsonDecode(response.body);

    print(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: Text("News",
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          backgroundColor: Colors.blue),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {}
          return ListView.builder(
            itemCount: 100,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              Map<String, dynamic> user = name[index];
              print(user);
              return Column(
                children: [
                  Container(
                    height: 100,
                    width: 360,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Common:${user['name']['common']}"),
                          Text(
                              "NativeName:${user['name']['nativeName']['eng']}"),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        future: filData(),
      ),
    );
  }
}
