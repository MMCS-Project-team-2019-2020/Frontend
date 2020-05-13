import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobyte_mmcs_cards/UI/pages/body/nm_box.dart';
import 'package:mobyte_mmcs_cards/blocs/login_bloc/login_bloc.dart';
import 'package:mobyte_mmcs_cards/blocs/registry_bloc/registry_bloc.dart';
import '../../../blocs/profile_bloc/profile_bloc.dart';
import '../body/neo_profile.dart';
import 'login_screen.dart';

String _name = "";
String _surname = "";
String _patronymic = "";
String _company = "";
String _position = "";
String _mail = "";
String _phone = "";
String _login = "";
String _password = "";

class Registry extends StatefulWidget {
  @override
  _RegistryState createState() => _RegistryState();
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}

class _RegistryState extends State<Registry> {
  final TextStyle style = TextStyle(
      color: fCL,
      fontFamily: 'Montserrat',
      fontSize: 25,
      fontWeight: FontWeight.bold);

  @override
  void initState() => super.initState();
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double padding = height * 0.038;
    RegistryBloc regBloc = BlocProvider.of<RegistryBloc>(context);

    final _loginField = Container(
        padding:
            EdgeInsets.symmetric(horizontal: padding, vertical: padding * 0.5),
        child: Column(
          children: [
            Container(
              decoration: nMboxInvert,
              child: TextFormField(
                style: style,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  _login = value;
                },
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
          ],
        ));

    final _passwordField = Container(
        padding:
            EdgeInsets.symmetric(horizontal: padding, vertical: padding * 0.5),
        child: Column(
          children: [
            Container(
              decoration: nMboxInvert,
              child: TextFormField(
                style: style,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  _password = value;
                },
                onSaved: (value) {
                  setState(() {});
                },
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
                    )),
              ),
            ),
          ],
        ));

    final _nSPField = Container(
      padding:
          EdgeInsets.symmetric(horizontal: padding, vertical: padding * 0.5),
      child: Column(
        children: [
          Container(
            decoration: nMboxInvert,
            child: TextFormField(
              style: style,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                _surname = value;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: mCD,
                  hintText: 'Фамилия',
                  hintStyle: TextStyle(color: tIF),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  )),
            ),
          ),
          Padding(padding: EdgeInsets.all(22)),
          Container(
            decoration: nMboxInvert,
            child: TextFormField(
              style: style,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                _name = value;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: mCD,
                  hintText: 'Имя',
                  hintStyle: TextStyle(color: tIF),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  )),
            ),
          ),
          Padding(padding: EdgeInsets.all(22)),
          Container(
            decoration: nMboxInvert,
            child: TextFormField(
              style: style,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                _patronymic = value;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: mCD,
                  hintText: 'Отчество',
                  hintStyle: TextStyle(color: tIF),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  )),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    );

    final _loginAndPasswordField = Column(
      children: [
        _loginField,
        Padding(padding: EdgeInsets.all(10)),
        _passwordField,
        Padding(padding: EdgeInsets.all(10))
      ],
    );

    final _phoneAndEmail = Container(
      padding:
          EdgeInsets.symmetric(horizontal: padding, vertical: padding * 0.5),
      child: Column(
        children: [
          Container(
            decoration: nMboxInvert,
            child: TextFormField(
              style: style,
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                _phone = value;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: mCD,
                  hintText: 'Номер телефона',
                  hintStyle: TextStyle(color: tIF),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  )),
            ),
          ),
          Padding(padding: EdgeInsets.all(22)),
          Container(
            decoration: nMboxInvert,
            child: TextFormField(
              style: style,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _mail = value;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: mCD,
                  hintText: 'Электронная почта',
                  hintStyle: TextStyle(color: tIF),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  )),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    );

    final _companyAndPosition = Container(
      padding:
          EdgeInsets.symmetric(horizontal: padding, vertical: padding * 0.5),
      child: Column(
        children: [
          Container(
            decoration: nMboxInvert,
            child: TextFormField(
              style: style,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                _company = value;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: mCD,
                  hintText: 'Место работы',
                  hintStyle: TextStyle(color: tIF),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  )),
            ),
          ),
          Padding(padding: EdgeInsets.all(22)),
          Container(
            decoration: nMboxInvert,
            child: TextFormField(
              style: style,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                _position = value;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: mCD,
                  hintText: 'Должность',
                  hintStyle: TextStyle(color: tIF),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  )),
            ),
          ),
          Padding(padding: EdgeInsets.all(15)),
        ],
      ),
    );

    final _register = Padding(
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
            regBloc.add(CheckFields(
              name: _name,
              password: _password,
              login: _login,
              company: _company,
              patronymic: _patronymic,
              mail: _mail,
              phone: _phone,
              position: _position,
              surname: _surname,
            ));
          },
          child: Center(
            child: Text("Создать",
                textAlign: TextAlign.center,
                style: style.copyWith(color: fCL, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
    final _cancel = Padding(
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
          onPressed: () => regBloc.add(BackToLogin()),
          child: Center(
            child: Text("Отмена",
                textAlign: TextAlign.center,
                style: style.copyWith(color: fCL, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
    final _buttons = Column(
      children: [_register, _cancel],
    );

    Widget _mapStateToWidget(RegistryBlocState state) {
      if (state is RegProccess)
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Идёт обработка данных..."),
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
              Color(0xff99D3F4),
            )),
          ],
        );

      if (state is RegistryInitial) {
        return Column(
          children: [
            _loginAndPasswordField,
            _nSPField,
            _phoneAndEmail,
            _companyAndPosition,
            _buttons,
          ],
        );
      }
      if (state is RegistryFailed) {
        return Column(
          children: [
            Text(
              'Ошибка!\nПроверьте, корректно ли заполнены все поля и повторите попытку.',
              style: TextStyle(fontSize: 24, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            _loginAndPasswordField,
            _nSPField,
            _phoneAndEmail,
            _companyAndPosition,
            _buttons,
          ],
        );
      }
    }

    return SafeArea(
      maintainBottomViewPadding: true,
      top: true,
      child: Scaffold(
          backgroundColor: mC,
          body: Center(
            child: BlocListener<RegistryBloc, RegistryBlocState>(
                listener: (context, state) {
              if (state is GoInside) {
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
              if (state is GoToLogin) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider<LoginBloc>(
                      create: (context) => LoginBloc(),
                      child: (LoginScreen()),
                    ),
                  ),
                );
              }
            }, child: BlocBuilder<RegistryBloc, RegistryBlocState>(
              builder: (context, state) {
                return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: _mapStateToWidget(regBloc.state));
              },
            )),
          )),
    );
  }
}
