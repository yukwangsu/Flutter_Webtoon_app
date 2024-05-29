import 'package:flutter/material.dart';
import 'package:flutter_webtoon_app/models/webtoon_model.dart';
import 'package:flutter_webtoon_app/services/api_service.dart';
import 'package:flutter_webtoon_app/widgets/webtoon_widget.dart';

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
            //ListView.builder는 한번에 다 로딩하지 않고 필요할 때 아이템을 만든다.
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot))
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      //itemBuilder: 한번에 다 로딩하지 않고 스크롤할 때마다 로딩한다.
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      //separatorBuilder는 사이에 공간을 만드는 역할.
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
