import 'package:flutter/material.dart';
import 'package:login_app/models/loginform_model.dart';
import 'package:login_app/models/signupform_model.dart';
import 'package:login_app/utils/constants.dart';
import 'package:login_app/widgets/form_widgets.dart';
import 'package:login_app/widgets/loginform_widget.dart';
import 'package:login_app/widgets/signupform_widget.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  static const int TABS_COUNT = 2;
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // multiprovider
      providers: [
        ChangeNotifierProvider.value(
            value: LoginFormModel()), // login form model
        ChangeNotifierProvider.value(
            value: SignupFormModel()), // signup form model
      ],
      child: Builder(builder: (context) {
        return DefaultTabController(
          length: OnBoardingScreen.TABS_COUNT, // the total numbers of tabs
          child: Scaffold(
            appBar: buildAppBar(),
            body: buildBody(),
          ),
        );
      }),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        StringConstants.ONBOARDING_SCREEN_TITLE, // title of screen
      ),
      bottom: TabBar(
        tabs: [
          TabBarTab(title: StringConstants.LOGIN_TXT), // login tab
          TabBarTab(title: StringConstants.SIGNUP_TXT), // signup tab
        ],
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: DimConstants.BODY_PADDING, // body padding for screens
      child: TabBarView(
        children: [
          // tabviews
          Consumer<LoginFormModel>(
            builder: (context, loginFormModel, _) {
              return LoginFormWidget(loginFormModel); // login form
            },
          ),
          Consumer<SignupFormModel>(
            builder: (context, signupFormModel, _) {
              return SignupFormWidget(signupFormModel); // sign up form
            },
          ),
        ],
      ),
    );
  }
}
