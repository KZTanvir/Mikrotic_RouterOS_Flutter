import 'package:flutter/material.dart';
import 'add_router.dart'; // Page for adding a new router
import 'edit_router.dart'; // Page for editing an existing router
import 'model.dart'; // RouterInfo model
import 'router_info.dart'; // RouterDetailsPage for viewing router details

class RouterListPage extends StatefulWidget {
  const RouterListPage({super.key});

  @override
  State<RouterListPage> createState() => _RouterListPageState();
}

class _RouterListPageState extends State<RouterListPage> {
  // List to store all routers
  final List<RouterInfo> routers = [];

  // Function to add a new router
  void addRouter() async {
    // Navigate to AddRouterPage and wait for the new router data
    final newRouter = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddRouterPage()),
    );

    // If a router is returned, add it to the list
    if (newRouter != null && newRouter is RouterInfo) {
      setState(() {
        routers.add(newRouter);
      });
    }
  }

  // Function to edit an existing router
  void editRouter(int index) async {
    // Navigate to EditRouterPage and pass the selected router
    final updatedRouter = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditRouterPage(router: routers[index]),
      ),
    );

    // If a router is returned, update it in the list
    if (updatedRouter != null && updatedRouter is RouterInfo) {
      setState(() {
        routers[index] = updatedRouter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routers'),
      ),
      body: routers.isEmpty
          ? const Center(
              child: Text('No routers added yet. Click "+" to add one.'),
            )
          : ListView.builder(
              itemCount: routers.length,
              itemBuilder: (context, index) {
                final router = routers[index];
                return ListTile(
                  title: Text(router.address),
                  subtitle: Text('Port: ${router.port}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Button to navigate to the RouterDetailsPage
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RouterDetailsPage(router: router),
                            ),
                          );
                        },
                        child: const Text('Details'),
                      ),
                      const SizedBox(width: 10),
                      // Button to edit the router
                      ElevatedButton(
                        onPressed: () => editRouter(index),
                        child: const Text('Edit'),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: addRouter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
