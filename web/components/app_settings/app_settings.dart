import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import '../../services/manga.dart';
import '../../services/title.dart';

@Component(
    selector: 'app-settings',
    templateUrl: 'app_settings.html',
    styleUrls: const ['app_settings.css'],
    directives: const [materialDirectives])
class AppSettingsComponent implements OnActivate, OnDeactivate {
  final MangaService _mangaService;
  final TitleService _titleService;
  bool downloading = false, error = false;

  AppSettingsComponent(this._mangaService, this._titleService);

  List get manga => _mangaService.mangas;

  void download() {
    downloading = true;
    error = false;

    _mangaService.downloadMangas().then((_) {
      downloading = error = false;
    }).catchError((e, st) {
      error = true;
      downloading = false;
      window.console..error(e)..error(st);
    });
  }

  @override
  routerOnActivate(_, __) {
    _titleService
      ..root = false
      ..setTitle('Settings');
  }

  @override
  routerOnDeactivate(_, __) {
    _titleService.root = true;
  }
}
