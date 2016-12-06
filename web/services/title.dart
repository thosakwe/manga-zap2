import 'dart:html';
import 'package:angular2/angular2.dart';

@Injectable()
class TitleService {
  String _title = 'Home';

  String getTitle() => _title;

  void setTitle(String title) {
    document.title = '${_title = title} | Manga Zap';
  }
}