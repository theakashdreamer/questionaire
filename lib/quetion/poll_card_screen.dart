import 'package:flutter/material.dart';
class PollCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(child: PollCard()),
    );
  }
}

class PollCard extends StatefulWidget {
  @override
  _PollCardState createState() => _PollCardState();
}

class _PollCardState extends State<PollCard> {
  int? selectedOption;

  List<String> options = ['\$40,000', '\$55,000', '\$65,000', '\$75,000'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: buildPollCard(
          options,
          selectedOption,
              (index) {
            setState(() {
              selectedOption = index;
            });
          },
        ),
      ),
    );
  }
}
Widget buildPollCard(List<String> options, int? selectedOption, Function(int) onOptionSelected) {
  return Card(
    margin: EdgeInsets.all(16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Question
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "How much does an average barber make in San Francisco?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 12),

          // Radio Options
          ...List.generate(options.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: GestureDetector(
                onTap: () => onOptionSelected(index),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: selectedOption == index ? Colors.blue[100] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: selectedOption == index ? Colors.blue : Colors.grey[300]!,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        selectedOption == index
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: selectedOption == index ? Colors.blue : Colors.grey,
                      ),
                      SizedBox(width: 10),
                      Text(options[index]),
                    ],
                  ),
                ),
              ),
            );
          }),

          SizedBox(height: 12),

          // Stats
          Divider(height: 30),

          // Optional: Add bottom input again here if needed
        ],
      ),
    ),
  );
}

class Tag extends StatelessWidget {
  final String label;

  Tag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(fontSize: 12)),
    );
  }
}
