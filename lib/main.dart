import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_bets/firebase_options.dart';
import 'models/user_model.dart';
import 'screens/home_screen.dart';
import 'screens/teams_screen.dart';
import 'screens/live_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/onboarding.dart';
import 'screens/auth_wrapper.dart';
import 'services/wallet_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase first!
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SalesBetsApp());
}


class SalesBetsApp extends StatelessWidget {
  const SalesBetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WalletService()),
        ChangeNotifierProvider(create: (_) => UserModel.sample()),
      ],
      child: MaterialApp(
        title: 'SalesBets',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            elevation: 2,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        // theme: ThemeData.dark().copyWith(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // ),

        home: const AuthWrapper(),
        routes: {
          '/home': (_) => const MainTabView(),
          '/teams': (_) => const TeamsScreen(),
          '/live': (_) => const LiveScreen(),
          '/profile': (_) => const ProfileScreen(),
        },
      ),
    );
  }
}

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int _index = 0;
  final _pages = const [
    HomeScreen(),
    TeamsScreen(),
    LiveScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.group), label: 'Teams'),
          NavigationDestination(icon: Icon(Icons.live_tv), label: 'Live'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
