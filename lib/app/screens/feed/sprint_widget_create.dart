import 'package:flutter/material.dart';
import 'package:social/app/screens/feed/components/sprint/sprint_api.dart';
import 'package:social/app/shared/models/sprint.dart';

class SprintWidgetCreate extends StatelessWidget {

  final SprintApi api = SprintApi();
  final _addFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Cases'),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: 440,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                hintText: 'Nome',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _linkController,
                              decoration: const InputDecoration(
                                hintText: 'Link',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                // if (_addFormKey.currentState.validate()) {
                                //   _addFormKey.currentState.save();
                                  api.fetchCreate(Sprint(nome: _nameController.text, link: _linkController.text, id: 0));

                                  Navigator.pop(context) ;
                                },
                              // },
                              child: Text('Save', style: TextStyle(color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
              )
          ),
        ),
      ),
    );
  }
}