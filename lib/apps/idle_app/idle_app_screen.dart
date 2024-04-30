import 'package:flutter/material.dart';

class IdleAppScreen extends StatelessWidget {
  const IdleAppScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Idle App'),
      ),
      body: const Center(
        child: Text('Idle App'),
      ),
    );
  }
}
