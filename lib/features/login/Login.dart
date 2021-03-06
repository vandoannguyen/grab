import 'package:flutter/material.dart';
import 'package:grab_demo/features/driver/driver_home/DriverHome.dart';
import 'package:grab_demo/features/login/signup.dart';
import 'package:grab_demo/features/user/home_view/main_view.dart';
import 'package:grab_demo/repository/loginReposiory.dart';
import 'package:grab_demo/ultis/IntentUltis.dart';

import 'LoginContract.dart';
import 'LoginPresenter.dart';

class LoginView extends StatelessWidget implements LoginContract {
  PageController _pageController;
  LoginPresenter _presenter;
  LoginRepository _loginRepository;
  LoginView() {
    _pageController = new PageController(
      initialPage: 0,
      keepPage: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    _loginRepository = new LoginRepository();
    _presenter = new LoginPresenter(_loginRepository, this, context);
    // TODO: implement build
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          Login(
            _pageController,
            _presenter,
          ),
          SignUp(_pageController, _presenter),
        ],
      ),
    );
  }

  @override
  void loginStatus(status) {
    // TODO: implement loginStatus
  }

  @override
  void showError(mes) {
    // TODO: implement showError
  }

  @override
  void updateData(data) {
    // TODO: implement updateData
  }
}

class Login extends StatefulWidget {
  PageController pageController;
  LoginPresenter presenter;
  Login(this.pageController, this.presenter);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginRepository _loginRepository;
  String _email, _pass;
  bool _showAlertPass, _showAlertEmail;
  _LoginViewState() {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var showButtonLogin = true;
    return Container(
      color: Colors.green,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 90,
                    child: Image.asset("assets/images/hdpi/ic_logo.png"),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        onChanged: (value) {
                          _email = value;
                        },
                        maxLines: 1,
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black87, fontSize: 18),
                        decoration:
                            InputDecoration.collapsed(hintText: "Email"),
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        onChanged: (value) {
                          _pass = value;
                        },
                        maxLines: 1,
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black87, fontSize: 18),
                        decoration:
                            InputDecoration.collapsed(hintText: "Password"),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
//                            if (check())
                            widget.presenter.loginNomal(
                                {'email': _email, 'password': _pass});
                            if (_email == "ok") {
                              IntentUtils.changeScreenNomal(
                                  context, DriverHome());
                            } else {
                              IntentUtils.changeScreenNomal(
                                  context, MainView());
                            }
//                        loginNomal()
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              "Đăng Nhập",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontFamily: "FontGrab"),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
//                          print(widget.pageController.jumpToPage(1));
                            widget.pageController.jumpToPage(1);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              "Đăng ký",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontFamily: "FontGrab"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
            Visibility(
              visible: showButtonLogin,
              child: Container(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        widget.presenter.loginWithGoogle();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              margin: EdgeInsets.only(right: 20),
                              child: Image.asset(
                                "assets/images/ic-google.png",
                                height: 50,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Đăng nhập bằng Google",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontFamily: "FontGrab"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("aaaaaaaaaaaaaaaaaaa");
                        widget.presenter.loginWithFacebook();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              margin: EdgeInsets.only(right: 20),
                              child: Image.asset(
                                "assets/images/ic-facebook.png",
                                height: 50,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Đăng nhập bằng Facebook",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontFamily: "FontGrab"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                height: 150,
                decoration: BoxDecoration(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pressLogIn() {}
  bool check() {
    if (_pass.length < 6 || !_email.contains("@")) {
      if (_pass.length < 6)
        setState(() {
          _showAlertPass = true;
        });
      if (!_email.contains("@"))
        setState(() {
          _showAlertEmail = true;
        });
      return false;
    }
    return true;
  }
}
