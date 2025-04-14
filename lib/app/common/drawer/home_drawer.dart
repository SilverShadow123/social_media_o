import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:social_media_o/routes/routes.dart';

import '../../pages/home_screen/controller/home_controller.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key, required this.context});

  final controller = Get.find<HomeController>();
  final BuildContext context;

  // A function to fetch the user name from Firestore.
  Future<String> _fetchUserName() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return doc.data()?['name'] ?? 'No Name';  // Fallback if name is missing.
    }
    return 'Unknown User';
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // Use FutureBuilder to wait for the name from Firestore
            FutureBuilder<String>(
              future: _fetchUserName(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // You can return a placeholder while loading
                  return UserAccountsDrawerHeader(
                    accountName: Text('Loading...'),
                    accountEmail: Text(controller.email),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Text(
                        'Loading...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1565C0), Color(0xFF1E88E5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  );
                } else if (snapshot.hasData) {
                  final String name = snapshot.data!;
                  return UserAccountsDrawerHeader(
                    accountName: Text(name, style: TextStyle(color: Colors.white)),
                    accountEmail: Text(controller.email),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Text(
                        name.substring(0, 2).toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1565C0), Color(0xFF1E88E5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  );
                } else {
                  return UserAccountsDrawerHeader(
                    accountName: Text('No Name', style: TextStyle(color: Colors.white)),
                    accountEmail: Text(controller.email),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Text(
                        'JD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1565C0), Color(0xFF1E88E5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  );
                }
              },
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person, color: Colors.indigo),
                    title: const Text('Profile'),
                    onTap: () {
                   controller.navigateToProfile();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.home, color: Colors.indigo),
                    title: const Text('Home'),
                    onTap: () {
                      controller.navigateToHome();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.pie_chart, color: Colors.indigo),
                    title: const Text('Graphs'),
                    onTap: () {
                     controller.navigateToGraph();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.money_off, color: Colors.indigo),
                    title: const Text('Spent'),
                    onTap: () {
                      controller.navigateToSpent();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.attach_money, color: Colors.indigo),
                    title: const Text('Earned'),
                    onTap: () {
                      controller.navigateToEarned();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
