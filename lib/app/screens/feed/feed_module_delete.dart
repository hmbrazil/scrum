import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:social/app/screens/feed/sprint_widget_detail.dart';
import 'package:social/app/screens/feed/components/sprint/sprint_api.dart';
import 'package:social/app/screens/feed/components/sprint/sprint_bloc.dart';


class FeedModuleDelete extends ModuleWidget {

  int _id;
  int _opcao;
  FeedModuleDelete(this._id, this._opcao);

  @override
  List<Bloc> get blocs =>[
    Bloc((i) => SprintBloc(i.getDependency<SprintApi>())),
  ];

  @override
  Widget get view => SprintWidgetDetail(_id, _opcao);

  @override
  List<Dependency> get dependencies => [
    Dependency(_getFeedApiDelete),
  ];

  SprintApi _getFeedApiDelete(Inject i) {
    return SprintApi();
  }

  static Inject get to {
    return Inject<FeedModuleDelete>.of();
  }
}
