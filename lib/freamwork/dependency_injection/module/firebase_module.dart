import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {

  FirebaseFirestore getFirebaseFirestoreInstance() {
    return FirebaseFirestore.instance;
  }

  FirebaseAnalytics getFirebaseAnalyticsInstance() {
    return FirebaseAnalytics.instance;
  }
}
