import 'dart:async';
import 'dart:convert';
import 'package:angular2/angular2.dart';
import 'package:http/browser_client.dart' as http;

@Injectable()
class ChapterService {
  final http.BrowserClient _client = new http.BrowserClient();

  Future<Map> fetchChapter(String id) async {
    final response = await _client.get('http://www.mangaeden.com/api/chapter/$id');
    return JSON.decode(response.body);
  }
}
