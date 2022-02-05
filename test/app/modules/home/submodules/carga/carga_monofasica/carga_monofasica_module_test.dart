
import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora_atpdraw/app/modules/home/submodules/carga/cargaMonofasica/carga_monofasica_module.dart';
 
void main() {

  setUpAll(() {
    initModule(CargaMonofasicaModule());
  });
}