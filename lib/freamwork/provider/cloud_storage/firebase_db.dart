import 'package:firebase_core/firebase_core.dart';
import 'package:personal_portfolio/firebase_options.dart';

class FirebaseDb {

    static Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

}