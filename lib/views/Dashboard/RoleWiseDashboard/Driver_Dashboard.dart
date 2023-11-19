import 'package:flutter/material.dart';

class DriverDashBoard extends StatelessWidget {
  const DriverDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver DashBoard"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){

              },
              icon: const Icon(Icons.logout)
          )
        ],
      ),
    );
  }
}
