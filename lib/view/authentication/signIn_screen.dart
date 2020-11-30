import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/viewmodel/home_modelView.dart';

class LoginScreen extends StatelessWidget {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey[900],
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), child: BuildAppBar()),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 33),
              ),
              Text(
                'please login to your account',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 23),
              ),
              SizedBox(
                height: 20,
              ),
              InputForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class InputForm extends StatelessWidget {
  String _email;
  String _password;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email Address',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => _email = value,
            onFieldSubmitted: (value) {
              _email = value;
            },
            validator: (value) {
              if (value.isEmpty ||
                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                return 'Enter a valid email!';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          //text input
          TextFormField(
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text('Forgot?'),
              ),
              labelText: 'Password',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white),
            ),
            keyboardType: TextInputType.visiblePassword,
            onFieldSubmitted: (value) => _password = value,
            onChanged: (value) => _password = value,
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter a valid password!';
              }
              return null;
            },
          ),
          SizedBox(
            height: 40,
          ),
          RaisedButton(
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              padding: EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 120.0,
              ),
              child: Text(
                "LOGIN",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              onPressed: () {
                EasyLoading.show(status: 'loading...');
                  Provider.of<HomePageViewModel>(context, listen: false)
                      .signInSubmit(_formKey, _email, _password).then((value) => EasyLoading.dismiss()); //_submit(),
         }
         ),
          SizedBox(
            height: 20,
          ),
          GoogleSignIn(),
          SizedBox(
            height: 70,
          ),
          Text(
            "Dont't have an account?",
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () => Provider.of<HomePageViewModel>(context, listen: false)
                .toggleScreen(), //toggleScreen(),
            child: Text(
              'Create Account',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class GoogleSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        Provider.of<HomePageViewModel>(context, listen: false)
            .signInWithGoogle();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/images/google_logo.png"),
                height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BuildAppBar extends StatelessWidget {
  const BuildAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueGrey[900],
      actions: [
        InkWell(
            onTap: () =>Provider.of<HomePageViewModel>(context, listen: false).skipAuthentication(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Text('Skip'),
              ),
            )),
      ],
    );
  }
}
