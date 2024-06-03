import 'package:flutter/material.dart';
import 'package:sis_med/models/cadastro.dart';
import 'pages/PrincipalPage.dart'; // Certifique-se de que o caminho esteja correto
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';


void main() async{
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
       const keyApplicationId = 'E6HNaApKj5z8wWPcdkurSNblLJHGRiR3ojGj3Shl';
       const keyClientKey = 'dZmKErTwnzs3EqGw1NaQPNoZcvAsIG4G4RQh0Zx3';
       const keyParseServerUrl = 'https://parseapi.back4app.com';

       await Parse().initialize(keyApplicationId, keyParseServerUrl,
               clientKey: keyClientKey, autoSendSessionId: true);



}

class MyApp extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PrincipalPage(), // Chamando a tela principal
    );
  }






}

