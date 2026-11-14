import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../data/attractions_data.dart';
import '../data/favorites_manager.dart';
import '../providers/auth_provider.dart';
import '../widgets/attraction_card.dart';
import 'explore_screen.dart';
import 'favoriate_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var screen_num = 0;

  @override
  void initState() {
    super.initState();
    FavoritesManager.startListening();
  }

  Future<void> _logout() async {
    FavoritesManager.stopListening();
    await context.read<AuthProvider>().logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var screens = [ExploreScreen(), FavoriateScreen()];
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primary,

        title: const Text(
          "Tourism Egypt",
          style: TextStyle(color: Colors.white),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),

      body: screens[screen_num],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: screen_num,
        onTap: (index) {
          setState(() {
            screen_num = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Explore"),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}