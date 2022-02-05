import 'package:calculadora_atpdraw/app/modules/home/submodules/carga/carga_monofasica/carga_monofasica_page.dart';
import 'package:calculadora_atpdraw/app/modules/home/submodules/carga/carga_monofasica/carga_monofasica_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../home/home_store.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => CargaMonofasicaStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
    ChildRoute('/CargaMonofasica',
        child: (context, args) => const CargaMonofasicaPage()),
  ];
}
