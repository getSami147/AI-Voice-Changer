import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_maker/view/screens/overview.dart';
import 'package:voice_maker/utils/colors.dart';
import 'package:voice_maker/view/sateManagement.dart';
import 'package:voice_maker/view/authView/splashScreen.dart';
import 'package:voice_maker/viewModel/authViewModel.dart';
import 'package:voice_maker/viewModel/homeViewModel.dart';
import 'package:voice_maker/viewModel/paginationViewModel.dart';
import 'package:voice_maker/viewModel/userViewModel.dart';
import 'package:voice_maker/viewModel/userViewModel2.dart';
import 'package:flutter_stripe/flutter_stripe.dart';


enum SocialMedia{whatsapp,whatsappBusiness,facebook,messanger,twitter,instagram,linkedin,message}

Future  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
Stripe.publishableKey ="pk_test_51LjgmuBd21JmgpA7CGR2y2I6RgHjP9YgRDxS6u1JSUzHYw9FdqXE1qThg3ND2Hz0QUumdjHT2jCHWdC5EWXuIQJO00DYKk6w3P";

  await FlutterDownloader.initialize(
    debug: true, // optional: set to false to disable printing logs to console (default: true)
    ignoreSsl: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StateManagementClass(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        ),
         ChangeNotifierProvider(
          create: (context) => UserViewModel2(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaginationViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Voice Marker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          expansionTileTheme: const ExpansionTileThemeData(backgroundColor: Colors.white),
          cardTheme: const CardTheme(color: Colors.white,surfaceTintColor: Colors.white),
          bottomSheetTheme: const BottomSheetThemeData(surfaceTintColor: Colors.white,),
          popupMenuTheme: const PopupMenuThemeData(surfaceTintColor: color_white,color: Colors.white),
          dialogTheme: const DialogTheme(backgroundColor: Colors.white,surfaceTintColor: Colors.white),
          scaffoldBackgroundColor: bgColor,
          colorScheme: ColorScheme.fromSeed(seedColor: colorPrimary),
          useMaterial3: true,
        ),
    
        home:SplashScreen(),
      ),
    );
  }
}
