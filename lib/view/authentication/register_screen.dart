import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/viewmodel/home_modelView.dart';

class RegisterScreen extends StatelessWidget {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Account ',
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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _userName = '';
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'User Name',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => _userName = value,
            onFieldSubmitted: (value) {
              //Validator
              _userName = value;
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter a valid user name!';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email Address',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => _email = value,
            onFieldSubmitted: (value) {
              //Validator
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
              labelText: 'Password',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white),
            ),
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) => _password = value,
            onFieldSubmitted: (value) {
              _password = value;
            },
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
              "REGISTER",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            onPressed: () =>Provider.of<HomePageViewModel>(context,listen: false)
            .registerInSubmit(_formKey,_email,_password,_userName),
          ),
          SizedBox(
            height: 20,
          ),
          GoogleSignIn(),
          SizedBox(
            height: 70,
          ),
          Text(
            'Already have an account?',
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () => Provider.of<HomePageViewModel>(context,listen: false).toggleScreen(),
            child: Text(
              'Login',
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
  const GoogleSignIn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {},
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
                'Sign Up with Google',
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
