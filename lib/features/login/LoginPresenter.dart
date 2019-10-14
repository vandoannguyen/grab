import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:grab_demo/features/home_view/home/home_view.dart';
import 'package:grab_demo/repository/loginReposiory.dart';
import 'package:grab_demo/ultis/IntentUltis.dart';
import 'package:http/http.dart' as http;

import 'LoginContract.dart';

class LoginPresenter {
  final String _uri = "http://1.2.3.116:9000";
  LoginRepository _loginRepository;
  LoginContract loginContract;
  BuildContext context;
  LoginPresenter(this._loginRepository, this.loginContract, this.context);

  void loginNomal(value) {
    String username = value["email"];
    String password = value["password"];

    String basicAuth =
        "Basic " + base64Encode(utf8.encode('${username}:${password}'));
    print('basicAuth: ' + basicAuth);
    http.post(
      _uri + "/auth",
      headers: {"Authorization": basicAuth},
    ).then((reponse) {
      IntenUtils.changeScreenNomal(context, HomeScreen());
    }).catchError((err) {
      print(err);
    });
  }

  void loginWithFacebook() {
    _loginRepository.loginWithFace().then((value) {
      if (value['status'] == "ok") {
        http
            .post(_uri + "/auth/facebook?access_token=${value['result']}")
            .then((reponse) {
//          if (reponse.statusCode == 201) {
//            loginContract
//                .loginStatus({"status": 1, "mess": "Đăng nhập thành công"});
          print("reponse  ${reponse}  " + reponse.body);
//          } else {
//            loginContract.loginStatus({
//              "status": 0,
//              "mess": "Đăng nhập thất "
//                  "bại"
//            });
//          }
        });
        print(value['result']);
      }
    }).catchError((error) {
      print(error);
    });
  }

  void loginWithGoogle() {
    _loginRepository.loginWithGoogle().then((value) {
      if (value['status'] == "ok") {
        http
            .post(_uri + "/auth/google" + "?access_token=${value['result']}")
            .then((reponse) {
//          if (reponse.statusCode == 201) {
//            loginContract
//                .loginStatus({"status": 1, "mess": "Đăng nhập thành công"});
          print(reponse.body);
//          } else {
//            loginContract.loginStatus({
//              "status": 0,
//              "mess": "Đăng nhập thất "
//                  "bại"
//            });
//          }
        });
        print(value['result']);
      }
    }).catchError((error) {
      print(error);
    });
  }

  void signIn(value) {
    http.post(_uri + "/users", body: value).then((response) {
      print(response.body);
    }).catchError((err) => {print(err)});
  }
}
