import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:manga_zap/pipes/pipes.dart';
import 'package:manga_zap/services/services.dart';

@Component(
    selector: 'chapter-view',
    templateUrl: 'chapter_view.html',
    styleUrls: ['chapter_view.css'],
    directives: [materialDirectives, NgIf],
    providers: [ChapterService],
    pipes: [EdenImagePipe])
class ChapterViewComponent implements OnActivate, OnDeactivate {
  final ChapterService _chapterService;
  final TitleService _titleService;
  Map chapter = {'images': []};
  bool loading = true, error = false;
  int index = 0;

  String _id;

  List get current => images.length > index ? images[index] : null;

  String get id => _id ?? '';

  List<List> get images => chapter['images'];

  String get src => current[1];

  ChapterViewComponent(this._chapterService, this._titleService);

  void back() {
    if (index > 0) index--;
  }

  void forward() {
    if (index < images.length) index++;
  }

  @override
  onActivate(_, RouterState current) {
    _titleService.root = error = false;
    loading = true;
    _id = current.parameters['id'];
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
  onDeactivate(_, __) {
    _titleService.root = true;
  }
}
