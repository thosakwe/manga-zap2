import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:http/browser_client.dart' as http;

@Injectable()
class MangaService {
  final http.BrowserClient _client = new http.BrowserClient();
  final List<Map> mangas = [];

  List<String> get categories {
    final List<String> categories = [];

    for (Map manga in mangas) {
      final c = manga['c'];

      if (c is List) {
        categories.addAll(c
            .map((cat) => cat.trim())
            .where((cat) => !categories.contains(cat)));
      }
    }

    return categories..sort((a, b) => a.compareTo(b));
  }

  MangaService() {
    fetchMangas();
  }

  Future<Map> fetchManga(String id) async {
    final response =
        await _client.get('http://www.mangaeden.com/api/manga/$id');
    return JSON.decode(response.body);
  }

  Future downloadMangas() async {
    final response = await _client.get('http://www.mangaeden.com/api/list/0');
    final mangas = JSON.decode(response.body);

    if (mangas is Map && mangas.containsKey('manga')) {
      this.mangas
        ..clear()
        ..addAll(mangas['manga']);

      // Persist to localStorage...
      //
      // Unfortunately, this won't work, because the DB is too big.
      //
      // Todo: DB can be split into chunks and incrementally loaded...
      try {
        window.localStorage['manga'] =
            JSON.encode(BASE64.encode(response.body.codeUnits));
      } catch (_) {
        //
      }
    }
  }

  Future fetchMangas() async {
    if (window.localStorage.containsKey('manga')) {
      final mangas = JSON.decode(new String.fromCharCodes(
          BASE64.decode(JSON.decode(window.localStorage['manga']))));

      if (mangas is List) {
        this.mangas
          ..clear()
          ..addAll(mangas);
      }
    } else if (mangas.isEmpty) {
      // If we already loaded manga, let's not again during
      // this session.
      //
      // UX FTW
      await downloadMangas();
    }
  }
}
