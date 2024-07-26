import 'package:butche_app/pages/home_page.dart';
import 'package:butche_app/pages/login_page.dart';
import 'package:butche_app/pages/profile_edit.dart';
import 'package:flutter/material.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetails();
}

class _ProfileDetails extends State<ProfileDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextForm Controller
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(size.width);
    print(size.height);

    return Scaffold(
      backgroundColor: const Color(0xff350080),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: size.height * 0.09,
              width: size.width * 1,
              child: Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(size.width * 0.02, size.height * 0.06, size.width * 0.02, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePage()),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.chevron_left,
                                size: size.width * 0.06,
                                color: Colors.white,
                              ),
                              Text(
                                'Geri',
                                style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontFamily: "Lexend",
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      },
                      child: Icon(
                        Icons.info,
                        size: size.width * 0.06,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                   margin: EdgeInsets.fromLTRB(size.width * 0, size.height * 0.05, size.width * 0, size.height*0.05),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ProfileEdit()),
                                );
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    size: size.width * 0.06,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Profili Düzenle',
                                    style: TextStyle(
                                      fontSize: size.width * 0.04,
                                      fontFamily: "Lexend",
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                    ]
                
                   ),
                ),
               Container(
              margin: EdgeInsets.fromLTRB(size.width * 0, size.height * 0, size.width * 0, size.height*0.01),
               width: 100.0, // Yuvarlağın çapı
               height: 100.0, // Yuvarlağın çapı
               decoration: BoxDecoration(
               shape: BoxShape.circle, // Yuvarlak şekil
               color: Color(0xff39B54A), // Arka plan rengi
               ),
              child: Center(
              child: Text(
               'EK',
              style: TextStyle(
              color: Colors.white,
              fontSize: 50.0, // Metin boyutu
              ),
              ),
              ),
              ),
                Container(
                   margin: EdgeInsets.fromLTRB(size.width * 0.02, size.height * 0.05, size.width * 0, size.height*0.05),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MyLoginPage()),
                                );
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.logout,
                                    size: size.width * 0.06,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Çıkış Yap',
                                    style: TextStyle(
                                      fontSize: size.width * 0.04,
                                      fontFamily: "Lexend",
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                    ]
                
                   ),
                ),
              ],
            ),
          Container(
            height: size.height * 0.85,
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
                        padding: EdgeInsets.fromLTRB(
                          size.width * 0.3,
                          size.height * 0.02  ,
                          size.width * 0.04,
                          size.height * 0,
                        ),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Profil Detayları', 
                          style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontFamily: "Lexend",
                              fontWeight: FontWeight.bold,
                             ),
                        ),
                      ),
               Row(
  children: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.06, // Sabit padding değeri
            size.width * 0.04,
            0,
            0,
          ),
          child: Text(
            'Ad',
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "Lexend",
              fontWeight: FontWeight.bold,
              
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.06,
            0,
            0,
            size.width*0.02,
          ),
          child: Text(
            'Ege',
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "Lexend",
             
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.06,
            0,
            0,
            0,
          ),
          child: Text(
            'Kullanıcı Adı',
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "Lexend",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.06,
            0,
            0,
            size.width*0.02,
          ),
          child: Text(
            'egekiran',
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "Lexend",
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.06,
            0,
            0,
            0,
          ),
          child: Text(
            'Doğum Tarihi',
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "Lexend",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.06,
            0,
            0,
            size.width*0.02,
          ),
          child: Text(
            '08.04.2001',
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "Lexend",
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.06,
            0,
            0,
            0,
          ),
          child: Text(
            'Aylık Harcama',
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "Lexend",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.06,
            0,
            0,
            0,
          ),
          child: Text(
            'Limiti',
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "Lexend",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.06,
            0,
            0,
            0,
          ),
          child: Text(
            '10000₺',
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "Lexend",
            ),
          ),
        ),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.15, // Sabit padding değeri
            0,
            0,
            0,
          ),
          child: Text(
            'Soyad',
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "Lexend",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.15,
            0,
            0,
            size.width*0.02,
          ),
          child: Text(
            'Kıran',
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "Lexend",
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.15,
            0,
            0,
            0,
          ),
          child: Text(
            'E-Mail',
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "Lexend",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.15,
            0,
            0,
            size.width*0.02,
          ),
          child: Text(
            'ege.kiran@gmail.com',
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "Lexend",
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.15,
            0,
            0,
            0,
          ),
          child: Text(
            'Meslek',
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "Lexend",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.15,
            0,
            0,
            size.width*0.02,
          ),
          child: Text(
            'Öğrenci',
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "Lexend",
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.15,
            0,
            0,
            0,
          ),
          child: Text(
            'Tahmini Aylık Gelir',
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "Lexend",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.15,
            0,
            0,
            0,
          ),
          child: Text(
            '0-5000₺',
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "Lexend",
            ),
          ),
        ),
      ],
    ),
  ],
),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                          size.width * 0.35,
                          size.height * 0.03 ,
                          size.width * 0.02,
                          size.height * 0,
                        ),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Şifreni Değiştir',
                          style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontFamily: "Lexend",
                              fontWeight: FontWeight.bold,
                             ),
                        ),
                      ),
                         Column(
                            children: [
                          Container(
                    padding: EdgeInsets.fromLTRB(
                      size.width * 0.05,
                      size.height * 0.01,
                      size.width * 0.04,
                      size.height * 0.005,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'ESKİ ŞİFRE',
                      style: TextStyle(
                        fontSize: size.width * 0.025,
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
                        hintText: "Eski Şifre",
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
                      size.width * 0.05,
                      size.height * 0.01,
                      size.width * 0.04,
                      size.height * 0.005,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'YENİ ŞİFRE',
                      style: TextStyle(
                        fontSize: size.width * 0.025,
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
                        hintText: "Yeni Şifre",
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
                      size.width * 0.05,
                      size.height * 0.01,
                      size.width * 0.04,
                      size.height * 0.005,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'YENİ ŞİFRE (TEKRAR)',
                      style: TextStyle(
                        fontSize: size.width * 0.025,
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
                        hintText: "Yeni Şifre (Tekrar)",
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
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                       
                        child: Column(
                          
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
                      )
                      
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
                        'Onayla',
                        style: TextStyle(
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
        ])
        )],
              ),
      )
                  );
   }
}