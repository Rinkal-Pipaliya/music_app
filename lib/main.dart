import 'package:flutter/material.dart';
import 'package:media_booster_app/routes/routes.dart';
import 'package:media_booster_app/screen/home/view/home_screen.dart';
import 'package:media_booster_app/screen/music/provider/music_provider.dart';
import 'package:media_booster_app/screen/music/view/music_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MusicProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
      ),
    );
  }
}
