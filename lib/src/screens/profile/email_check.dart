import 'package:flutter/material.dart';
import 'package:news_app/src/screens/profile/widgets/number.dart';
import 'package:news_app/src/screens/profile/widgets/link.dart';
import 'package:news_app/src/screens/profile/widgets/underline_title.dart';

import '../../navigator/manager.dart';

class EmailCheck extends StatelessWidget {
  final NavigatorManager navigatorManager;

  const EmailCheck({super.key, required this.navigatorManager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        onTap: (index) {},
        selectedItemColor: Colors.blue,
        // Selected item color
        unselectedItemColor: Colors.black,
        // Unselected item color
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.moving),
            label: 'Movement',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 300,
                child: Center(
                  child: Column(children: [
                    const TitleWithUnderline(title: 'Check your email'),
                    const Text(
                      "We sent you temporary code to verify email",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                    ),
                    const Text(
                      "Check username@gmail.com and enter the code below",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NumberInputField(),
                        SizedBox(width: 10.0),
                        NumberInputField(),
                        SizedBox(width: 10.0),
                        NumberInputField(),
                        SizedBox(width: 10.0),
                        NumberInputField(),
                      ],
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                        onPressed: () {
                          print('continue');
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // Border radius
                          ),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ))),
                    const SizedBox(height: 20),
                    Link(
                      text: "Can't find the email?",
                      onPressed: () {
                        print('link');
                      },
                    ),
                    Link(
                      text: "Request new verification code",
                      onPressed: () {
                        print('link');
                      },
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      thickness: 2.0,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 10),
                    Link(
                      text: "Go back and use different email address",
                      onPressed: () {
                        print('link');
                      },
                    )
                  ]),
                )),
          ],
        ),
      ),
    );
  }
}
