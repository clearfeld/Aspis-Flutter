import 'package:aspis/theme.dart';
import 'package:flutter/material.dart';

class PageAbout extends StatelessWidget {
  const PageAbout({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
        ),
        elevation: 0,
        backgroundColor: customColors!.navbarBackground,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Aspis",
                style: TextStyle(color: customColors.buttonPrimary, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 4.0,
              ),
              const Text(
                "Version v0.0.3",
              ),
              const SizedBox(
                height: 8.0,
              ),
              Divider(
                color: customColors.border,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                "Developers",
                style: TextStyle(color: customColors.buttonPrimary, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 4.0,
              ),
              const Text(
                "@clearfeld",
              ),
              const SizedBox(
                height: 4.0,
              ),
              const Text(
                "@AaronPatterson1",
              ),
              const SizedBox(
                height: 8.0,
              ),
              Divider(
                color: customColors.border,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
