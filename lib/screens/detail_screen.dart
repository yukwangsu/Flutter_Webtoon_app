import 'package:flutter/material.dart';
import 'package:flutter_webtoon_app/models/webtoon_detail_model.dart';
import 'package:flutter_webtoon_app/models/webtoon_episode_model.dart';
import 'package:flutter_webtoon_app/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    //DetailScreen을 StatefulWidget으로 바꾸고 widget.id를 사용해서 api를 요청한다.
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //elevation - 음영
          elevation: 2,
          backgroundColor: Colors.white,
          centerTitle: true,
          //foregroundColor로 Appbar의 글씨 색을 바꾼다.
          foregroundColor: Colors.green,
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //webtoon_widet과 동일한 태그를 가지면 화면전환이 자연스럽게 된다.
                Hero(
                  tag: widget.id,
                  child: Container(
                    width: 250,
                    clipBehavior: Clip.hardEdge,
                    //container 장식
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          //blurRadius: shadow 크기
                          blurRadius: 15,
                          offset: const Offset(10, 10),
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                    //container 내용
                    child: Image.network(
                      widget.thumb,
                      headers: const {
                        'Referer': 'https://comic.naver.com',
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            FutureBuilder(
              future: webtoon,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          //한번에 여러 정보를 text로 보여주기
                          '${snapshot.data!.genre} / ${snapshot.data!.age}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }
                return const Text("...");
              },
            )
          ],
        ));
  }
}
