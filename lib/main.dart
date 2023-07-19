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
import 'package:online_food/feature/presentation/pages/order_map.dart';
import 'package:online_food/feature/presentation/pages/ordered_food.dart';
import 'package:online_food/feature/presentation/pages/signUp.dart';
import 'package:online_food/feature/presentation/pages/specific_buy_item.dart';
import 'package:online_food/feature/presentation/pages/your_order.dart';
import 'package:online_food/feature/presentation/widgets/MainButton.dart';
import 'package:online_food/firebase_options.dart';
//import 'package:online_food/profile.dart';
import 'package:online_food/splash.dart';
import 'package:online_food/userProvider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:theme_manager/theme_manager.dart';
import 'package:device_preview/device_preview.dart';

int indexed = 0;
double w = SizeConfig.W;
double wS = SizeConfig.SW;
double h = SizeConfig.H;
double hS = SizeConfig.SV;

Future<Database> getDatabase()async{
  var databasesPath = await getDatabasesPath();
  String path = ('${databasesPath}demo.db');
  print(path);
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
// When creating the db, create the table
        await db.execute(
            'CREATE TABLE CART (id INTEGER PRIMARY KEY, name TEXT, amount INTEGER, title TEXT)');
      });
  return database;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(options:
  DefaultFirebaseOptions.currentPlatform);
  final database = openDatabase(
    join(await getDatabasesPath(), 'pashewCart.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE IF NOT EXISTS CARTTABLE  ( name TEXT PRIMARY KEY, amount INTEGER,totalAmount INTEGER, title TEXT, quantity INTEGER, id TEXT)');
    },
    version: 1,
  );
  runApp(

       DevicePreview(
         builder: (context) {
           return  const AppPage();
         }
       ));
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
              // colorScheme: ColorScheme.fromSeed(
              //   primary: Theme.of(context).primaryColorDark,
              //     seedColor: const Color.fromRGBO(50, 250,40, 1)),
              useMaterial3: true,
                  primarySwatch: brightness == Brightness.dark
                      ? Colors.amber
                      : Colors.green,

                  primaryIconTheme: IconThemeData(
                      color: brightness == Brightness.dark
                          ? Colors.amber
                          : Theme.of(context).primaryColorDark),
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
                      create: (_) => CustomerProvider(preferences: snapshot.data),
                    ),
                    // ListenableProvider(
                    //     create: (_) =>
                    //         MedicalProvider(preferences: snapshot.data)),
                  ],
                  child: MaterialApp(

                    //useInheritedMediaQuery: true,
                    locale: DevicePreview.locale(context),
                    builder: DevicePreview.appBuilder,
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
                      "login": (context) => const LoginSignUp(),
                      "splash": (context) => const Splashscreen(),
                      "signup": (context) => const SignUpPage(),
                      "home": (context) => const HomePage(),
                      "specificBuyItem": (context) => const SpecificBuyItem(),
                      "cart": (context) => const Cart(),
                     // "delivery": (context) => const DeliveryLocation(),
                      "your_order": (context) => const YourOrder(),
                      "orderMap": (context) => const OrderMap(),
                      "ordered_food": (context) => const OrderedFood(),

                    },
                  ));
            });
      },
    );
  }
}
