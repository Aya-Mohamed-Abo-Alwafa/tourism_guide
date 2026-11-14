import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/attraction.dart';
import 'attractions_data.dart';

class FavoritesManager {
  static final ValueNotifier<List<Attraction>> favorites = ValueNotifier([]);

  static StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _sub;

  static DocumentReference<Map<String, dynamic>>? get _doc {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    return FirebaseFirestore.instance.collection('users').doc(user.uid);
  }

  static bool isFavorite(Attraction a) =>
      favorites.value.any((e) => e.title == a.title);

  static Future<void> toggle(Attraction a) async {
    final list = List<Attraction>.from(favorites.value);
    final index = list.indexWhere((e) => e.title == a.title);
    if (index >= 0) {
      list.removeAt(index);
    } else {
      list.add(a);
    }
    favorites.value = list;

    final doc = _doc;
    if (doc == null) return;
    await doc.set({
      'favorites': list.map((e) => e.title).toList(),
    }, SetOptions(merge: true));
  }

  static void startListening() {
    _sub?.cancel();
    final doc = _doc;
    if (doc == null) return;
    _sub = doc.snapshots().listen((snap) {
      final titles = List<String>.from(snap.data()?['favorites'] ?? []);
      favorites.value =
          attractions.where((a) => titles.contains(a.title)).toList();
    });
  }

  static void stopListening() {
    _sub?.cancel();
    _sub = null;
    favorites.value = [];
  }
}