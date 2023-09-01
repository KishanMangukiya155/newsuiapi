import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class DetalisScreen extends StatefulWidget {
  const DetalisScreen(
      {super.key, this.image, this.name, this.fname, this.detail, this.url});

  final image;
  final name;
  final fname;
  final detail;
  final url;

  @override
  State<DetalisScreen> createState() => _DetalisScreenState();
}

class _DetalisScreenState extends State<DetalisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Share.share("${widget.url}");
            },
            icon: Icon(
              Icons.share,
              color: Colors.grey,
            ),
          ),
          SizedBox(width: 10),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Container(
                height: 250,
                width: 360,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("${widget.image}"),
                      fit: BoxFit.cover),
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Text("${widget.name}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Text("${widget.fname}", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Text("${widget.detail}", style: TextStyle()),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Text("${widget.detail}", style: TextStyle()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
