import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:mobx/mobx.dart';
import 'dart:math';

part 'cargaMonofasica_store.g.dart';

class CargaMonofasicaStore = _CargaMonofasicaStoreBase
    with _$CargaMonofasicaStore;

abstract class _CargaMonofasicaStoreBase with Store {
  @observable
  MoneyMaskedTextController frequencia =
      MoneyMaskedTextController(decimalSeparator: '.', precision: 2);

  @observable
  MoneyMaskedTextController tensao =
      MoneyMaskedTextController(decimalSeparator: '.', precision: 2);

  @observable
  MoneyMaskedTextController potencia =
      MoneyMaskedTextController(decimalSeparator: '.', precision: 2);

  @observable
  MoneyMaskedTextController fatorPotencia =
      MoneyMaskedTextController(decimalSeparator: '.', precision: 2);

  @observable
  double coeficienteAngular = 0.0;

  @observable
  double fasorCorrente = 0.0;

  @observable
  double anguloCorrente = 0.0;

  @observable
  double potenciaAtiva = 0.0;

  @observable
  double potenciaReativa = 0.0;

  @observable
  double moduloImpedanciaPolar = 0.0;

  @observable
  double anguloImpedanciaPolar = 0.0;

  @observable
  double realImpedanciaRect = 0.0;

  @observable
  double imaginarioImpedanciaRect = 0.0;

  @observable
  double resistencia = 0.0;

  @observable
  double indutancia = 0.0;

  @observable
  double capacitancia = 0.0;

  @observable
  double resistenciaSerie = 0.0;

  @observable
  bool onWillAccept = false;

  @observable
  int value = 0;

  @action
  setResultados() {
    double frequenciaDouble = frequencia.numberValue;
    double tensaoDouble = tensao.numberValue;
    double potenciaDouble = potencia.numberValue;
    double fatorPotenciaDouble =
        value == 0 ? -fatorPotencia.numberValue : fatorPotencia.numberValue;
    setCoeficienteAngular(f: frequenciaDouble);
    setFasorCorrente(
        p: potenciaDouble, v: tensaoDouble, fp: fatorPotenciaDouble);
    setPotenciaAtiva(p: potenciaDouble, fp: fatorPotenciaDouble);
    setPotenciaReativa(p: potenciaDouble);
    setFasorImpedanciaPolar(v: tensaoDouble);
    setFasorImpedanciaRect(fp: fatorPotenciaDouble);
    setResistencia();
    setIndutancia(fp: fatorPotenciaDouble);
    setCapacitancia(fp: fatorPotenciaDouble);
    setResistenciaSerie();
  }

  @action
  setVariaveis() {}

  @action
  setCoeficienteAngular({double? f}) {
    if (frequencia.text.isNotEmpty) {
      coeficienteAngular = (2 * pi * f!).toPresicion(2);
    }
  }

  @action
  setFasorCorrente({double? p, double? v, double? fp}) {
    fasorCorrente = ((p! * 100000) / (v! * 100)).toPresicion(2);
    if (fp! >= 0) {
      anguloCorrente = (((180 * acos(fp)) / pi) * -1).toPresicion(2);
    } else {
      anguloCorrente = ((180 * acos(fp)) / pi).toPresicion(2);
    }
  }

  @action
  setPotenciaAtiva({double? p, double? fp}) {
    potenciaAtiva = ((p! * 100 * fp!) / 100).toPresicion(2);
  }

  @action
  setPotenciaReativa({double? p}) {
    potenciaReativa = (sqrt(pow(p!, 2) - pow(potenciaAtiva, 2))).toPresicion(2);
  }

  @action
  setFasorImpedanciaPolar({double? v}) {
    if (v != null && fasorCorrente > 0) {
      moduloImpedanciaPolar = (v / fasorCorrente).toPresicion(2);
      anguloImpedanciaPolar = anguloCorrente;
    }
  }

  @action
  setFasorImpedanciaRect({double? fp}) {
    realImpedanciaRect = (moduloImpedanciaPolar * fp!).toPresicion(2);

    if (fp >= 0) {
      imaginarioImpedanciaRect =
          (moduloImpedanciaPolar * sin(acos(fp))).toPresicion(2);
    } else {
      imaginarioImpedanciaRect =
          (moduloImpedanciaPolar * sin(-acos(fp))).toPresicion(2);
    }
  }

  @action
  setResistencia() {
    resistencia = realImpedanciaRect.abs();
  }

  @action
  setIndutancia({double? fp}) {
    if (fp! > 0) {
      indutancia = ((imaginarioImpedanciaRect / coeficienteAngular) * 1000)
          .toPresicion(2);
    } else {
      indutancia = 0.0;
    }
  }

  @action
  setCapacitancia({double? fp}) {
    if (fp! < 0) {
      capacitancia =
          ((-imaginarioImpedanciaRect / coeficienteAngular) * 1000000)
              .toPresicion(2);
    } else {
      capacitancia = 0.0;
    }
  }

  @action
  setResistenciaSerie() {
    if (capacitancia != 0.0) {
      resistenciaSerie =
          ((0.2 * 0.00001) / (2 * capacitancia * 0.000001)).toPresicion(7);
    } else {
      resistenciaSerie = 0.0;
    }
  }

  @action
  setOnWillAccepted(bool flag) {
    onWillAccept = flag;
  }

  @action
  setValue(int valor) {
    value = valor;
    setResultados();
  }
}

extension Ex on double {
  double toPresicion(int n) => double.parse(toStringAsFixed(n));
}
