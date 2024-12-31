import 'package:flutter/material.dart';
import 'model.dart';

class AddRouterPage extends StatelessWidget {
  const AddRouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = TextEditingController();
    final userController = TextEditingController();
    final passwordController = TextEditingController();
    final portController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Router'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Router Address',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: userController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: portController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Port',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final router = RouterInfo(
                  address: addressController.text,
                  username: userController.text,
                  password: passwordController.text,
                  port: int.tryParse(portController.text) ?? 0,
                );
                Navigator.pop(context, router);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
