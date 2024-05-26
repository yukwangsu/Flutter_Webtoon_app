import 'package:flutter/material.dart';
import 'package:flutter_webtoon_app/models/webtoon_model.dart';
import 'package:flutter_webtoon_app/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

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
      //FutureBuilder는 future값을 기다리고 데이터가 존재하는지 알려준다.
      body: FutureBuilder(
          future: webtoons,
          //snapshot은 future의 상태를 보여준다(로딩 중인지, 데이터가 있는지, 에러가 발생했는지)
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Text("There is data!");
            }
            return const Text('Loaing...');
          }),
    );
  }
}
