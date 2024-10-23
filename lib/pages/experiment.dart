import 'package:flutter/material.dart';

class Experiment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFD2BCD5),
        body: Center(
            // عشان اخلي الصورة تبقي في نص الصفحة
            child: Text(
                "Normal User")), // ده نفس العنوان اللي انا ضيفته في ملف pubspec.yaml تحت ال assets و AssetImage اللي في الكود دي معناها إن انا بقوله هتاخد الصورة عن طريق ايه يعني دي بتمثلي ال provider اللي بعطي بيه الصورة
      ),
    );
  }
}
