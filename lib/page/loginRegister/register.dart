// import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/loginRegister/createProfile.dart';
import 'package:flutter_application_1/page/loginRegister/login.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String accessToken = '';
  bool _wrongPassword = false;

  Future<void> fetchRegister(
    String username,
    String password,
    String passwordConfirm,
  ) async {
    print(username);
    print(password);
    print(passwordConfirm);

    Map<String, dynamic> response =
        await postRegister(username, password, passwordConfirm);

    if (response["status"] == "fail") {
      print(response["status"]);
      setState(() {
        _usedEmail = true;
        _readyToCreateProfile = false;
      });
    } else {
      setState(() {
        _usedEmail = false;
        _readyToCreateProfile = true;
      });
    }
    // }
    // print('success');
    // setState(() {
    //   _usedEmail = false;
    //   _readyToCreateProfile = true;
    // });

    // setState(() {
    //   _usedEmail = true;
    //   _readyToCreateProfile = false;
    // });
  }

  // Future postRegister(
  //   String username,
  //   String password,
  //   String passwordConfirm,
  // ) async {
  //   final response =
  //       await http.post(Uri.parse('http://10.27.7.81:8000/api/auth/register'),
  //           body: json.encode({
  //             "username": username,
  //             "password": password,
  //             "passwordConfirm": passwordConfirm,
  //             "role": "patient"
  //           }));
  //   if (response.statusCode == 400) {
  //     setState(() {
  //       _usedEmail = true;
  //       _readyToCreateProfile = false;
  //     });
  //   } else {
  //     setState(() {
  //       _usedEmail = false;
  //       _readyToCreateProfile = true;
  //     });
  //   }
  // }

  Future<void> fetchLogin(String username, String password) async {
    try {
      Map<String, dynamic> response = await postLogin(username, password);
      setState(() {
        accessToken = response['access_token'];
        Provider.of<AuthProvider>(context, listen: false).setToken(accessToken);
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  // Future postLogin(String username, String password) async {
  //   final url = Uri.parse("http://10.27.7.81:8000/api/auth/login");
  //   final response = await http.post(url,
  //       body: json.encode({'username': username, 'password': password}));

  //   Provider.of<AuthProvider>(context, listen: false)
  //       .setToken(json.decode(response.body)['access_token']);
  // }

  bool visiblePassword = false;
  bool visibleConfirmPassword = false;

  bool fillPassword = false;

  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerConfirmPassword = TextEditingController();

  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _validateConfirmPassword = false;

  bool _readyToCreateProfile = false;
  bool _notSame = false;
  bool _usedEmail = false;

  bool _conditionPassword(String value) {
    RegExp regex = RegExp(r'^\d{8}$');
    //r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    super.dispose();
  }

  // String _otp = '';

  // EmailOTP _myauth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color(hexColor('#FAFCFB')),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth,
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.023),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    iconSize: 30,
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                    },
                                  ),
                                  Container(
                                      height: screenHeight * 0.195,
                                      child: Image.asset(
                                          'assets/images/register.png')),
                                  SizedBox(
                                    width: 52,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.023,
                              ),
                              Text("ลงทะเบียน",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * .025,
                            vertical: screenHeight * 0.012),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("อีเมล",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              _email = value;
                              _usedEmail = false;
                            });
                          },
                          controller: _controllerEmail,
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#DBDBDB')),
                                  width: 1,
                                )),
                            errorText: _validateEmail && _email == ''
                                ? "กรุณากรอกอีเมล"
                                : !EmailValidator.validate(_email) &&
                                        _email != ''
                                    ? "รูปแบบอีเมลไม่ถูกต้อง"
                                    : _usedEmail
                                        ? "อีเมลนี้มีผู้ลงทะเบียนใช้งานอยู่แล้ว"
                                        : null,
                            errorStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#FB6262')),
                              fontWeight: FontWeight.normal,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            hintText: 'email@example.com',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#999999')),
                              fontWeight: FontWeight.normal,
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#DBDBDB')),
                                  width: 1,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.012,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * .025,
                            vertical: screenHeight * 0.012),
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("รหัสผ่าน",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.start),
                            ]),
                      ),
                      SizedBox(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                          controller: _controllerPassword,
                          obscuringCharacter: '●',
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          obscureText: !visiblePassword,
                          decoration: InputDecoration(
                            errorMaxLines: 3,
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#DBDBDB')),
                                  width: 1,
                                )),
                            errorText: !_conditionPassword(_password) &&
                                    _password != ''
                                ? '*** รหัสผ่านขั้นต่ำ 8 ตัวอักษร'
                                : _validatePassword && _password == ''
                                    ? "กรุณากรอกรหัสผ่าน"
                                    : null,
                            errorStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#FB6262')),
                              fontWeight: FontWeight.normal,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            hintText: '●●●●●●●●●●',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#999999')),
                              fontWeight: FontWeight.normal,
                            ),
                            suffixIcon: IconButton(
                                iconSize: 16,
                                color: Color(hexColor('#999999')),
                                icon: Icon(visiblePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    visiblePassword = !visiblePassword;
                                  });
                                }),
                            border: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#DBDBDB')),
                                  width: 1,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.012,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * .025,
                            vertical: screenHeight * 0.012),
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("ยืนยันรหัสผ่าน",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.start),
                            ]),
                      ),
                      SizedBox(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              _notSame = false;
                              _confirmPassword = value;
                            });
                          },
                          controller: _controllerConfirmPassword,
                          obscuringCharacter: '●',
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          obscureText: !visibleConfirmPassword,
                          decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#DBDBDB')),
                                  width: 1,
                                )),
                            errorText: !_conditionPassword(_password)
                                ? null
                                : _validateConfirmPassword &&
                                        _confirmPassword == ''
                                    ? "กรุณากรอกยืนยันรหัสผ่าน"
                                    : _notSame
                                        ? "ยืนยันรหัสผ่านไม่ตรงกัน"
                                        : null,
                            errorStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#FB6262')),
                              fontWeight: FontWeight.normal,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            hintText: '●●●●●●●●●●',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#999999')),
                              fontWeight: FontWeight.normal,
                            ),
                            suffixIcon: IconButton(
                                iconSize: 16,
                                color: Color(hexColor('#999999')),
                                icon: Icon(visibleConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    visibleConfirmPassword =
                                        !visibleConfirmPassword;
                                  });
                                }),
                            border: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#DBDBDB')),
                                  width: 1,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.048),
                      MaterialButton(
                        height: screenHeight * 0.048,
                        color: Color(hexColor('#2F4EF1')),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.5),
                        ),
                        onPressed: () async {
                          if (_controllerEmail.text.isEmpty == true) {
                            setState(() {
                              _validateEmail = true;
                              _validatePassword = false;
                              _validateConfirmPassword = false;
                              _notSame = false;
                            });
                          } else if (_controllerPassword.text.isEmpty == true) {
                            setState(() {
                              _validateEmail = false;
                              _validatePassword = true;
                              _validateConfirmPassword = false;
                              _notSame = false;
                            });
                          } else if (_controllerConfirmPassword.text.isEmpty ==
                              true) {
                            setState(() {
                              _validateEmail = false;
                              _validatePassword = false;
                              _validateConfirmPassword = true;
                              _notSame = false;
                            });
                          } else {
                            if (_password == _confirmPassword) {
                              setState(() {
                                _notSame = false;
                              });
                              await fetchRegister(
                                _email,
                                _password,
                                _confirmPassword,
                              );

                              if (_readyToCreateProfile == true) {
                                await fetchLogin(_email, _password);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreateProfilePage()));
                              }
                            } else {
                              setState(() {
                                _notSame = true;
                              });
                            }
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text("ลงทะเบียน",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Color(hexColor('#DBDBDB')),
                              thickness: 1,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * .050,
                          ),
                          Text(
                            'หรือ ดำเนินการต่อ',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'IBMPlexSansThai',
                                color: Color(hexColor('#484554')),
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            width: screenWidth * .050,
                          ),
                          Expanded(
                            child: Divider(
                              color: Color(hexColor('#DBDBDB')),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      MaterialButton(
                        height: screenHeight * 0.048,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.5),
                        ),
                        onPressed: () {
                          //loging by google
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/google.png'),
                            SizedBox(
                              width: screenWidth * .025,
                            ),
                            Text("เข้าสู่ระบบด้วย Google",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
