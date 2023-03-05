import 'package:aspis/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:aspis/page_main/page_main.dart';
import 'package:aspis/page_unlock/page_unlock.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const PageUnlock();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const PageMain();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      //   theme: ThemeData(
      //     useMaterial3: true,
      //   ),
      theme: custLightTheme,
      darkTheme: custDarkTheme,
      themeMode: ThemeMode.system,
      //   theme: ThemeData(
      //     primarySwatch: Colors.blue,
      //   ),
      routerConfig: _router,
    );
  }
}
