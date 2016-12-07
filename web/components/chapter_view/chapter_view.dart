import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import '../../pipes/eden_image.dart';
import '../../services/chapter.dart';
import '../../services/title.dart';

@Component(
    selector: 'chapter-view',
    templateUrl: 'chapter_view.html',
    styleUrls: const ['chapter_view.css'],
    directives: const [materialDirectives],
    providers: const [ChapterService],
    pipes: const [EdenImagePipe])
class ChapterViewComponent implements OnActivate, OnDeactivate {
  final ChapterService _chapterService;
  final RouteParams _routeParams;
  final TitleService _titleService;
  bool loading = true, error = false;
  int index = 0;

  Map chapter = {'images': []};

  List get current => images.length > index ? images[index] : null;
  String get id => _routeParams.get('id');
  List<List> get images => chapter['images'];
  String get src => current[1];

  ChapterViewComponent(
      this._chapterService, this._routeParams, this._titleService);

  void back() {
    if (index > 0) index--;
  }

  void forward() {
    if (index < images.length) index++;
  }

  @override
  routerOnActivate(_, __) {
    _titleService.root = error = false;
    loading = true;
    _chapterService.fetchChapter(id).then((chapter) {
      loading = error = false;
      this.chapter = chapter;
    }).catchError((e, st) {
      loading = false;
      error = true;
      window.console..error(e)..error(st);
    });
  }

  @override
  routerOnDeactivate(_, __) {
    _titleService.root = true;
  }
}
