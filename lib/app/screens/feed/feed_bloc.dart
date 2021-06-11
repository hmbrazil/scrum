import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social/app/screens/feed/feed_api.dart';
import 'package:social/app/shared/models/sprint.dart';


class FeedBloc extends BlocBase {
  final FeedApi _api;
  FeedBloc(this._api);

  final _feedFetcher = PublishSubject<List<Sprint>>();
  final _loading = BehaviorSubject<bool>();

  Stream<List<Sprint>> get posts => _feedFetcher.stream;
  Stream<bool> get loading {
    return _loading.stream;
  }

  doFetch() async {
    _loading.sink.add(true);
    final sprint = await _api.fetchPosts();
    sprint.shuffle();
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
