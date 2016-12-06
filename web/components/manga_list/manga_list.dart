import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:material_menu/material_menu.dart';
import '../../pipes/eden_image.dart';
import '../../services/manga.dart';
import '../../services/title.dart';

@Component(
    selector: 'manga-list',
    templateUrl: 'manga_list.html',
    styleUrls: const ['manga_list.css'],
    directives: const [materialDirectives, menuDirectives, RouterLink],
    pipes: const [EdenImagePipe])
class MangaListComponent implements OnActivate {
  final MangaService _mangaService;
  final TitleService _titleService;

  bool loading = false;
  List<Map> get mangas => _mangaService.mangas.take(25).toList();

  MangaListComponent(this._mangaService, this._titleService);

  void fetchMangas() {
    loading = true;
    _titleService.setTitle('Loading...');
    _mangaService.fetchMangas().then((_) {
      loading = false;
      _titleService.setTitle('Manga (${mangas.length})');
    }).catchError((e, st) {
      // Todo: Local storage fallback?
      loading = false;
      window.console..error(e)..error(st);
      _titleService.setTitle('Load Failure');
    });
  }

  @override
  routerOnActivate(_, __) {
    _titleService.setTitle('Manga');
    fetchMangas();
  }
}