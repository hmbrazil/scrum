import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social/app/screens/feed/feed_module_detalhe.dart';
import 'package:social/app/screens/feed/components/sprint/sprint_bloc.dart';
import 'package:social/app/shared/models/sprint.dart';
import 'feed_module_delete.dart';

class SprintWidgetDetail extends StatelessWidget {

  late final SprintBloc _bloc = FeedModuleDetalhe.to.getBloc<SprintBloc>();
  late final SprintBloc _bloc2 = FeedModuleDelete.to.getBloc<SprintBloc>();

  final int id;
  final int opcao;
  SprintWidgetDetail(this.id, this.opcao);

  @override
  Widget build(BuildContext context) {


     if (opcao == 2) {
       _bloc2.doFetchDelete(id);
       // Navigator.push(
       //   context,
       //   MaterialPageRoute(
       //       builder: (context) => FeedModule()
       //   ),
       // );
     } else {
       _bloc.doFetchDetail(id);
     }
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhe'),
      ),
      body: StreamBuilder(
        stream: _bloc.posts,
        builder: (context, AsyncSnapshot<Sprint> snapshot) {
          if (snapshot.hasData) {
            final sprint = snapshot.data!;
            return Container(
              child: Column(
                children: [
                  InkWell(
                    child: ListTile(
                      title: Text(sprint.nome),
                      subtitle: Text(sprint.link),
                    ),
                  ),
                  Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FeedModuleDelete(sprint.id, 2)
                        ),
                      );
                    },
                    child: Text('Remover'),
                    ),
                  ),
                ],
              ),
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
    );
  }
}
