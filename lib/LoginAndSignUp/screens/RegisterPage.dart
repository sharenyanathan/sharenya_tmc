import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmc/LoginAndSignUp/controller/LoginController.dart';
import 'package:tmc/LoginAndSignUp/modals/SignupuData.dart';
import 'package:tmc/LoginAndSignUp/screens/LoginPage.dart';
import 'package:tmc/constants/colors.dart';
import 'package:tmc/constants/buttonStyles.dart';
import 'package:tmc/screens/inputDecoration.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double height, width;

  String username = '';

  String confirmUsername = '';

  String password = '';

  String confirmPassword = '';

  final _formKey = GlobalKey<FormState>();

  var signUpController;

  FocusNode _emailFieldFocus = FocusNode();

  FocusNode _passwordFieldFocus = FocusNode();

  Color _emailColor = Colors.white;

  Color _emailLabelColor = Colors.grey;

  Color _passwordColor = Colors.white;

  Color _passwordLabelColor = Colors.grey;

  bool _obscureText = true;

  showRegisteredDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Container();
      },
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.0),
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              contentPadding: EdgeInsets.zero,
              content: Container(
                height: MediaQuery.of(context).size.height,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Successfully registered! Please log in with registered username and password.',
                        style: TextStyle(color: Color(0xff95FF85)),
                      ),
                    ],
                  )),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
    );
  }

  doSignUp() async {
    if (password == confirmPassword) {
      // showCustomFlushBar(context, "Logging you In...", 3);
      // loginData = new LoginData(email: email, password: password);
      // showCustomFlushBar(context, "Logging you In...", 3);
      String isAuthorized = await signUpController.signup(SignupData(
        username: username,
        password: password,
      ));

      print(isAuthorized.toString());
      if (isAuthorized != "Error") {
        if (isAuthorized == "User Created") {
          // showCustomFlushBar(context, "User Created :)", 2);
          Navigator.of(context).pushReplacement(
              PageRouteBuilder(pageBuilder: (_, __, ___) => new LoginPage()));
          showRegisteredDialog();
        } else if (isAuthorized == "User already exists!") {
          // showCustomFlushBar(context, "User Already Exists!", 2);
        }
      } else {
        print('Not Logged IN');

        // showCustomFlushBar(context, "Something went wrong :(", 2);
      }
    } else {
      // showCustomFlushBar(context, "Password does not match !", 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    signUpController = Provider.of<LoginController>(context);
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 35, 2, 8),
            child: Image.asset(
              'assets/branding/atx_logo.png',
              height: 100,
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/background.jpg',
                ),
                fit: BoxFit.fill)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TRANSACTION MONITORING CENTER',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
              Container(
                width: 260,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // email password
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: TextFormField(
                                // validator: (val) {
                                //   return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(val) ||
                                //           RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                //                   r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                //                   r"{0,253}[a-zA-Z0-9])?)*$")
                                //               .hasMatch(val)
                                //       ? null
                                //       : "Please provide valid number or Email ID";
                                // },
                                onChanged: (value) => username = value,
                                cursorColor: Colors.grey,
                                focusNode: _emailFieldFocus,

                                style: TextStyle(
                                  color: _emailLabelColor,
                                  fontSize: 18,
                                ),
                                decoration: getInputDecoration(
                                    "Username",
                                    _emailColor,
                                    _emailLabelColor,
                                    Icon(
                                      Icons.person,
                                      size: 18,
                                      color: _emailLabelColor,
                                    ),
                                    null),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: TextFormField(
                                // validator: (val) {
                                //   return RegExp("^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).*")
                                //           .hasMatch(val)
                                //       ? null
                                //       : "Input Valid Password";
                                // },
                                onChanged: (value) => password = value,
                                cursorColor: Colors.grey,
                                obscureText: _obscureText,
                                focusNode: _passwordFieldFocus,
                                style: TextStyle(
                                  color: _passwordLabelColor,
                                  fontSize: 18,
                                ),
                                decoration: getInputDecoration(
                                    "Password",
                                    _passwordColor,
                                    _passwordLabelColor,
                                    Icon(
                                      Icons.lock,
                                      size: 18,
                                      color: _passwordLabelColor,
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: _obscureText
                                              ? _passwordLabelColor
                                              : Colors.grey[500],
                                        ))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: TextFormField(
                                // validator: (val) {
                                //   return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(val) ||
                                //           RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                //                   r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                //                   r"{0,253}[a-zA-Z0-9])?)*$")
                                //               .hasMatch(val)
                                //       ? null
                                //       : "Please provide valid number or Email ID";
                                // },
                                onChanged: (value) => confirmUsername = value,
                                cursorColor: Colors.grey,

                                style: TextStyle(
                                  color: _emailLabelColor,
                                  fontSize: 18,
                                ),
                                decoration: getInputDecoration(
                                    "Confirm Username",
                                    _emailColor,
                                    _emailLabelColor,
                                    Icon(
                                      Icons.person,
                                      size: 18,
                                      color: _emailLabelColor,
                                    ),
                                    null),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: TextFormField(
                                // validator: (val) {
                                //   return RegExp("^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).*")
                                //           .hasMatch(val)
                                //       ? null
                                //       : "Input Valid Password";
                                // },
                                onChanged: (value) => confirmPassword = value,
                                cursorColor: Colors.grey,
                                obscureText: _obscureText,
                                style: TextStyle(
                                  color: _passwordLabelColor,
                                  fontSize: 18,
                                ),
                                decoration: getInputDecoration(
                                    "Confirm Password",
                                    _passwordColor,
                                    _passwordLabelColor,
                                    Icon(
                                      Icons.lock,
                                      size: 18,
                                      color: _passwordLabelColor,
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: _obscureText
                                              ? _passwordLabelColor
                                              : Colors.grey[500],
                                        ))),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: ElevatedButton(
                                    style: raisedButtonStyle,
                                    onPressed: () {
                                      doSignUp();
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: ElevatedButton(
                                    style: raisedButtonStyle,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                    },
                                    child: Text(
                                      'Back to Login',
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
