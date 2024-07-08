//import 'package:clickmart/view/authentication/sign_in.dart';
import 'package:flutter/material.dart';
import '../pages/create_new_password.dart';
import '../pages/forget_password.dart';


class ForgotPasswordApproved extends StatefulWidget {
  const ForgotPasswordApproved({super.key});

  @override
  State<ForgotPasswordApproved> createState() => _ForgotPasswordApprovedState();
}

class _ForgotPasswordApprovedState extends State<ForgotPasswordApproved> {
  // Form Key

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextForm Controller
  TextEditingController emailController = TextEditingController();

  // Form Validation
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
          backgroundColor: Color(0xff350080),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: Alignment(300, 50),
                padding: EdgeInsets.all(size.width * 0.04),
                height: size.height * 0.87,
                width: size.width * 1,
                decoration: BoxDecoration(
                  color: Color(0xffffffffff),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                     child: Column(
             children: [
                Container(
                  margin: EdgeInsets.only(right: 2.0), // İkonun sağında boşluk bırakır
                  child: Transform.translate(
                    offset: Offset(0, 20), // İkonu aşağı kaydırır
                    child: Icon(
                      Icons.check, // Yeşil ok
                      color: Colors.green,
                      size: 74.0,
    ),
  ),
),

                    Container(
                      margin: EdgeInsets.fromLTRB(
                        size.width * 0.33,
                        size.height * 0.03,
                        size.width * 0,
                        size.height * 0.002,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Şifren',
                        style: TextStyle(
                            fontSize: size.width * 0.084,
                            fontFamily: "Lexend",
                            fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        size.width * 0.268,
                        size.height * 0.002,
                        size.width * 0.23,
                        size.height * 0.005,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Sıfırlandı',
                        style: TextStyle(
                            fontSize: size.width * 0.084,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Lexend",
                            ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        size.width * 0.08,
                        size.height * 0.02,
                        size.width * 0.09,
                        size.height * 0.02,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'E-Posta Adresine giriş yapabilmen için geçici olarak bir şifre gönderdik.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontFamily: "Lexend",
                            ),
                      ),
                    ),
                     Container(
                      margin: EdgeInsets.fromLTRB(
                        size.width * 0.08,
                        size.height * 0.0,
                        size.width * 0.09,
                        size.height * 0.104,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Bu şifreyi giriş yaptıktan sonra değiştirmeni tavsiye ediyoruz!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Lexend",
                            ),
                      ),
                    ),
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
                                  foregroundColor:
                                      const MaterialStatePropertyAll(
                                          Color(0xffF4F4F4)),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Color(0xff39B54A)),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CreateNewPassword()),
                                  );
                                },
                                child: Text(
                                  'Giriş Yap',
                                  style: TextStyle(
                                    fontSize: size.width * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, size.height * 0.048, 0, 0),
                              child: Center(
                              child: Row(
                              mainAxisSize: MainAxisSize.min, // İçeriği ortalamak için
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 2.0), // İkonun sağında boşluk bırakır
                                  child: Icon(
                                  Icons.chevron_left, // Geri ok işareti
                                  size: size.width*0.05,
                                  ),
                                ), 
                              Container(
                                   child: GestureDetector(
                                   child: Text(
                                  'Bir önceki adıma geri dön',
                                   style: TextStyle(fontSize: size.width * 0.04),
                                  ),
                                  onTap: () {
                                  Navigator.push(
                                  context,
                                   MaterialPageRoute(
                                  builder: (context) => const ForgotPassword()),
                            );
                          },
                        ),
                              ),
                             ],
                             ),
                             ),
                            )
                          ],
                        ),
                      ),
            ],
          ),
    );
  }
}
