import 'package:angular2/angular2.dart';

@Pipe(name: 'eden_image')
class EdenImagePipe implements PipeTransform {
  String transform(String path) {
    if (path == null || path.isEmpty) {
      return '/images/logo.png';
    } else return 'https://cdn.mangaeden.com/mangasimg/$path';
  }
}