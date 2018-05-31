import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:manga_zap/pipes/pipes.dart';
import 'package:manga_zap/services/services.dart';

@Component(
    selector: 'manga-detail',
    templateUrl: 'manga_detail.html',
    styleUrls: [
      'manga_detail.css'
    ],
    directives: [
      materialDirectives,
      routerDirectives,
      NgFor,
      NgIf,
    ],
    pipes: [
      EdenImagePipe
    ])
class MangaDetailComponent implements OnActivate, OnDeactivate {
  final FavoritesService _favoriteService;
  final MangaService _mangaService;
  final TitleService _titleService;
  final HtmlUnescape _unescape = new HtmlUnescape();
  String _id;

  List<List> get chapters => manga['chapters'];

  String get desc => _unescape.convert(manga['description']);

  List<String> get favorites => _favoriteService.favorites;

  String get id => _id ?? '';

  bool loading = true, error = false;
  Map manga = {};

  MangaDetailComponent(
      this._favoriteService, this._mangaService, this._titleService);

  @override
  onActivate(_, RouterState current) {
    loading = true;
    error = false;

    _id = current.parameters['id'];
    _mangaService.fetchManga(id).then((manga) {
      loading = false;
      error = false;
      this.manga = manga;
      _titleService
        ..root = false
        ..setTitle(manga['title']);
    }).catchError((e, st) {
      loading = false;
      error = true;
      _titleService.setTitle('Load Failure');
      window.console..error(e)..error(st);
    });
  }

  @override
  onDeactivate(_, __) {
    _titleService.root = true;
  }

  String chapterUrl(String chapter) {
    // ['../Chapter', { id: chapter[3] }]
    return new RoutePath(path: '/chapter').toUrl(parameters: {'id': chapter});
  }

  void updateFavorites(bool favorite) {
    if (favorite && !favorites.contains(id)) {
      _favoriteService.add(id);
    } else if (!favorite && favorites.contains(id)) {
      _favoriteService.remove(id);
    }
  }
}
