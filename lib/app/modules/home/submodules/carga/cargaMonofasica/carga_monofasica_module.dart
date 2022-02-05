// ignore_for_file: file_names

import 'package:calculadora_atpdraw/app/modules/home/submodules/carga/carga_monofasica/carga_monofasica_page.dart';
import 'package:calculadora_atpdraw/app/modules/home/submodules/carga/carga_monofasica/carga_monofasica_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CargaMonofasicaModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CargaMonofasicaStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const CargaMonofasicaPage()),
  ];
}
