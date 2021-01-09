import 'dart:async';
import 'dart:convert';
import 'package:avaliacao/Api/Api.dart';
import 'package:avaliacao/Api/RepositoriosModel.dart';
import 'package:avaliacao/HomePage/Componentes/ViewsRepositorios.dart';
import 'package:avaliacao/Utils/ResponsiveText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ResponsiveText _responsiveText = ResponsiveText();
  var repositorios = List<Repositorios>();
  final _streamController = StreamController<List>();

  _getDadosRepositorios() {
    Api.getDadosRepositorios().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        repositorios =
            lista.map((e) => Repositorios.fromJson(e)).toList();
        _streamController.add(lista);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDadosRepositorios();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15,top: 25),
            child: Text('Lista de repositórios',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: _responsiveText.getValue(
                  valor: size.width * .08,
                  min: 30,
                  max: 33
                ),
              ),
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  //topLeft: Radius.circular(75.0),
                  topRight: Radius.circular(95.0)
              ),
            ),
            child: StreamBuilder(
              stream: _streamController.stream,
              builder: (context, snapshot){
                switch (snapshot.connectionState){
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if(snapshot.hasError){
                      return Center(
                        child: Text('Erro ao carregar dados'),
                      );
                    }else{
                      return ListView.builder(
                          itemCount: repositorios.length,
                          itemBuilder: (context,index){
                            return Views(
                              url: repositorios[index].htmlUrl,
                              nomeRepo: repositorios[index].name,
                              nomePessoa: repositorios[index].owner.login,
                              perfil: repositorios[index].owner.avatarUrl,
                            );
                          });
                    }
                }
              },
            )
          )
        ],
      ),
    );
  }
}
