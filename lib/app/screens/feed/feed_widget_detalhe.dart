import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social/app/screens/feed/feed_bloc.dart';
import 'package:social/app/screens/feed/feed_module.dart';
import 'package:social/app/screens/feed/feed_module_detalhe.dart';
import 'package:social/app/shared/models/sprint.dart';

import 'feed_bloc_detalhe.dart';
import 'feed_widget_adiciona.dart';
import 'feed_widget_detalhe.dart';

class FeedWidgetDetalhe extends StatelessWidget {

  late final FeedBlocDetalhe _bloc = FeedModuleDetalhe.to.getBloc<FeedBlocDetalhe>();

  FeedWidgetDetalhe(int id);
  late final String id = id;
  // Widget _postTitle(Post post) => Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     UserTitleWidget(post.user!),
  //     SizedBox(height: 8),
  //     Text(post.title),
  //     SizedBox(height: 24),
  //   ],
  // );

  @override
  Widget build(BuildContext context) {
     _bloc.doFetchDetalhe(id);
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
      ),
      body: StreamBuilder(
        stream: _bloc.posts,
        builder: (context, AsyncSnapshot<List<Sprint>> snapshot) {
          if (snapshot.hasData) {
            final sprints = snapshot.data!;
            return ListView.separated(
              itemCount: sprints.length,
              itemBuilder: (_, index) {
                final sprint = sprints[index];
                return
                  Card(
                    child: InkWell(
                      child: ListTile(
                        title: Text(sprint.nome),
                        subtitle: Text(sprint.link),
                      ),
                    ),
                  );
                // title: _postTitle(post),
                // subtitle: PostBodyWidget(post),
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
    MaterialPageRoute(builder: (context) => FeedWidgetAdiciona()),
  );
}