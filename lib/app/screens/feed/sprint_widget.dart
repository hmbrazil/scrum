import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social/app/screens/feed/components/sprint/sprint_bloc.dart';
import 'package:social/app/screens/feed/components/sprint/sprint_module.dart';
import 'package:social/app/screens/feed/feed_module_detalhe.dart';
import 'package:social/app/shared/models/sprint.dart';
import 'sprint_widget_create.dart';

class SprintWidget extends StatelessWidget {

late final SprintBloc _bloc = SprintModule.to.getBloc<SprintBloc>();

  @override
  Widget build(BuildContext context) {
    _bloc.doFetchListAll();
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista'),
      ),
      body: StreamBuilder(
        stream: _bloc.postsList,
        builder: (context, AsyncSnapshot<List<Sprint>> snapshot) {
          if (snapshot.hasData) {
            final sprints = snapshot.data!;
            return ListView.separated(
              itemCount: sprints.length,
              itemBuilder: (_, index) {
                final sprint = sprints[index];
                return
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeedModuleDetalhe(sprint.id, 1)
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(sprint.nome),
                        subtitle: Text(sprint.link),
                      ),
                    ),
                  );
              },
              separatorBuilder: (_, __) => Divider(),
            );
          }

          return StreamBuilder(
            stream: _bloc.loading,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              final loading = snapshot.data ?? false;
              if (loading) {
                return Center(child: CircularProgressIndicator());
              }
              return Container();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen(context);
        },
        tooltip: 'Adiciona item',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

_navigateToAddScreen (BuildContext context) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SprintWidgetCreate()),
  );
}
