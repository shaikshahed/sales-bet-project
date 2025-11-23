// Firebase service - initializes Firebase and provides shared instances.
import 'package:firebase_core/firebase_core.dart';
import 'package:sales_bets/firebase_options.dart';


class FirebaseService {
  static Future<void> init() async {
    // Initialize Firebase using DefaultFirebaseOptions.
    // Generate firebase_options.dart with `flutterfire configure` or fill in the template provided.
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }
}
