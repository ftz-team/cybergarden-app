import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'UI/containers/Auth/RegisterPage.dart';
import 'UI/containers/LoadingScreen.dart';
import 'UI/containers/navigator.dart';
import 'data/repository/default.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Мусорок',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: UIColors.background,
        fontFamily: 'Gilroy'
      ),
      home: MyHomePage(title: 'Мусорок'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool loading = true;
  bool logged = false;


  Future<bool> init() async{
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: "USER_TOKEN");
    print(token);
    if (null == token){
      return false;
    }
    var res = await isTokenValid(token);
    if (!res){
      return false;
    }
    return true;
  }

  @override
  void initState(){

    super.initState();
    init().then((value) => this.setState(() {
      print(value);
      if (value){
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => AppNavigator()));
      }else{
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => RegisterPage()));
      }
    }));


  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen();
  }
}
