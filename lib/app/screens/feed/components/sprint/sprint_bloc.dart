import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social/app/screens/feed/components/sprint/sprint_api.dart';
import 'package:social/app/shared/models/sprint.dart';


class SprintBloc extends BlocBase {
  final SprintApi _api;
  SprintBloc(this._api);

  final _feedFetcherList = PublishSubject<List<Sprint>>();
  final _feedFetcher = PublishSubject<Sprint>();
  final _loading = BehaviorSubject<bool>();

  Stream<List<Sprint>> get postsList => _feedFetcherList.stream;
  Stream<Sprint> get posts => _feedFetcher.stream;
  Stream<bool> get loading {
    return _loading.stream;
  }

  doFetchListAll() async {
    _loading.sink.add(true);
    final sprint = await _api.fetchListAll();
    sprint.shuffle();
    _loading.sink.add(false);
    _feedFetcherList.sink.add(sprint);
  }

  doFetchCreate(Sprint sprint) async {
    _loading.sink.add(true);
    // final sprint = await _api.fetchCreate(sprint);
    _loading.sink.add(false);
    _feedFetcher.sink.add(sprint);
  }

  doFetchDelete(int id) async {
    _loading.sink.add(true);
    final sprint = await _api.fetchDelete(id);
    _loading.sink.add(false);
    _feedFetcher.sink.add(sprint);
  }

  doFetchDetail(int id) async {
    _loading.sink.add(true);
    final sprint = await _api.fetchDetail(id);
    _loading.sink.add(false);
    _feedFetcher.sink.add(sprint);
  }

  @override
  void dispose() {
    _feedFetcherList.close();
    _feedFetcher.close();
    _loading.close();
    super.dispose();
  }
}
