import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:manga_zap/components/app/app.template.dart' as app;
import 'package:manga_zap/services/services.dart';
import 'package:pwa/client.dart' as pwa;
import 'main.template.dart' as ng;

@GenerateInjector([
  materialProviders,
  routerProviders,
  mangaZapProviders,
  const Provider(LocationStrategy, useClass: HashLocationStrategy)
])
final InjectorFactory mangaZapApp = ng.mangaZapApp$Injector;

main() {
  //new pwa.Client();
  runApp(app.AppComponentNgFactory, createInjector: mangaZapApp);
}
