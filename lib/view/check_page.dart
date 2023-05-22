import 'package:flutter/material.dart';

class CustomKeyboard extends StatefulWidget {
  @override
  _CustomKeyboardState createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 10,
        children: List.generate(26, (index) {
          final String letter = String.fromCharCode(index + 65);
          final bool isAdjacentSelected =
              selectedIndex == index - 3 || selectedIndex == index + 1;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: EdgeInsets.all(4),
              height: isAdjacentSelected ? 80 : 60,
              width: isAdjacentSelected ? 80 : 60,
              decoration: BoxDecoration(
                color: isAdjacentSelected ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  letter,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
