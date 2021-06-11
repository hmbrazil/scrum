import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:social/app/screens/feed/feed_api.dart';
import 'package:social/app/screens/feed/feed_bloc.dart';
import 'package:social/app/screens/feed/feed_bloc_detalhe.dart';
import 'package:social/app/screens/feed/feed_widget.dart';
import 'package:social/app/screens/feed/feed_widget_detalhe.dart';

import 'feed_api_detalhe.dart';


class FeedModuleDetalhe extends ModuleWidget {

  int _id;
  FeedModuleDetalhe(this._id);

  @override
  List<Bloc> get blocs =>[
    Bloc((i) => FeedBlocDetalhe(i.getDependency<FeedApiDetalhe>())),
  ];

  @override
  Widget get view => FeedWidgetDetalhe(_id);

  @override
  List<Dependency> get dependencies => [
    Dependency(_getFeedApiDetalhe),
  ];

  FeedApiDetalhe _getFeedApiDetalhe(Inject i) {
    return FeedApiDetalhe();
  }

  static Inject get to {
    return Inject<FeedModuleDetalhe>.of();
  }
}
