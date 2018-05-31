import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:angular/angular.dart';
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
            .where((cat) => !categories.contains(cat))
            .cast<String>());
      }
    }

    return categories..sort((a, b) => a.compareTo(b));
  }

  MangaService() {
    fetchMangas();
  }

  Future<Map> fetchManga(String id) async {
    final response = await _client.get(
        'https://cors-anywhere.herokuapp.com/http://www.mangaeden.com/api/manga/$id');
    return json.decode(response.body);
  }

  Future downloadMangas() async {
    final response = await _client.get(
        'https://cors-anywhere.herokuapp.com/http://www.mangaeden.com/api/list/0');
    final mangas = json.decode(response.body);

    if (mangas is Map && mangas.containsKey('manga')) {
      this.mangas
        ..clear()
        ..addAll(mangas['manga'].cast<Map>());

      // Persist to localStorage...
      //
      // Unfortunately, this won't work, because the DB is too big.
      //
      // Todo: DB can be split into chunks and incrementally loaded...
      try {
        window.localStorage['manga'] =
            json.encode(base64.encode(response.body.codeUnits));
      } catch (_) {
        //
      }
    }
  }

  Future fetchMangas() async {
    if (window.localStorage.containsKey('manga')) {
      final mangas = json.decode(new String.fromCharCodes(
          base64.decode(json.decode(window.localStorage['manga']))));

      if (mangas is List) {
        this.mangas
          ..clear()
          ..addAll(mangas.cast<Map>());
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
