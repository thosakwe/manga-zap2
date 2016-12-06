import 'package:angular2/core.dart' show Component;
import 'package:angular2/router.dart';
import 'package:material_toolbar/material_toolbar.dart';
import '../manga_detail/manga_detail.dart';
import '../manga_list/manga_list.dart';
import '../../services/title.dart';

@Component(
    selector: 'manga-zap',
    templateUrl: 'app.html',
    directives: const [ROUTER_DIRECTIVES, MaterialToolbarComponent])
@RouteConfig(const [
  const Route(
      path: '/manga',
      name: 'List',
      component: MangaListComponent,
      useAsDefault: true),
  const Route(
      path: '/manga/:id', name: 'Detail', component: MangaDetailComponent)
])
class AppComponent {
  final TitleService _titleService;

  String get title => _titleService.getTitle();

  AppComponent(this._titleService);
}
