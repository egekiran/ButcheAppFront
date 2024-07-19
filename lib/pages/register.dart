import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const RegisterPage());
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Lexend",
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('tr', 'TR'), // Türkçe locale ekleyin
      ],
      home: const MyRegisterPage(title: ''),
    );
  }
}

class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({super.key, required this.title});

  final String title;

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _dobController = TextEditingController();

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

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      locale: const Locale("tr", "TR"),
    );
    if (pickedDate != null) {
      setState(() {
        _dobController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  Future<void> _registerUser() async {
    const host = 'fintechprojectapiapi20240711020738.azurewebsites.net/';
    const path = 'api/UsersContoller/CreateUser';
    final url = Uri.parse('$host$path');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'nameSurname': _firstNameController.text,
          'username': _lastNameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'passwordConfirm': _confirmPasswordController.text,
        }),
      );
      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('Registration successful: $responseData');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyLoginPage()),
        );
      } else {
        print('Failed to register: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xff350080),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: size.width * 0.5,
            height: size.height * 0.2,
            margin: EdgeInsets.fromLTRB(
              size.width * 0.23,
              size.height * 0,
              size.width * 0.23,
              size.height * 0.001,
            ),
            child: SvgPicture.asset(
              "assets/butcheUILogo.svg",
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment(300, 50),
                  padding: EdgeInsets.all(size.width * 0.04),
                  height: size.height * 0.75,
                  width: size.width * 1,
                  decoration: BoxDecoration(
                    color: Color(0xffffffffff),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(
                            size.width * 0.23,
                            size.height * 0.02,
                            size.width * 0.23,
                            size.height * 0.03,
                          ),
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Kayıt Ol',
                            style: TextStyle(
                              fontFamily: "Lexend",
                              fontSize: size.width * 0.09,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                            size.width * 0.013,
                            size.height * 0,
                            size.width * 0.04,
                            size.height * 0.005,
                          ),
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                  size.width * 0.01,
                                  size.height * 0,
                                  size.width * 0.05,
                                  size.height * 0,
                                ),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'AD',
                                  style: TextStyle(
                                      fontSize: size.width * 0.03,
                                      fontFamily: "Lexend",
                                      letterSpacing: 2),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                  size.width * 0.3,
                                  size.height * 0,
                                  size.width * 0.04,
                                  size.height * 0,
                                ),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'SOYAD',
                                  style: TextStyle(
                                      fontSize: size.width * 0.03,
                                      fontFamily: "Lexend",
                                      letterSpacing: 2),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                            size.width * 0.02,
                            size.height * 0,
                            size.width * 0.04,
                            size.height * 0.005,
                          ),
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Container(
                                height: size.height * 0.04,
                                width: size.width * 0.4,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.1, color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                child: TextField(
                                  controller: _firstNameController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                      size.width * 0.02,
                                      0,
                                      size.width * 0.02,
                                      size.height * 0.022,
                                    ),
                                    hintText: "Ad",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: size.width * 0.03,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                height: size.height * 0.04,
                                width: size.width * 0.4,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.1, color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                child: TextField(
                                  controller: _lastNameController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                      size.width * 0.02,
                                      0,
                                      size.width * 0.02,
                                      size.height * 0.022,
                                    ),
                                    hintText: "Soyad",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: size.width * 0.03,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                            size.width * 0.02,
                            size.height * 0.0008,
                            size.width * 0.04,
                            size.height * 0,
                          ),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'E-MAIL',
                            style: TextStyle(
                                fontSize: size.width * 0.03,
                                fontFamily: "Lexend",
                                letterSpacing: 2),
                          ),
                        ),
                        Container(
                          child: Container(
                            height: size.height * 0.04,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.1, color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            child: TextField(
                              controller: _emailController,
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
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                            size.width * 0.02,
                            size.height * 0.008,
                            size.width * 0.04,
                            size.height * 0,
                          ),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'DOĞUM TARİHİ',
                            style: TextStyle(
                                fontSize: size.width * 0.03,
                                fontFamily: "Lexend",
                                letterSpacing: 2),
                          ),
                        ),
                        Container(
                          child: Container(
                            height: size.height * 0.04,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.1, color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            child: TextField(
                              controller: _dobController,
                              readOnly: true,
                              onTap: () => _selectDate(context),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(
                                  size.width * 0.02,
                                  0,
                                  size.width * 0.02,
                                  size.height * 0.022,
                                ),
                                hintText: "Doğum Tarihi",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: size.width * 0.03,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                            size.width * 0.02,
                            size.height * 0.008,
                            size.width * 0.04,
                            size.height * 0,
                          ),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'ŞİFRE',
                            style: TextStyle(
                                fontSize: size.width * 0.03,
                                fontFamily: "Lexend",
                                letterSpacing: 2),
                          ),
                        ),
                        Container(
                          child: Container(
                            height: size.height * 0.04,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.1, color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              onChanged: _validatePassword,
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
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                            size.width * 0.02,
                            size.height * 0.008,
                            size.width * 0.04,
                            size.height * 0,
                          ),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'ŞİFRE (TEKRAR)',
                            style: TextStyle(
                                fontSize: size.width * 0.03,
                                fontFamily: "Lexend",
                                letterSpacing: 2),
                          ),
                        ),
                        Container(
                          child: Container(
                            height: size.height * 0.04,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.1, color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            child: TextField(
                              controller: _confirmPasswordController,
                              obscureText: !_isConfirmPasswordVisible,
                              onChanged: (value) =>
                                  _validatePassword(_passwordController.text),
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
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.001),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  _getValidationIcon(_isLengthValid),
                                  SizedBox(width: 5),
                                  Text(
                                    'En az 8 karakter olmalı',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Lexend',
                                      color: _isLengthValid
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  _getValidationIcon(_hasUppercase),
                                  SizedBox(width: 5),
                                  Text(
                                    'En az bir büyük harf olmalı',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Lexend',
                                      color: _hasUppercase
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  _getValidationIcon(_hasLowercase),
                                  SizedBox(width: 5),
                                  Text(
                                    'En az bir küçük harf olmalı',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Lexend',
                                      color: _hasLowercase
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  _getValidationIcon(_doPasswordsMatch),
                                  SizedBox(width: 5),
                                  Text(
                                    'Şifreler aynı olmalı',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Lexend',
                                      color: _doPasswordsMatch
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Container(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(70),
                                  ),
                                ),
                              ),
                              fixedSize: MaterialStateProperty.all(
                                Size(size.width * 0.6, size.height * 0.07),
                              ),
                              foregroundColor: const MaterialStatePropertyAll(
                                  Color(0xffF4F4F4)),
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xff39B54A)),
                            ),
                            onPressed: () {
                              _registerUser();
                            },
                            child: Text(
                              'Kayıt Ol',
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                size.width * 0.1,
                                size.height * 0.008,
                                size.width * 0.03,
                                size.height * 0.003,
                              ),
                              child: Text(
                                'Zaten hesabın var mı?',
                                style: TextStyle(fontSize: size.width * 0.045),
                              ),
                            ),
                            Container(
                              child: GestureDetector(
                                child: Text(
                                  'Giriş Yap',
                                  style: TextStyle(
                                    fontSize: size.width * 0.042,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MyLoginPage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
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
