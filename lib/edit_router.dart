import 'package:flutter/material.dart';
import 'model.dart';

class EditRouterPage extends StatelessWidget {
  final RouterInfo router;

  const EditRouterPage({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    final addressController = TextEditingController(text: router.address);
    final userController = TextEditingController(text: router.username);
    final passwordController = TextEditingController(text: router.password);
    final portController = TextEditingController(text: router.port.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Router'),
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
                final editedRouter = RouterInfo(
                  address: addressController.text,
                  username: userController.text,
                  password: passwordController.text,
                  port: int.tryParse(portController.text) ?? 0,
                );
                Navigator.pop(context, editedRouter);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
