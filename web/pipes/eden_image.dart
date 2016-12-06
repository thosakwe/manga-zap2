import 'package:angular2/angular2.dart';

@Pipe(name: 'eden_image')
class EdenImagePipe implements PipeTransform {
  String transform(String path) => 'https://cdn.mangaeden.com/mangasimg/$path';
}