import 'package:flutter/material.dart';
import '../pages/forget_password_approved.dart';
import '../pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Lexend",
      ),
      home: const MyLoginPage(),
    );
  }
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() {
    if (_validateAndSave()) {
      // TODO: Perform sign-up logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff350080),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(size.width * 0.04),
            height: size.height * 0.87,
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                    size.width * 0.356,
                    size.height * 0.12,
                    0,
                    size.height * 0.002,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Şifre',
                    style: TextStyle(
                      fontSize: size.width * 0.084,
                      fontFamily: "Lexend",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                    size.width * 0.275,
                    size.height * 0.002,
                    size.width * 0.23,
                    size.height * 0.005,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Sıfırlama',
                    style: TextStyle(
                      fontSize: size.width * 0.084,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Lexend",
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                    size.width * 0.1,
                    size.height * 0.02,
                    size.width * 0.1,
                    size.height * 0.04,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'E-Posta Adresini girerek şifre sıfırlaman için gereken kurtarma koduna erişebilirsin.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      fontFamily: "Lexend",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                    size.width * 0.01,
                    0,
                    size.width * 0.04,
                    size.height * 0.005,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'E-MAIL',
                    style: TextStyle(
                      fontSize: size.width * 0.03,
                      fontFamily: "Lexend",
                      letterSpacing: 2,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: size.width * 0.04),
                        height: size.height * 0.04,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(
                              size.width * 0.02,
                              0,
                              size.width * 0.02,
                              size.height * 0.022,
                            ),
                            hintText: "E-Mail",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: size.width * 0.03,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: size.width * 0.6, // Buton genişliği ayarlandı
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70),
                                ),
                              ),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                  vertical: size.height * 0.02,
                                ),
                              ),
                              foregroundColor: MaterialStateProperty.all(
                                  const Color(0xffF4F4F4)),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xff39B54A)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordApproved()),
                              );
                            },
                            child: Text(
                              'E-Posta Gönder',
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.fromLTRB(0, size.height * 0.043, 0, 0),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 2.0),
                                child: Icon(
                                  Icons.chevron_left,
                                  size: size.width * 0.05,
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  'Giriş Ekranına Geri Dön',
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    fontFamily: "Lexend",
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyLoginPage()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
