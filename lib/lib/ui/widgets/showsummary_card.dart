import 'package:flutter/material.dart';

class summaryCard extends StatelessWidget {
  const summaryCard({
    super.key, required this.title, required this.num,
  });
  final String title,num;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0,horizontal: 18),
        child: Column(
          children: [
            Text(num,style: TextStyle(fontSize: 22),),
            Text(title),
          ],
        ),
      ),
    );
  }
}
