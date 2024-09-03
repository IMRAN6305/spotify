import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/presentation/auth/pages/singup.dart';

class Signin extends StatelessWidget {
  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            SizedBox(
              height: 50.0,
            ),
            SizedBox(
              height: 20,
            ),
            _emailField(context),
            SizedBox(
              height: 20,
            ),
            _passwordFiled(context),
            SizedBox(
              height: 20,
            ),
            BasicAppButton(
              onPressed: (){},
              title: "Sign In ",
            )
          ],
        ),
      ),
      bottomNavigationBar: _singuptext(context),
    );
  }

  Widget _registerText() {
    return Text(
      'Sign In',
      style: TextStyle(
          fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
      textAlign: TextAlign.center,
    );
  }


  Widget _emailField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(hintText: "Enter Email")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordFiled(BuildContext context) {
    return TextField(
      decoration: InputDecoration(hintText: "Enter password")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }
  Widget _singuptext(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Not a Member?',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14
          ),),
          TextButton(onPressed: (){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Singup(),
                ));
          }, child: Text('Register Now'))

        ],
      ),
    );
  }
}
