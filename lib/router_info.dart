import 'package:flutter/material.dart';
import 'package:router_os_client/router_os_client.dart'; // Assuming this is the correct package import
import 'model.dart'; // Your custom model for RouterInfo

class RouterDetailsPage extends StatefulWidget {
  final RouterInfo router;

  const RouterDetailsPage({super.key, required this.router});

  @override
  State<RouterDetailsPage> createState() => _RouterDetailsPageState();
}

class _RouterDetailsPageState extends State<RouterDetailsPage> {
  late RouterOSClient client;
  String connectionStatus = 'Not Connected';
  String commandResult = '';
  final TextEditingController commandController = TextEditingController();
  bool useStreaming = false;

  @override
  void initState() {
    super.initState();
    // Initialize the RouterOSClient using router details
    client = RouterOSClient(
      address: widget.router.address,
      user: widget.router.username,
      password: widget.router.password,
      port: widget.router.port,
      useSsl: false,
      timeout: const Duration(seconds: 10),
    );
  }

  Future<void> connectToRouter() async {
    try {
      if (connectionStatus == 'Connected') {
        // Skip connecting if already connected
        setState(() {
          connectionStatus = 'Already connected';
        });
        return;
      }

      bool success = await client.login(); // Login to the router
      setState(() {
        connectionStatus = success ? 'Connected' : 'Login failed';
      });
    } catch (e) {
      setState(() {
        connectionStatus = 'Connection failed: $e';
      });
    }
  }

  Future<void> executeCommand() async {
    if (connectionStatus != 'Connected') {
      setState(() {
        commandResult = 'Error: Not connected to the router.';
      });
      return;
    }

    try {
      String command = commandController.text;

      if (useStreaming) {
        // If streaming is enabled, use streaming mode
        var stream = client.streamData(command);
        await for (var data in stream) {
          setState(() {
            commandResult += '\n$data';
          });
        }
      } else {
        // Execute the command and get the result
        var result = await client.talk(command);
        setState(() {
          commandResult = result.toString();
        });
      }
    } catch (e) {
      setState(() {
        commandResult = 'Error executing command: $e';
      });
    }
  }

  @override
  void dispose() {
    // Clean up resources
    client.close();
    commandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Router: ${widget.router.address}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: $connectionStatus'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: connectToRouter,
              child: const Text('Connect'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: commandController,
              decoration: const InputDecoration(
                labelText: 'Enter Command',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: useStreaming,
                  onChanged: (value) {
                    setState(() {
                      useStreaming = value ?? false;
                    });
                  },
                ),
                const Text('Use Stream'),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: executeCommand,
              child: const Text('Run Command'),
            ),
            const SizedBox(height: 20),
            const Text('Command Output:'),
            Expanded(
              child: SingleChildScrollView(
                child: Text(commandResult),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
