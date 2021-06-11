import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social/app/screens/feed/feed_api.dart';
import 'package:social/app/shared/models/sprint.dart';

import 'feed_api_detalhe.dart';


class FeedBlocDetalhe extends BlocBase {
  final FeedApiDetalhe _api;
  FeedBlocDetalhe(this._api);

  final _feedFetcher = PublishSubject<Sprint>();
  final _loading = BehaviorSubject<bool>();

  Stream<Sprint> get posts => _feedFetcher.stream;
  Stream<bool> get loading {
    return _loading.stream;
  }

  doFetchDetalhe(int id) async {
    _loading.sink.add(true);
    final sprint = await _api.fetchPosts(id);
    _loading.sink.add(false);
    _feedFetcher.sink.add(sprint);
  }

  @override
  void dispose() {
    _feedFetcher.close();
    _loading.close();
    super.dispose();
  }

}
