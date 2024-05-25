import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Scaffold는 screen을 위한 기본적인 레이아웃과 설정을 제공한다.
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //elevation - 음영
        elevation: 2,
        backgroundColor: Colors.white,
        centerTitle: true,
        //foregroundColor로 Appbar의 글씨 색을 바꾼다.
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
