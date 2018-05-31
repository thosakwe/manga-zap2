import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:manga_zap/components/app_settings/app_settings.template.dart'
    as ng;
import 'package:manga_zap/components/chapter_view/chapter_view.template.dart'
    as ng;
import 'package:manga_zap/components/favorites_list/favorites_list.template.dart'
    as ng;
import 'package:manga_zap/components/manga_detail/manga_detail.template.dart'
    as ng;
import 'package:manga_zap/components/manga_list/manga_list.template.dart' as ng;
import 'package:manga_zap/services/services.dart';

@Component(selector: 'manga-zap', templateUrl: 'app.html', styleUrls: [
  'package:angular_components/app_layout/layout.scss.css'
], directives: [
  materialDirectives,
  routerDirectives,
])
class AppComponent {
  final TitleService titleService;

  bool sidenav = false;

  final List<RouteDefinition> routes = [
    RouteDefinition(
      path: 'manga',
      component: ng.MangaListComponentNgFactory,
      useAsDefault: true,
    ),
    RouteDefinition(
      path: 'manga/:id',
      component: ng.MangaDetailComponentNgFactory,
    ),
    RouteDefinition(
      path: 'chapter/:id',
      component: ng.ChapterViewComponentNgFactory,
    ),
    RouteDefinition(
      path: 'favorites',
      component: ng.FavoritesListComponentNgFactory,
    ),
    RouteDefinition(
      path: 'settings',
      component: ng.AppSettingsComponentNgFactory,
    ),
  ];

  String get icon => root ? 'menu' : 'arrow_back';

  bool get root => titleService.root;

  String get title => titleService.getTitle();

  AppComponent(this.titleService);

  void handleIconClick() {
    if (root) {
      sidenav = true;
    } else {
      window.history.go(-2);
    }
  }

  String route(String path) => new RoutePath(path: path).toUrl();
}
