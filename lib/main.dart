import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:online_food/Size_of_screen.dart';
import 'package:online_food/feature/presentation/pages/cart.dart';
import 'package:online_food/feature/presentation/pages/delivery.dart';
import 'package:online_food/feature/presentation/pages/home.dart';
//import 'package:online_food/homePage.dart';
import 'package:online_food/feature/presentation/pages/login.dart';
import 'package:online_food/feature/presentation/pages/signUp.dart';
import 'package:online_food/feature/presentation/pages/specific_buy_item.dart';
import 'package:online_food/feature/presentation/widgets/MainButton.dart';
import 'package:online_food/firebase_options.dart';
//import 'package:online_food/profile.dart';
import 'package:online_food/splash.dart';
import 'package:online_food/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_manager/theme_manager.dart';

int indexed = 0;
double w = SizeConfig.W;
double wS = SizeConfig.SW;
double h = SizeConfig.H;
double hS = SizeConfig.SV;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AppPage());
}

class AppPage extends StatelessWidget {
  final Widget? child;
  const AppPage({Key? key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            color: Colors.white,
          );
        }
        return ThemeManager(
            defaultBrightnessPreference: BrightnessPreference.system,
            data: (Brightness brightness) => ThemeData(
                  primarySwatch: brightness == Brightness.dark
                      ? Colors.amber
                      : Colors.blue,
                  primaryIconTheme: IconThemeData(
                      color: brightness == Brightness.dark
                          ? Colors.amber
                          : Colors.black),
                  textTheme: Theme.of(context).textTheme.apply(
                      fontFamily: "PlayfairDisplay-VariableFont_wght",
                      decorationColor: brightness == Brightness.dark
                          ? Colors.amberAccent
                          : Colors.black,
                      bodyColor: brightness == Brightness.dark
                          ? Colors.amberAccent
                          : Colors.black,
                      displayColor: brightness == Brightness.dark
                          ? Colors.amberAccent
                          : Colors.black),
                  // GoogleFonts.montserratTextTheme(ThemeData().textTheme),
                  //accentColor: Colors.lightBlue,
                  fontFamily: "PlayfairDisplay-VariableFont_wght",
                  brightness: brightness,
                ),
            // loadBrightnessOnStart: true,
            themedWidgetBuilder: (BuildContext context, ThemeData theme) {
              return MultiProvider(
                  providers: [
                    ListenableProvider(
                      create: (_) => UserProvider(preferences: snapshot.data),
                    ),
                    // ListenableProvider(
                    //     create: (_) =>
                    //         MedicalProvider(preferences: snapshot.data)),
                  ],
                  child: MaterialApp(
                    supportedLocales: const [
                      Locale("af"),
                      Locale("am"),
                      Locale("ar"),
                      Locale("az"),
                      Locale("be"),
                      Locale("bg"),
                      Locale("bn"),
                      Locale("bs"),
                      Locale("ca"),
                      Locale("cs"),
                      Locale("da"),
                      Locale("de"),
                      Locale("el"),
                      Locale("en"),
                      Locale("es"),
                      Locale("et"),
                      Locale("fa"),
                      Locale("fi"),
                      Locale("fr"),
                      Locale("gl"),
                      Locale("ha"),
                      Locale("he"),
                      Locale("hi"),
                      Locale("hr"),
                      Locale("hu"),
                      Locale("hy"),
                      Locale("id"),
                      Locale("is"),
                      Locale("it"),
                      Locale("ja"),
                      Locale("ka"),
                      Locale("kk"),
                      Locale("km"),
                      Locale("ko"),
                      Locale("ku"),
                      Locale("ky"),
                      Locale("lt"),
                      Locale("lv"),
                      Locale("mk"),
                      Locale("ml"),
                      Locale("mn"),
                      Locale("ms"),
                      Locale("nb"),
                      Locale("nl"),
                      Locale("nn"),
                      Locale("no"),
                      Locale("pl"),
                      Locale("ps"),
                      Locale("pt"),
                      Locale("ro"),
                      Locale("ru"),
                      Locale("sd"),
                      Locale("sk"),
                      Locale("sl"),
                      Locale("so"),
                      Locale("sq"),
                      Locale("sr"),
                      Locale("sv"),
                      Locale("ta"),
                      Locale("tg"),
                      Locale("th"),
                      Locale("tk"),
                      Locale("tr"),
                      Locale("tt"),
                      Locale("uk"),
                      Locale("ug"),
                      Locale("ur"),
                      Locale("uz"),
                      Locale("vi"),
                      Locale("zh")
                    ],
                    localizationsDelegates: const [
                      CountryLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    debugShowCheckedModeBanner: false,
                    theme: theme,
                    initialRoute: "splash",
                    routes: {
                      "homeScreen": (context) => const HomeScreen(),
                      "login": (context) => const LoginSignUp(),
                      "splash": (context) => const Splashscreen(),
                      "signup": (context) => const SignUpPage(),
                      "home": (context) => const HomePage(),
                      "specificBuyItem": (context) => const SpecificBuyItem(),
                      "cart": (context) => const Cart(),
                      "delivery": (context) => const DeliveryLocation(),
                    },
                  ));
            });
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(210, 230, 250, 0.2),
          ),
          padding: const EdgeInsets.all(10),

          // margin: const EdgeInsets.only(left: 150),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView(children: [
                const Center(
                    child: Text(
                  "ONLINE HEALTH CARE",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: hS * 18.75,
                    backgroundImage: Image.asset(
                      "./assets/images/doctor_1.jpg",
                      height: h / 3,
                      width: w,
                    ).image,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Center(
                    child: Text(
                  "Good Day Dear",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )),
                const Center(
                    child: Text(
                  "Welcome To Quality Online HealthCare ",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                )),
                const Center(
                    child: Text(
                  "Here your health is our priority",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                )),
              ]),
            ),
            SecondaryButton(
              onPressed: () {
                Navigator.pushNamed(context, "login");
              },
              foregroundColor: Colors.white,
              backgroundColor: Colors.pink,
              color: Colors.pink,
              text: "Login",
            ),
            const SizedBox(height: 10),
            SecondaryButton(
              backgroundColor: Colors.white,
              foregroundColor: Colors.pink,
              onPressed: () {
                Navigator.pushNamed(context, "signup");
              },
              color: Colors.pink,
              text: "Signup",
            ),
            const SizedBox(height: 20)
          ])),
    );
  }
}
