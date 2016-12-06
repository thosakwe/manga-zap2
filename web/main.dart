import 'package:angular2/angular2.dart';
import 'package:angular2/platform/browser.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import 'components/app/app.dart';
import 'services/manga.dart';
import 'services/title.dart';

main() {
  bootstrap(AppComponent, [
    materialProviders,
    ROUTER_PROVIDERS,
    MangaService,
    TitleService,
    provide(LocationStrategy, useClass: HashLocationStrategy)
  ]);
}
