import 'package:flutter/material.dart';
import '../pages/login_page.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextForm Controller
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLengthValid = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _doPasswordsMatch = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void _validatePassword(String password) {
    setState(() {
      _isLengthValid = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasLowercase = password.contains(RegExp(r'[a-z]'));
      _doPasswordsMatch = password == _confirmPasswordController.text;
    });
  }

  Icon _getValidationIcon(bool isValid) {
    return Icon(
      isValid ? Icons.check : Icons.close,
      color: isValid ? Colors.green : Colors.red,
      size: 20,
    );
  }

  // Form Validation
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  /*void _validateAndSubmit() {
    if (_validateAndSave()) {
      // TODO: Perform sign-up logic here
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: const Color(0xff350080),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: const Alignment(300, 50),
              padding: EdgeInsets.all(size.width * 0.04),
              height: size.height * 0.87,
              width: size.width * 1,
              decoration: const BoxDecoration(
                color: Color(0xffffffffff),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      size.width * 0.24,
                      size.height * 0.08,
                      size.width * 0,
                      size.height * 0.002,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Yeni Şifre',
                      style: TextStyle(
                        fontSize: size.width * 0.084,
                        fontFamily: "Lexend",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      size.width * 0.28,
                      size.height * 0.002,
                      size.width * 0.23,
                      size.height * 0,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Oluştur',
                      style: TextStyle(
                        fontSize: size.width * 0.084,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Lexend",
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      size.width * 0.14,
                      size.height * 0.02,
                      size.width * 0.14,
                      size.height * 0,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Bundan sonraki girişlerinde kullanmak için lüfen yeni şifre tanımla.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        fontFamily: "Lexend",
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      size.width * 0.02,
                      size.height * 0.02,
                      size.width * 0.04,
                      size.height * 0.005,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'ŞİFRE',
                      style: TextStyle(
                        fontSize: size.width * 0.03,
                        fontFamily: "Lexend",
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.04,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.1, color: Colors.black),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: TextField(
                      controller: _passwordController,
                      onChanged: _validatePassword,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(
                          size.width * 0.02,
                          0,
                          size.width * 0.02,
                          size.height * 0.022,
                        ),
                        hintText: "Şifre",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: size.width * 0.03,
                        ),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      size.width * 0.02,
                      size.height * 0.02,
                      size.width * 0.04,
                      size.height * 0.005,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'ŞİFRE (TEKRAR)',
                      style: TextStyle(
                        fontSize: size.width * 0.03,
                        fontFamily: "Lexend",
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.04,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.1, color: Colors.black),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: TextField(
                      controller: _confirmPasswordController,
                      onChanged: (value) =>
                          _validatePassword(_passwordController.text),
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(
                          size.width * 0.02,
                          0,
                          size.width * 0.02,
                          size.height * 0.022,
                        ),
                        hintText: "Şifre (Tekrar)",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: size.width * 0.03,
                        ),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          _getValidationIcon(_isLengthValid),
                          const SizedBox(
                              width: 4), // Decreased width for closer proximity
                          Text(
                            'En az 8 karakter olmalı',
                            style: TextStyle(
                              fontSize: size.width * 0.03,
                              color: _isLengthValid ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _getValidationIcon(_hasUppercase),
                          const SizedBox(
                              width: 4), // Decreased width for closer proximity
                          Text(
                            'En az bir büyük harf olmalı',
                            style: TextStyle(
                              fontSize: size.width * 0.03,
                              color: _hasUppercase ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _getValidationIcon(_hasLowercase),
                          const SizedBox(
                              width: 4), // Decreased width for closer proximity
                          Text(
                            'En az bir küçük harf olmalı',
                            style: TextStyle(
                              fontSize: size.width * 0.03,
                              color: _hasLowercase ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _getValidationIcon(_doPasswordsMatch),
                          const SizedBox(
                              width: 4), // Decreased width for closer proximity
                          Text(
                            'Şifreler aynı olmalı',
                            style: TextStyle(
                              fontSize: size.width * 0.03,
                              color:
                                  _doPasswordsMatch ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.01),
                  Container(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: const WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(70),
                            ),
                          ),
                        ),
                        fixedSize: WidgetStateProperty.all(
                          Size(size.width * 0.6, size.height * 0.07),
                        ),
                        foregroundColor:
                            const WidgetStatePropertyAll(Color(0xffF4F4F4)),
                        backgroundColor:
                            const WidgetStatePropertyAll(Color(0xff39B54A)),
                      ),
                      onPressed: () {
                        //_validateAndSubmit();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyLoginPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Tamamla',
                        style: TextStyle(
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
