import 'package:flutter/cupertino.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class FeedWidgetAdiciona extends StatefulWidget {

  @override
  _FeedDetalheAdicionatState createState() => _FeedDetalheAdicionatState();

}

class _FeedDetalheAdicionatState extends State<FeedWidgetAdiciona> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Item"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Nome",
              ),
              // controller: xxxx,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Link",
              ),
              // controller: xxxx,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextButton(
              // color: Theme.of(context).primaryColor,
              child: Text(
                "Adcionar",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  // bloc.xxxx();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

}