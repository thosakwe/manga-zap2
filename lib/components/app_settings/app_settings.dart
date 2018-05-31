import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:manga_zap/services/services.dart';

@Component(
    selector: 'app-settings',
    templateUrl: 'app_settings.html',
    styleUrls: ['app_settings.css'],
    directives: [materialDirectives, NgIf])
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
  onActivate(_, __) {
    _titleService
      ..root = false
      ..setTitle('Settings');
  }

  @override
  onDeactivate(_, __) {
    _titleService.root = true;
  }
}
