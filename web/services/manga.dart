import 'dart:async';
import 'dart:convert';
import 'package:angular2/angular2.dart';
import 'package:http/browser_client.dart' as http;

@Injectable()
class MangaService {
  final http.BrowserClient _client = new http.BrowserClient();
  final List<Map> mangas = [];

  MangaService() {
    fetchMangas();
  }

  Future<Map> fetchManga(String id) async {
    final response =
        await _client.get('http://www.mangaeden.com/api/manga/$id');
    return JSON.decode(response.body);
  }

  Future fetchMangas() async {
    final response = await _client.get('http://www.mangaeden.com/api/list/0');
    final mangas = JSON.decode(response.body);

    if (mangas is Map && mangas.containsKey('manga')) {
      this.mangas
        ..clear()
        ..addAll(mangas['manga']);
    }
  }
}
