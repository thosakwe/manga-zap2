import 'dart:html';
import 'package:angular2/core.dart' show Component;
import 'package:angular2/router.dart';
import 'package:material_menu/material_menu.dart';
import 'package:material_sidenav/material_sidenav.dart';
import 'package:material_toolbar/material_toolbar.dart';
import '../app_settings/app_settings.dart';
import '../chapter_view/chapter_view.dart';
import '../favorites_list/favorites_list.dart';
import '../manga_detail/manga_detail.dart';
import '../manga_list/manga_list.dart';
import '../../services/title.dart';

@Component(selector: 'manga-zap', templateUrl: 'app.html', directives: const [
  ROUTER_DIRECTIVES,
  menuDirectives,
  MaterialToolbarComponent,
  MaterialSidenavComponent
])
@RouteConfig(const [
  const Route(
      path: '/manga',
      name: 'List',
      component: MangaListComponent,
      useAsDefault: true),
  const Route(
      path: '/manga/:id', name: 'Detail', component: MangaDetailComponent),
  const Route(
      path: '/chapter/:id', name: 'Chapter', component: ChapterViewComponent),
  const Route(
      path: '/favorites', name: 'Favorites', component: FavoritesListComponent),
  const Route(
      path: '/settings', name: 'Settings', component: AppSettingsComponent)
])
class AppComponent {
  final TitleService _titleService;

  bool sidenav = false;

  String get icon => root ? 'menu' : 'arrow_back';
  bool get root => _titleService.root;
  String get title => _titleService.getTitle();

  AppComponent(this._titleService);

  void handleIconClick() {
    if (root) {
      sidenav = true;
    } else {
      window.history.go(-2);
    }
  }
}
