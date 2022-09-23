import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Aluno: Arthur Cordeiro Ferreira Souza
void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController quantidadeCafeController = TextEditingController() ;
  int _coffeType = 0;
  String _dadosPessoa = "";
  String _infoText = "";
  double _cafeinaTotal = 0.00;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields (){
    _formKey = GlobalKey<FormState>();
    quantidadeCafeController.text = "";
    setState (() {
      _infoText = "";
      _dadosPessoa = '';
    });
  }
  void _calculate (){
    setState (() {
      double quantidadeCafe = double.parse(quantidadeCafeController.text);

      if(_coffeType == 0){

        _cafeinaTotal = quantidadeCafe * 2;

      } else{

        _cafeinaTotal = quantidadeCafe * 0.68;
      }

      if(_dadosPessoa == "Gestantes e lactantes"){

        if(_cafeinaTotal > 200){

          _infoText = "Vai morrer antes do NATAL! MAS É UM SIGMA MAN!!!";

        } else {

          _infoText = "Saudável!! BETAAAA";
        }
      } else if(_dadosPessoa == "Crianças e Adolescentes"){

        if(_cafeinaTotal > 100){

          _infoText = "Vai morrer antes do NATAL! MAS É UM SIGMA MAN!!!";

        } else {

          _infoText = "Saudável!! BETAAAA";
        }
      } else if(_dadosPessoa == "Adultos"){

        if(_cafeinaTotal > 400){

          _infoText = "Vai morrer antes do NATAL! MAS É UM SIGMA MAN!!!";

        } else {

          _infoText = "Saudável!! BETAAAA";
        }
      } else if(_dadosPessoa == "Sensíveis a cafeína"){

        if(_cafeinaTotal > 200){

          _infoText = "Vai morrer antes do NATAL! MAS É UM SIGMA MAN!!!";

        } else {

          _infoText = "Saudável!! BETAAAA";
        }
      }else{
        _infoText = "Suas características não foram selecionadas!";
      }
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (

        title : Text("Cafeína do Cordeiro"),
        centerTitle : true ,
        backgroundColor: Colors .brown,
        actions : <Widget>[
          IconButton(icon: Icon(Icons . refresh ),
              onPressed: _resetFields),
        ],

      ) ,
      backgroundColor: Colors .white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment. stretch,
              children : <Widget>[

                Icon(Icons .coffee_rounded, size : 120.0, color : Colors .brown,)
                ,
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton(icon: const Icon(Icons.coffee_rounded),
                    isExpanded: true,
                    style: const TextStyle(color: Colors.brown, fontSize: 18),
                    dropdownColor: Colors.white,
                    items: const [
                      DropdownMenuItem(child: Text("Selecionar"), value: ""),
                      DropdownMenuItem(child: Text("Gestantes e lactantes"), value: "Gestantes e lactantes"),
                      DropdownMenuItem(child: Text("Crianças e Adolescentes"), value: "Crianças e Adolescentes"),
                      DropdownMenuItem(child: Text("Adultos"), value: "Adultos"),
                      DropdownMenuItem(child: Text("Sensíveis a cafeína"), value: "Sensíveis a cafeína"),
                    ],
                    value: _dadosPessoa,
                    onChanged: (String? value) {
                      if(value is String){

                        setState(() {
                          _dadosPessoa = value;
                        });
                      }
                    },),
                ),
                Center(
                  child: ToggleSwitch(
                    minWidth: 140.0,
                    initialLabelIndex: 0,
                    cornerRadius: 20.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    labels: [' Expresso', ' Coado'],
                    icons: [Icons.coffee, Icons.coffee],
                    activeBgColors: [[Colors.black],[Colors.brown]],
                    onToggle: (tipocafe) {

                      _coffeType = tipocafe!;

                    },
                  ),
                ),


                Center(
                  child: TextFormField (
                      keyboardType: TextInputType.number,

                      decoration : InputDecoration(
                        labelText : "Quantos Café??? (ml)",

                        labelStyle : TextStyle ( color :
                        Colors .brown,),
                      ),

                      style : TextStyle ( color : Colors .brown,
                          fontSize : 18.0),
                      controller : quantidadeCafeController,
                      validator: (value) {

                        if (value.toString().isEmpty) {
                          return " Insira a quantidade";
                        }
                        if (double.parse(value.toString())< 0) {
                          return " Insira um valor válido";
                        }


                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10.0, bottom:15.0),
                  child: Container(
                      height : 50.0,
                      child : ElevatedButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()) _calculate();
                        },
                        child : Text("Calcular", style : TextStyle ( color : Colors .white, fontSize : 16.0), ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors .brown
                        ),
                      )
                  ),
                ),
                Text(_infoText, textAlign : TextAlign. center ,style: TextStyle(fontSize: 20, color: Colors.brown),)
              ]
          ),
        ),
      ),
    );
  }
}
