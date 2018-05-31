import 'dart:async';
import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:http/browser_client.dart' as http;

@Injectable()
class ChapterService {
  final http.BrowserClient _client = new http.BrowserClient();

  Future<Map> fetchChapter(String id) async {
    final response = await _client.get('https://cors-anywhere.herokuapp.com/http://www.mangaeden.com/api/chapter/$id');
    return json.decode(response.body);
  }
}
