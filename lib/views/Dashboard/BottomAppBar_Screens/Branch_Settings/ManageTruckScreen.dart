import 'package:flutter/material.dart';

class ManageTruckScreen extends StatelessWidget {
  const ManageTruckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Truck'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},child: const Icon(Icons.add),),
    );
  }
}
