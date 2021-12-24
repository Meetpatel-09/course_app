import 'package:course_app_ui/services/google_sign_in_api.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authentication_pages/login_page.dart';

class TemPage extends StatelessWidget {
  final GoogleSignInAccount user;

  const TemPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.deepPurple,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Profile",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 150.0,
              width: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(75),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: Image.network(user.photoUrl ??
                        'https://cdn-icons-png.flaticon.com/512/3135/3135715.png')
                        .image),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Name: ' + user.displayName!,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(
              height: 5,
            ),
            Text('Email: ' + user.email,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                onPressed: () async {
                  await GoogleSignInAPI.logout();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.logout_outlined),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
