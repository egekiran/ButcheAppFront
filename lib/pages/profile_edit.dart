import 'package:butche_app/pages/profile_details.dart';
import 'package:flutter/material.dart';
import 'package:butche_app/pages/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Lexend",
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr', 'TR'),
      ],
      home: const MyProfileEdit(title: ''),
    );
  }
}

class MyProfileEdit extends StatefulWidget {
  const MyProfileEdit({super.key, required this.title});

  final String title;

  @override
  State<MyProfileEdit> createState() => _MyProfileEditState();
}

class _MyProfileEditState extends State<MyProfileEdit> {
  final TextEditingController _dobController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff350080),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: size.height * 0.9, // Adjust the height as needed
              width: size.width,
              margin: EdgeInsets.only(top: size.height * 0.3),
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
                        size.width * 0.015, size.height * 0.015, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileDetails()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.chevron_left,
                            size: size.width * 0.06,
                            color: const Color(0xff350080),
                          ),
                          Text(
                            'Geri',
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontFamily: "Lexend",
                              color: const Color(0xff350080),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      size.width * 0.05,
                      size.height * 0.03,
                      size.width * 0.04,
                      0,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Profili Düzenle',
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        fontFamily: "Lexend",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      size.width * 0.05,
                      size.height * 0,
                      size.width * 0.04,
                      size.height * 0.005,
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
                    child: Container(
                      height: size.height * 0.04,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.1, color: Colors.black),
                        borderRadius: const BorderRadius.all(
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
                          hintText: "Ad",
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
                      size.width * 0.05,
                      size.height * 0,
                      size.width * 0.04,
                      size.height * 0.005,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'SOYAD',
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
                        border: Border.all(width: 0.1, color: Colors.black),
                        borderRadius: const BorderRadius.all(
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
                          hintText: "Soyad",
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
                      size.width * 0.05,
                      size.height * 0,
                      size.width * 0.04,
                      size.height * 0.005,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'KULLANICI ADI',
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
                        border: Border.all(width: 0.1, color: Colors.black),
                        borderRadius: const BorderRadius.all(
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
                          hintText: "Kullanıcı Adı",
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
                      size.width * 0.05,
                      size.height * 0,
                      size.width * 0.04,
                      size.height * 0.005,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'E-MAİL',
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
                        border: Border.all(width: 0.1, color: Colors.black),
                        borderRadius: const BorderRadius.all(
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
                        border: Border.all(width: 0.1, color: Colors.black),
                        borderRadius: const BorderRadius.all(
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
                      size.width * 0.05,
                      size.height * 0,
                      size.width * 0.04,
                      size.height * 0.005,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'MESLEK',
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
                        border: Border.all(width: 0.1, color: Colors.black),
                        borderRadius: const BorderRadius.all(
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
                          hintText: "Meslek",
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
                      size.width * 0.05,
                      size.height * 0,
                      size.width * 0.04,
                      size.height * 0.005,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'AYLIK HARCAMA LİMİTİ',
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
                        border: Border.all(width: 0.1, color: Colors.black),
                        borderRadius: const BorderRadius.all(
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
                          hintText: "Aylık Harcama Limiti",
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
                      size.width * 0.05,
                      size.height * 0,
                      size.width * 0.04,
                      size.height * 0.005,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'TAHMİNİ AYLIK GELİR',
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
                        border: Border.all(width: 0.1, color: Colors.black),
                        borderRadius: const BorderRadius.all(
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
                          hintText: "Tahmini Aylık Gelir",
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
                        ProfileEdit();
                      },
                      child: Text(
                        'Kaydet',
                        style: TextStyle(
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
