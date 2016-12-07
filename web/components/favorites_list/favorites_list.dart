import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:material_menu/material_menu.dart';
import '../../pipes/eden_image.dart';
import '../../services/favorites.dart';
import '../../services/title.dart';

@Component(
    selector: 'favorites-list',
    templateUrl: 'favorites_list.html',
    styleUrls: const ['favorites_list.css'],
    directives: const [materialDirectives, menuDirectives, RouterLink],
    pipes: const [EdenImagePipe])
class FavoritesListComponent implements OnActivate, OnDeactivate {
  final FavoritesService _favoritesService;
  final TitleService _titleService;

  List get favorites => _favoritesService.favorites;
  List<Map> get mangas => _favoritesService.favoriteManga;

  FavoritesListComponent(this._favoritesService, this._titleService);

  @override
  routerOnActivate(_, __) {
    _titleService
      ..root = false
      ..setTitle('Favorites');
    _favoritesService.load();
  }

  @override
  routerOnDeactivate(_, __) {
    _titleService.root = true;
  }
}
