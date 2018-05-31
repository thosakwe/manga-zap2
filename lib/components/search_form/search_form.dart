import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:manga_zap/services/services.dart';
import 'query.dart';
export 'query.dart';

@Component(
    selector: 'search-form',
    templateUrl: 'search_form.html',
    directives: const [materialDirectives, NgFor, NgIf])
class SearchFormComponent {
  final MangaService _mangaService;

  @ViewChild('categorySelect')
  SelectElement categorySelect;

  List<String> get categories => _mangaService.categories;

  SearchFormComponent(this._mangaService);

  @Input()
  SearchQuery query = new SearchQuery();

  void addCategory() {
    if (categorySelect.value?.isNotEmpty == true) {
      if (!query.categories.contains(categorySelect.value)) {
        query.categories.add(categorySelect.value);
      }
    }
  }
}
