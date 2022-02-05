import 'package:calculadora_atpdraw/app/constantes.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import 'carga_monofasica_store.dart';

class CargaMonofasicaPage extends StatefulWidget {
  final String title;
  const CargaMonofasicaPage({Key? key, this.title = 'CargaMonofasicaPage'})
      : super(key: key);

  @override
  CargaMonofasicaPageState createState() => CargaMonofasicaPageState();
}

class CargaMonofasicaPageState extends State<CargaMonofasicaPage> {
  CargaMonofasicaStore store = Modular.get<CargaMonofasicaStore>();
  final FocusScopeNode node = FocusScopeNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pageTitleSinglePhaseLoad".i18n()),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: kDefaultPadding * 0.5),
            child: Draggable(
              child: const Padding(
                padding: EdgeInsets.only(right: kDefaultPadding * 0.5),
                child: Icon(Icons.lightbulb_outline),
              ),
              feedback: Observer(builder: (_) {
                return Transform.scale(
                  origin: const Offset(25, 25),
                  scale: 2,
                  child: Icon(
                    store.onWillAccept
                        ? Icons.lightbulb
                        : Icons.lightbulb_outline,
                    color:
                        store.onWillAccept ? Colors.yellowAccent : Colors.grey,
                    size: 25,
                  ),
                );
              }),
              childWhenDragging: Container(),
              data: "dataNameTips".i18n(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FocusScope(
              node: node,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Text(
                      "titleFormsSinglePhaseLoad".i18n(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding * 0.25),
                    child: TextFormField(
                      controller: store.frequencia,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => store.setResultados(),
                      onEditingComplete: () {
                        node.nextFocus();
                        store.setResultados();
                      },
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: InputDecoration(
                        suffixText: "frequencySuffix".i18n(),
                        labelText: "frequencyLabel".i18n(),
                        hintText: "frequencyHint".i18n(),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding * 0.25),
                      child: TextFormField(
                        controller: store.tensao,
                        keyboardType: TextInputType.number,
                        onChanged: (value) => store.setResultados(),
                        onEditingComplete: () {
                          node.nextFocus();
                          store.setResultados();
                        },
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                          suffixText: "voltageSuffix".i18n(),
                          labelText: "voltageLabel".i18n(),
                          hintText: "voltageHint".i18n(),
                          border: const OutlineInputBorder(),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding * 0.25),
                      child: TextFormField(
                        controller: store.potencia,
                        keyboardType: TextInputType.number,
                        onChanged: (value) => store.setResultados(),
                        onEditingComplete: () {
                          node.nextFocus();
                          store.setResultados();
                        },
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                          labelText: "potencyLabel".i18n(),
                          suffixText: "potencySuffix".i18n(),
                          hintText: "potencyHint".i18n(),
                          border: const OutlineInputBorder(),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding * 0.25),
                      child: TextFormField(
                        controller: store.fatorPotencia,
                        keyboardType: TextInputType.number,
                        onChanged: (value) => store.setResultados(),
                        onEditingComplete: () {
                          node.unfocus();
                          store.setResultados();
                        },
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                          labelText: "powerFactorLabel".i18n(),
                          border: const OutlineInputBorder(),
                        ),
                      )),
                  Observer(builder: (_) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                            value: 0,
                            groupValue: store.value,
                            onChanged: (int? value) {
                              store.setValue(value!);
                            }),
                        Text(
                          "fpCapacitiveRadio".i18n(),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Radio(
                            value: 1,
                            groupValue: store.value,
                            onChanged: (int? value) {
                              store.setValue(value!);
                            }),
                        Text(
                          "fpInductiveRadio".i18n(),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kDefaultPadding * 0.25,
                  horizontal: kDefaultPadding * 0.8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding * 0.5),
                  child: Observer(builder: (_) {
                    return Column(
                      children: [
                        resultados("resistenceTitle".i18n(),
                            "resistenceSuffix".i18n(), store.resistencia),
                        const Divider(
                          color: Colors.black,
                        ),
                        resultados("inductanceTitle".i18n(),
                            "inductanceSuffix".i18n(), store.indutancia),
                        const Divider(
                          color: Colors.black,
                        ),
                        resultados("capacitiveTitle".i18n(),
                            "capacitiveSuffix".i18n(), store.capacitancia),
                        const Divider(
                          color: Colors.black,
                        ),
                        resultados(
                            "seriesResistenceTitle".i18n(),
                            "seriesResistenceSuffix".i18n(),
                            store.resistenciaSerie),
                      ],
                    );
                  }),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: kDefaultPadding * 0.5),
              child: Column(
                children: [
                  Text(
                    "imageExampleTitle".i18n(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Image.asset("assets/images/cargaMonofasica.png"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kDefaultPadding * 0.25,
                  horizontal: kDefaultPadding * 0.8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding * 0.5),
                  child: Observer(builder: (_) {
                    return Column(
                      children: [
                        resultados(
                            "angularCoefficientTitle".i18n(),
                            "angularCoefficientSuffix".i18n(),
                            store.coeficienteAngular),
                        const Divider(
                          color: Colors.black,
                        ),
                        resultados("currentPhasorTitle".i18n(),
                            "currentPhasorSuffix".i18n(), store.fasorCorrente,
                            angulo: store.anguloCorrente),
                        const Divider(
                          color: Colors.black,
                        ),
                        resultados("activePowerTitle".i18n(),
                            "activePowerSuffix".i18n(), store.potenciaAtiva),
                        const Divider(
                          color: Colors.black,
                        ),
                        resultados(
                            "reactivePowerTitle".i18n(),
                            "reactivePowerSuffix".i18n(),
                            store.potenciaReativa),
                        const Divider(
                          color: Colors.black,
                        ),
                        resultados(
                            "impedancePhasorTitle".i18n(),
                            "impedancePhasorSuffix".i18n(),
                            store.moduloImpedanciaPolar,
                            angulo: store.anguloImpedanciaPolar),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget resultados(String title, String unidade, double resultado,
      {double? angulo}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding * 0.25),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 120,
            child: Center(
                child: Text(
              angulo == null ? '$resultado' : '$resultado' ' |_$anguloº',
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyText2,
            )),
          ),
          Container(
            margin: const EdgeInsets.only(right: kDefaultPadding * 0.25),
            width: 40,
            child: Text(
              unidade,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
