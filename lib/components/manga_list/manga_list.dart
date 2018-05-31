import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:manga_zap/components/search_form/search_form.dart';
import 'package:manga_zap/pipes/pipes.dart';
import 'package:manga_zap/services/services.dart';

@Component(selector: 'manga-list', templateUrl: 'manga_list.html', styleUrls: [
  'manga_list.css'
], directives: [
  materialDirectives,
  NgFor,
  NgIf,
  RouterLink,
  SearchFormComponent
], pipes: [
  EdenImagePipe,
  SearchPipe
])
class MangaListComponent implements OnActivate {
  final MangaService _mangaService;
  final TitleService _titleService;

  bool loading = false, showDialog = false;
  final SearchQuery query = new SearchQuery();

  List<Map> get mangas => _mangaService.mangas;

  MangaListComponent(this._mangaService, this._titleService);

  void fetchMangas() {
    loading = true;
    _titleService.setTitle('Loading...');
    _mangaService.fetchMangas().then((_) {
      loading = false;
      _titleService.setTitle('Manga');
    }).catchError((e, st) {
      // Todo: Local storage fallback?
      loading = false;
      window.console..error(e)..error(st);
      _titleService.setTitle('Load Failure');
    });
  }

  @override
  onActivate(_, __) {
    _titleService.setTitle('Manga');
    fetchMangas();
  }

  String detailUrl(String i) {
    // ['../Detail', {id: manga['i']}]
    return new RoutePath(path: '/detail').toUrl(parameters: {'id': i});
  }

  trackById(_, Map map) => map['i'];
}
