import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import the secure storage package
import 'package:sipegpdam/controllers/absensi_controller.dart';
import 'package:sipegpdam/controllers/auth_controller.dart';
import 'package:sipegpdam/controllers/cuti_controller.dart';
import 'package:sipegpdam/controllers/gaji_controller.dart';
import 'package:sipegpdam/controllers/pegawai_controller.dart';
import 'package:sipegpdam/controllers/pelanggan_controller.dart';
import 'package:sipegpdam/controllers/pencatatan_controller.dart';
import 'package:sipegpdam/views/onboarding_page.dart';
import 'package:sipegpdam/views/login_page.dart'; // Import the login page

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  final storage = FlutterSecureStorage();
  final onboardingSkipped =
      await storage.read(key: 'dont_show_onboarding') == 'true';

  runApp(MyApp(onboardingSkipped: onboardingSkipped));
}

class MyApp extends StatelessWidget {
  final bool onboardingSkipped;

  const MyApp({Key? key, required this.onboardingSkipped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => AbsensiController()),
        ChangeNotifierProvider(create: (context) => CutiController()),
        ChangeNotifierProvider(create: (context) => GajiController()),
        ChangeNotifierProvider(create: (context) => PegawaiController()),
        ChangeNotifierProvider(create: (context) => PelangganController()),
        ChangeNotifierProvider(create: (context) => PencatatanController()),
      ],
      child: MaterialApp(
        title: 'Sipeg PDAM',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            titleTextStyle: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        home: onboardingSkipped ? const LoginPage() : const OnboardingScreen(),
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
      ),
    );
  }
}
