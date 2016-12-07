import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:material_menu/material_menu.dart';
import 'package:material_toolbar/material_toolbar.dart';
import '../../pipes/eden_image.dart';
import '../../services/favorites.dart';
import '../../services/manga.dart';
import '../../services/title.dart';

@Component(
    selector: 'manga-detail',
    templateUrl: 'manga_detail.html',
    styleUrls: const [
      'manga_detail.css'
    ],
    directives: const [
      ROUTER_DIRECTIVES,
      materialDirectives,
      menuDirectives,
      MaterialToolbarComponent
    ],
    pipes: const [
      EdenImagePipe
    ])
class MangaDetailComponent implements OnActivate, OnDeactivate {
  final FavoritesService _favoriteService;
  final MangaService _mangaService;
  final RouteParams _routeParams;
  final TitleService _titleService;
  final HtmlUnescape _unescape = new HtmlUnescape();

  List<List> get chapters => manga['chapters'];
  String get desc => _unescape.convert(manga['description']);
  List<String> get favorites => _favoriteService.favorites;
  String get id => _routeParams.get('id');

  bool loading = true, error = false;
  Map manga = {};

  MangaDetailComponent(this._favoriteService, this._mangaService,
      this._routeParams, this._titleService);

  @override
  routerOnActivate(_, __) {
    loading = true;
    error = false;

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
  routerOnDeactivate(_, __) {
    _titleService.root = true;
  }

  void updateFavorites(bool favorite) {
    if (favorite && !favorites.contains(id)) {
      _favoriteService.add(id);
    } else if (!favorite && favorites.contains(id)) {
      _favoriteService.remove(id);
    }
  }
}
