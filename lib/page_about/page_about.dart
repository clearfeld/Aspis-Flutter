import 'package:flutter/material.dart';

class PageAbout extends StatelessWidget {
  const PageAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
        ),
        elevation: 0,
        backgroundColor: const Color(0xFF006699),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                "Aspis",
                style: TextStyle(color: Colors.blue),
              ),
              Text(
                "version 0.0.1",
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Developers",
                style: TextStyle(color: Colors.blue),
              ),
              Text(
                "@clearfeld",
              ),
              Text(
                "@AaronPatterson1",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
