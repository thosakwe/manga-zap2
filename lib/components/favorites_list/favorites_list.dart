import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:manga_zap/services/services.dart';
import 'package:manga_zap/pipes/pipes.dart';

@Component(
    selector: 'favorites-list',
    templateUrl: 'favorites_list.html',
    styleUrls: ['favorites_list.css'],
    directives: [materialDirectives, NgFor, NgIf, RouterLink],
    pipes: [EdenImagePipe])
class FavoritesListComponent implements OnActivate, OnDeactivate {
  final FavoritesService _favoritesService;
  final TitleService _titleService;

  List get favorites => _favoritesService.favorites;

  List<Map> get mangas => _favoritesService.favoriteManga;

  FavoritesListComponent(this._favoritesService, this._titleService);

  @override
  onActivate(_, __) {
    _titleService
      ..root = false
      ..setTitle('Favorites');
    _favoritesService.load();
  }

  @override
  onDeactivate(_, __) {
    _titleService.root = true;
  }

  String detailUrl(String i) {
    // ['../Detail', {id: manga['i']}]
    return new RoutePath(path: '/detail').toUrl(parameters: {'id': i});
  }
}
