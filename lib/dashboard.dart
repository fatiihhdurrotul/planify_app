import 'package:flutter/material.dart';
import 'alltask.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY LIST'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _buildGridItem(context, 'All Task', '20 items'),
            _buildGridItem(context, 'Personal', '20 items'),
            _buildGridItem(context, 'Work', '20 items'),
            _buildGridItem(context, 'Ideas', '20 items'),
            _buildGridItem(context, 'At Work', '20 items'),
            _buildGridItem(context, 'Urgent', '20 items'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title, String subtitle) {
    return GestureDetector(
      onTap: () {
        if (title == 'All Task') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AllTaskPage()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(subtitle, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
