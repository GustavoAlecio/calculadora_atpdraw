import 'package:calculadora_atpdraw/app/constantes.dart';
import 'package:calculadora_atpdraw/app/modules/home/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:localization/localization.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return store.isFirstTime == true
          ? SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: kDefaultPadding * 0.5),
                  child: IntroductionScreen(
                    globalBackgroundColor: Colors.white,
                    pages: [
                      PageViewModel(
                        title: "splashScreenTitle".i18n(),
                        bodyWidget: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: kDefaultPadding * 0.5),
                              child: SizedBox(
                                height: 200,
                                child: Image.asset(
                                  'assets/images/lightbulb-removebg-preview.png',
                                  height: 200,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.all(kDefaultPadding * 0.5),
                              child: Text(
                                "splashScreenTextTips".i18n(),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    done: Text("splashScreenTextButton".i18n()),
                    onDone: () {
                      store.setFirstTime();
                    },
                    showNextButton: false,
                  ),
                ),
              ),
            )
          : SafeArea(
              child: Scaffold(
                appBar: PreferredSize(
                  child: AppBar(
                    title: Text(
                      "homePageAppBarTitle".i18n(),
                      maxLines: 2,
                    ),
                    centerTitle: true,
                  ),
                  preferredSize: const Size.fromHeight(60),
                ),
                body: Column(
                  children: <Widget>[
                    ExpansionTile(
                      initiallyExpanded: true,
                      title: Text("sessionTileTitleTransformer".i18n()),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            cardTrafo(
                                title: "D-D",
                                rota: '/trafoD-D',
                                color: Colors.white),
                            cardTrafo(
                                title: 'D-Y',
                                rota: '/trafoD-D',
                                color: kCardColor),
                            cardTrafo(
                                title: 'Y-D',
                                rota: '/trafoD-D',
                                color: kCardColor),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            cardTrafo(
                                title: 'Y-Y',
                                rota: '/trafoD-D',
                                color: kCardColor),
                            cardTrafo(
                                title: 'Auto',
                                rota: '/trafoD-D',
                                color: kCardColor),
                            cardTrafo(
                                title: 'Série',
                                rota: '/trafoD-D',
                                color: kCardColor),
                          ],
                        )
                      ],
                    ),
                    ExpansionTile(
                      initiallyExpanded: true,
                      title: Text("sessionTileTitleLoad".i18n()),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            cardCarga("simplePhaseLoadTitle".i18n(),
                                '/CargaMonofasica',
                                color: Colors.white),
                            cardCarga(
                                "triphasicLoadTitle".i18n(), '/CargaTrifasica',
                                color: Colors.white),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            cardCarga("cbdTitle".i18n(), '/bancoCapacitores',
                                color: Colors.white),
                            cardCarga(
                                "sourceShortLevelTitle".i18n(), '/nivelCurto',
                                color: Colors.white),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
    });
  }

  Widget cardTrafo(
      {required String title, required String rota, required Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 0.5, vertical: kDefaultPadding * 0.5),
      child: InkWell(
        onTap: () {
          Modular.to.pushNamed(rota);
        },
        child: Container(
            padding: const EdgeInsets.all(kDefaultPadding * 0.3),
            height: 75,
            width: 75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text(title)],
            ),
            decoration: BoxDecoration(
                color: color,
                border: Border.all(color: kCardColor),
                borderRadius: BorderRadius.circular(25))),
      ),
    );
  }

  Widget cardCarga(String text, String ontap, {required Color color}) {
    var rota = ontap;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 0.5, vertical: kDefaultPadding * 0.5),
      child: InkWell(
        onTap: () {
          Modular.to.pushNamed(rota);
        },
        child: Container(
            height: 60,
            width: 130,
            padding: const EdgeInsets.all(kDefaultPadding * 0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            decoration: BoxDecoration(
                color: color,
                border: Border.all(color: kCardColor),
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
