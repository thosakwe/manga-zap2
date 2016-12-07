import 'package:angular2/angular2.dart';
import '../components/search_form/query.dart';

@Pipe(name: 'search', pure: false)
class SearchPipe implements PipeTransform {
  List<Map> transform(List<Map> search, SearchQuery query) {
    return []
      ..addAll(search.where((manga) {
        return query.title == null ||
            query.title.isEmpty ||
            manga['t'].toLowerCase().contains(query.title.toLowerCase());
      }).where((manga) {
        return query.categories.isEmpty ||
            manga['c'].any((category) => query.categories
                .map((c) => c.toLowerCase())
                .contains(category.toLowerCase()));
      }).take(25))
      ..sort((a, b) => a['t'].compareTo(b['t']));
  }
}
