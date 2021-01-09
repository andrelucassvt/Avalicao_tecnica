import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Views extends StatefulWidget {
  String nomePessoa;
  String nomeRepo;
  String perfil;
  String url;
  Views({this.nomePessoa,this.nomeRepo,this.perfil,this.url});
  @override
  _ViewsState createState() => _ViewsState();
}

class _ViewsState extends State<Views> {
  _launchURL() async {
    if (await canLaunch(widget.url)) {
      await launch(widget.url);
    } else {
      throw 'Não foi possível lançar ${widget.url}';
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
        child: InkWell(
            onTap: () {
              _launchURL();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15),
                    child: Row(children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            image:
                            DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(widget.perfil))),
                      ),
                      SizedBox(width: 10.0),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(widget.nomeRepo,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),

                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 290,
                                maxWidth: 300
                              ),
                              child: Container(
                                width: size.width *.7,
                                child: Text(widget.nomePessoa,
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontFamily: 'Montserrat',
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ])
                    ])),
              ],
            )));
  }
}
