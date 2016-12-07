import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular2_components/angular2_components.dart';
import '../../services/manga.dart';
import 'query.dart';
export 'query.dart';

@Component(
    selector: 'search-form',
    templateUrl: 'search_form.html',
    directives: const [materialDirectives])
class SearchFormComponent {
  final MangaService _mangaService;

  @ViewChild('categorySelect')
  ElementRef categorySelect;

  List<String> get categories => _mangaService.categories;

  SearchFormComponent(this._mangaService);

  @Input()
  SearchQuery query = new SearchQuery();

  void addCategory() {
    final SelectElement select = categorySelect.nativeElement;
    
    if (select.value?.isNotEmpty == true) {
      if (!query.categories.contains(select.value)) {
        query.categories.add(select.value);
      }
    }
  }
}
