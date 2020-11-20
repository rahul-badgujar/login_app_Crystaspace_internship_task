import 'package:flutter/material.dart';
import 'package:login_app/models/loginform_model.dart';
import 'package:login_app/models/signupform_model.dart';
import 'package:login_app/utils/constants.dart';
import 'package:login_app/widgets/loginform_widget.dart';
import 'package:login_app/widgets/signupform_widget.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LoginFormModel()),
        ChangeNotifierProvider.value(value: SignupFormModel()),
      ],
      child: Builder(builder: (context) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: buildAppBar(),
            body: buildBody(),
          ),
        );
      }),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: TabBarView(
        children: [
          Consumer<LoginFormModel>(
            builder: (context, loginFormModel, _) {
              return LoginFormWidget(loginFormModel);
            },
          ),
          Consumer<SignupFormModel>(
            builder: (context, signupFormModel, _) {
              return SignupFormWidget(signupFormModel);
            },
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        StringConstants.ONBOARDING_SCREEN_TITLE,
      ),
      bottom: TabBar(
        tabs: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
