import 'package:flutter/material.dart';

class QuizContainer extends StatelessWidget {
  final String question;
  final List<String> options;
  final Function(String) onOptionSelected;

  QuizContainer({
    required this.question,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          ...options.asMap().entries.map((entry) {
            int index = entry.key;
            String option = entry.value;
            return GestureDetector(
              onTap: () => onOptionSelected(option),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Gray border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent, // Icon color
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}', // Display index number
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
