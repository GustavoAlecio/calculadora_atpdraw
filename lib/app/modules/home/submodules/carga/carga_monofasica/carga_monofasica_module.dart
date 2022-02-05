// ignore_for_file: file_names

import 'package:flutter_modular/flutter_modular.dart';

import 'carga_monofasica_page.dart';
import 'carga_monofasica_store.dart';

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
