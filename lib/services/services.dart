import 'chapter.dart';
import 'favorites.dart';
import 'manga.dart';
import 'title.dart';
export 'chapter.dart';
export 'favorites.dart';
export 'manga.dart';
export 'title.dart';

const List<Type> mangaZapProviders = const [
  ChapterService,
  FavoritesService,
  MangaService,
  TitleService
];
