import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer/utils/Images.dart';
import 'package:voice_changer/view/authView/logIn.dart';
import '../../utils/Colors.dart';
import '../../viewModel/userViewModel.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isInitial = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isInitial = false;
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      
      var token = Provider.of<UserViewModel>(context, listen: false);
      token.isCheackLogin(context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: _isInitial
                ? const EdgeInsets.only(left: 0)
                : const EdgeInsets.only(left: 100),
            child: SvgPicture.asset(
              svg_SplashText,
              height: _isInitial ? 10 : 65,
              width: _isInitial ? 5 : 75,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height:
                  // _isInitial ? size.height :
                  110,
              width:
                  // _isInitial ? size.height :
                  60,
              alignment: Alignment.center,
              margin: _isInitial
                  ? const EdgeInsets.only(right: 0)
                  : const EdgeInsets.only(right: 100),
              child: SvgPicture.asset(
                svg_SplashIcon,
                fit: BoxFit.fill,
                color: colorPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
