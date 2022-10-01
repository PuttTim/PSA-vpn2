import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfix_mobile/data/auth/auth_repository.dart';
import 'package:portfix_mobile/ui/screens/auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromARGB(0, 75, 151, 149)),
        title: const Text("PortFix"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
                child: Text(
                  'In Progress',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 100,
            width: double.maxFinite,
            child: Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(7),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("name : ",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              )),
                          Text("Date : ",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                AuthRepository.getInstance().logOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              },
              child: const Text("Log Out"),
            ),
          ),
        ],
      ),
    );
  }
}
