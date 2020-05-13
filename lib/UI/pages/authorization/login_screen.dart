import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobyte_mmcs_cards/blocs/login_bloc/login_bloc.dart';
import 'package:mobyte_mmcs_cards/blocs/registry_bloc/registry_bloc.dart';
import '../../../blocs/profile_bloc/profile_bloc.dart';
import '../body/neo_profile.dart';
import '../body/nm_box.dart';
import './registry.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _login = TextEditingController();
  final _password = TextEditingController();
  final TextStyle style = TextStyle(
      color: fCL,
      fontFamily: 'Montserrat',
      fontSize: 25,
      fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double padding = height * 0.038;
    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    final loginField = Padding(
      padding:
          EdgeInsets.symmetric(horizontal: padding, vertical: padding * 0.5),
      child: Container(
        decoration: nMboxInvert,
        child: TextFormField(
          obscureText: false,
          style: style,
          keyboardType: TextInputType.text,
          controller: _login,
          decoration: InputDecoration(
              filled: true,
              fillColor: mCD,
              hintText: 'Login',
              hintStyle: TextStyle(color: tIF),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              )),
        ),
      ),
    );

    final passwordField = Padding(
      padding:
          EdgeInsets.symmetric(horizontal: padding, vertical: padding * 0.5),
      child: Container(
        decoration: nMboxInvert,
        child: TextFormField(
          obscureText: true, //Hiding an input text
          style: style,
          keyboardType: TextInputType.visiblePassword,
          controller: _password,
          decoration: InputDecoration(
            filled: true,
            fillColor: mCD,
            hintText: 'Password',
            hintStyle: TextStyle(color: tIF),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        ),
      ),
    );

    final _enterButton = Padding(
      padding:
          EdgeInsets.symmetric(horizontal: padding, vertical: padding * 0.5),
      child: Container(
        width: width * 0.8,
        height: height * 0.08,
        decoration: nMbox.copyWith(
            shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(25)),
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          onPressed: () {
            loginBloc
                .add(CheckLogin(login: _login.text, password: _password.text));
          },
          child: Center(
            child: Text("Войти",
                textAlign: TextAlign.center,
                style: style.copyWith(color: fCL, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );

    final _registry = Padding(
      padding:
          EdgeInsets.symmetric(horizontal: padding, vertical: padding * 0.5),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
        width: width * 0.8,
        height: height * 0.08,
        decoration: nMbox.copyWith(
            shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(25)),
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          onPressed: () {
            loginBloc.add(SwitchToReg());
          },
          child: Center(
            child: Text("Регистрация",
                textAlign: TextAlign.center,
                style: style.copyWith(color: fCL, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );

    List<Widget> _mapStateToScreen({LoginBloc loginBloc}) {
      final LoginState currentState = loginBloc.state;
      if (currentState is Login) {
        return [
          if (currentState.failed)
            Text("Такой аккаунт не найден.",
                style: TextStyle(color: Colors.red, fontSize: 24)),
          SizedBox(height: 30),
          loginField,
          passwordField,
          SizedBox(height: 30),
          _enterButton,
          _registry,
        ];
      }
      if (currentState is Check)
        return [
          Text("Обработка данных..."),
          SizedBox(
            height: 10,
          ),
          CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
              Color(0xff99D3F4),
            ),
          ),
        ];
      return [];
    }

    return SafeArea(
      maintainBottomViewPadding: true,
      top: true,
      child: Scaffold(
        backgroundColor: mC,
        body: Center(
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is SwitchToRegState) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider<RegistryBloc>(
                      create: (context) => RegistryBloc(),
                      child: Registry(),
                    ),
                  ),
                );
              }
              if (state is LoginSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider<ProfileBloc>(
                      create: (context) => ProfileBloc(user: state.user)
                        ..add(ProfileUpdate(state.user)),
                      child: (MyNeoApp()),
                    ),
                  ),
                );
              }
            },
            child:
                BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _mapStateToScreen(loginBloc: loginBloc),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
