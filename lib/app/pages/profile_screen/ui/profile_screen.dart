// profile_screen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/drawer/home_drawer.dart';
import '../binding/profile_binding.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key) {
    ProfileBinding().dependencies();
  }

  // Retrieve the controller instance
  final ProfileController controller = Get.find<ProfileController>();

  Future<String> _fetchUserName() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return doc.data()?['name'] ?? 'No Name';
    }
    return 'Unknown User';
  }

  @override
  Widget build(BuildContext context) {
    // Here we're using a FutureBuilder to retrieve the user's name from Firestore.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      drawer: HomeDrawer(context: context),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(
              child: FutureBuilder<String>(
                future: _fetchUserName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircleAvatar(
                          radius: 40,
                          child: Icon(Icons.person, size: 40),
                        ),
                       SizedBox(height: 10),
                        Text("Loading...", style: TextStyle(fontSize: 20)),
                        SizedBox(height: 5),
                        Text("Loading...", style: TextStyle(fontSize: 16, color: Colors.grey)),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                      "Error fetching user data",
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    );
                  } else if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          child: Icon(Icons.person, size: 40),
                        ),
                        const SizedBox(height: 10),
                        Text(snapshot.data!, style: const TextStyle(fontSize: 20)),
                        const SizedBox(height: 5),
                        // Make sure that your ProfileController has an email property; otherwise, use an alternative source
                        Text(controller.email, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                      ],
                    );
                  } else {
                    return const Text(
                      "No user data available",
                      style: TextStyle(fontSize: 18),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
