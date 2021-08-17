import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  final loginAction;
  final String loginError;

  const Login(this.loginAction, this.loginError);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // stops: [0.2, 0.3],
            colors: [Colors.white, Colors.white10, Colors.black12, Colors.transparent],
          )
      ),
      child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(child: Padding(padding: EdgeInsets.only(top: 150.0)),),
            Image.asset('assets/images/logo/moder_logo.png', width: 250.0,),
            SizedBox(child: Padding(padding: EdgeInsets.only(top: 50.0),),),
            FlatButton(
              height: 45.0,
              onPressed: (){
                loginAction();
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (_){
                //       return loginAction();
                //     }
                // ));
              },
              child: Text("LOG IN", style: TextStyle(color: Colors.white, fontSize: 15.0),),
              color: Colors.orange,
              minWidth: 300.0,
            ),
            // Text("Copyright @ 2021 Peercore Nexgen pty Ltd - All Right Reserved", style: TextStyle(color: Colors.white, fontSize: 10.0,),)
          ],
        ),
      ),
    );
  }
}