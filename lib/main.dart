import 'package:flutter/material.dart';
import 'UI/pages/authorization/login_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/login_bloc/login_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      checkerboardOffscreenLayers: true,
      title: "Мои визитки",
      theme: ThemeData(primaryColor: Colors.purple),
      home: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc()..add(CheckSavedData()),
        child: LoginScreen(),
      ),
    );
  }
}
