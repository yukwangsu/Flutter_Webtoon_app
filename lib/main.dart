import 'package:flutter/material.dart';
import 'package:flutter_webtoon_app/screens/home_screen.dart';
import 'package:flutter_webtoon_app/services/api_service.dart';

void main() {
  ApiService().getTodaysToons();
  runApp(const App());
}

class App extends StatelessWidget {
  //StatelessWidget 즉 super에게 key를 보냄.
  //widget은 key라는 걸 가지고 있고, ID처럼 쓰인다.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}