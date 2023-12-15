import 'package:flutter/material.dart';

class summaryCard extends StatefulWidget {
  const summaryCard({
    super.key,
    required this.title,
    required this.num,
    required this.onStatusChange,
  });

  final String title, num;
  final VoidCallback onStatusChange;

  @override
  State<summaryCard> createState() => _summaryCardState();
}

class _summaryCardState extends State<summaryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18),
        child: Column(
          children: [
            Text(
              widget.num,
              style: const TextStyle(fontSize: 22),
            ),
            Text(widget.title),

          ],
        ),
      ),
    );
  }

  Future<void> callRefres() async {
    widget.onStatusChange();
  }
}
