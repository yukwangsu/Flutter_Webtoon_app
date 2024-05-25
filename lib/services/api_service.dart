import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

  void getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$today');
    //async(비동기) programming: dart가 이 코드가 작업을 마칠 때까지
    //즉, 응답을 받을 때까지 기다리는 것. 다음줄로 넘어가지 않음.
    //await을 사용해서 구현 가능 단, getTodaysToons()async 이런식으로
    //async 함수를 사용해야 한다.

    //Future는 미래에 타입이 반환된 다는 것을 말해준다.
    //완료 되었을 때 이 함수는 Response를 반환한다.
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      return;
    }
    throw Error();
  }
}
