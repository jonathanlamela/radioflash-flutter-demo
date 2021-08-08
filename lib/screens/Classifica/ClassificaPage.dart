import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radioflash/bloc/classifica_bloc.dart';
import 'package:radioflash/cubit/annoclassifica_cubit.dart';
import 'package:radioflash/models/Classifica.dart';
import 'package:radioflash/widgets/LoadingProgress.dart';
import "../../ThemeConfig.dart";

class ClassificaPage extends StatefulWidget {
  ClassificaPage({Key? key}) : super(key: key);

  @override
  _ClassificaPageState createState() => _ClassificaPageState();
}

class _ClassificaPageState extends State<ClassificaPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ClassificaBloc>().startListenAnno();
    context.read<AnnoclassificaCubit>().initAnni();
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 24, left: 10, right: 10),
              decoration: BoxDecoration(
                color: context.homeContainerColor(),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              padding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 24),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.white, width: 0.2))),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Classifica",
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor,
                              style: context.classificaPageTextStyle(),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  AnnoControls(),
                  ClassificaControls(),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      child: SingleChildScrollView(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          child: ClassificaRender(
                            key: UniqueKey(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AnnoControls extends StatelessWidget {
  AnnoControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
            child: Text(
              "Anno",
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          BlocBuilder<AnnoclassificaCubit, AnnoclassificaState>(
            builder: (context, state) {
              if (state is AnnoClassificaUpdateState) {
                return Expanded(
                  child: Container(
                    child: DropdownButton(
                        isExpanded: true,
                        dropdownColor: Colors.black,
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          context.read<AnnoclassificaCubit>().cambiaAnno(value);
                        },
                        value: state.Selected,
                        items: List.generate(state.Anni.length, (index) {
                          return DropdownMenuItem(
                            value: state.Anni.elementAt(index),
                            child: Text(
                              state.Anni.elementAt(index),
                            ),
                          );
                        })),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}

class ClassificaControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
            child: Text(
              "Classifica",
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          BlocBuilder<ClassificaBloc, ClassificaState>(
            builder: (context, state) {
              if (state is ClassificaResultsState) {
                return Expanded(
                  child: Container(
                    child: DropdownButton(
                      isExpanded: true,
                      dropdownColor: Colors.black,
                      style: TextStyle(color: Colors.white),
                      value: state.selected,
                      onChanged: (value) {
                        context.read<ClassificaBloc>().add(
                            ClassificaSelectionChangedEvent(
                                state.Results, value as Classifica));
                      },
                      items: List.generate(state.Results.length, (index) {
                        return DropdownMenuItem(
                          value: state.Results.elementAt(index),
                          child: Text(
                            state.Results.elementAt(index).titolo!,
                          ),
                        );
                      }),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: Container(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class ClassificaRender extends StatelessWidget {
  ClassificaRender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassificaBloc, ClassificaState>(
      builder: (context, state) {
        if (state is ClassificaResultsState) {
          if (state.selected != null) {
            return Column(
              key: UniqueKey(),
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                state.selected!.items.length,
                (index) {
                  var item = state.selected!.items.elementAt(index);
                  var symbol = Icon(Icons.arrow_drop_up, color: Colors.green);

                  switch (item.movement) {
                    case "=":
                      {
                        symbol = Icon(Icons.swap_vert, color: Colors.yellow);
                      }
                      break;
                    case "up":
                      {
                        symbol =
                            Icon(Icons.arrow_upward, color: Colors.greenAccent);
                      }
                      break;
                    case "down":
                      {
                        symbol =
                            Icon(Icons.arrow_downward, color: Colors.redAccent);
                      }
                      break;
                  }
                  return Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${index + 1}",
                                  style: context.classificaNumeroTextStyle()),
                              symbol,
                            ],
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Container(
                              margin: EdgeInsets.all(4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                child: FittedBox(
                                  child: item.cover,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              decoration: context.classificaCoverDecoration()),
                        ),
                        Flexible(
                          flex: 6,
                          child: Row(
                            children: [
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.titolo!,
                                        style: context
                                            .classificaSongTitleTextStyle(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(children: [
                                        Flexible(
                                          child: Text(
                                            stringAutori(item.autori),
                                            overflow: TextOverflow.ellipsis,
                                            style: context
                                                .classificaSongAuthorsTextStyle(),
                                          ),
                                        )
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return LoadingProgress();
          }
        } else {
          return LoadingProgress();
        }
      },
    );
  }
}

String stringAutori(autori) {
  String result = "";

  List.generate(autori.length, (index) {
    result += autori.elementAt(index).name! +
        (autori.length > 1 && index < autori.length - 1 ? " & " : "");
  });

  return result;
}
