import 'dart:convert';
import 'dart:html';
import 'package:angular/angular.dart';
import 'manga.dart';

@Injectable()
class FavoritesService {
  final MangaService _mangaService;

  final List<String> favorites = [];

  FavoritesService(this._mangaService);

  List get favoriteManga =>
      _mangaService.mangas.where((m) => favorites.contains(m['i'])).toList();

  void add(String favorite) {
    favorites.add(favorite);
    save();
  }

  void load() {
    try {
      if (window.localStorage.containsKey('favorites')) {
        final favorites = json.decode(window.localStorage['favorites']);

        if (favorites is List) {
          this.favorites
            ..clear()
            ..addAll(favorites.cast<String>());
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void remove(String favorite) {
    favorites.remove(favorite);
    save();
  }

  void save() {
    try {
      window.localStorage['favorites'] = json.encode(favorites);
    } catch (_) {
      //
    }
  }
}
