import 'dart:html';
import 'package:angular/angular.dart';

@Injectable()
class TitleService {
  String _title = 'Home';
  bool root = true;

  String getTitle() => _title;

  void setTitle(String title) {
    document.title = '${_title = title} | Manga Zap';
  }
}