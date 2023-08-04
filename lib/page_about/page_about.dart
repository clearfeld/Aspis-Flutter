import 'package:aspis/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageAbout extends StatelessWidget {
  const PageAbout({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.page_about__about ?? "",
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
              Text(
                (AppLocalizations.of(context)?.page_about__version ?? "") + " v0.0.3",
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
                AppLocalizations.of(context)?.page_about__developers ?? "",
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
