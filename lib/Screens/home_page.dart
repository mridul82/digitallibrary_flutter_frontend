import 'package:flutter/material.dart';
import 'package:my_flutter_app_dl/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/loader.dart';
import 'dashboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initstate() {
    super.initState();
    checkLoginStatus();
  }

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> checkLoginStatus() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String userToken = pref.getString('token') ?? '';
    if (userToken != '') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          )),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'password',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          )),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        print('hi!!');
                        // if (_formkey.currentState!.validate()) {
                        //   return;
                        // }
                        Utils(context).startLoading();
                        final loginresponse = await AuthServices.login(
                            _emailController.text, _passwordController.text);
                        if (loginresponse == 200) {
                          Utils(context).stopLoading();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Dashboard(),
                              ),
                              (route) => false);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.blue),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    // ElevatedButton(
                    //     onPressed: () => checkLoginStatus(),
                    //     child: const Text('get token'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
