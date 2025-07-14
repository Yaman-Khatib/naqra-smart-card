import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 90.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// Logo
                Image.asset(
                  'assets/images/naqra.png',
                  height: 120,
                ),

                

                /// Tagline
                Text(
                  'Your Digital Identity. Instantly Connected.',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 40),

                /// SIGN UP Button (Gradient)
                FractionallySizedBox(
                  widthFactor: 0.65,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff181818),
                          Color.fromARGB(195, 24, 24, 24),
                        ],
                      ),
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 19),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Handle Sign Up
                        Navigator.of(context).pushNamed('signup');
                      },
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                /// LOGIN Button (Border)
                FractionallySizedBox(
                  widthFactor: 0.65,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xff181818),
                        width: 1.5,
                      ),
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 19),
                        foregroundColor: Color(0xff181818),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Handle Login
                      },
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
