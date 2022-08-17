import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CreateReport extends StatelessWidget {
  CreateReport({Key? key, this.selectedEmergencyType}) : super(key: key);

  final List<String> emergencyTypeItems = [
    'Suspicious Individual',
    'Harassment',
    'Bullying',
    'Substance Abuse',
    'Animal Sighting'
        'Violence',
    'Bad Weather'
        'Accident',
    'Missing Person',
  ];

  String? selectedEmergencyType;
  String? selectedUrgencyType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF0F7),
      appBar: AppBar(
        title: const Text(
          'Create Report',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFEDF0F7),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('What is the type of your emergency?'),
            const SizedBox(height: 10),
            Container(
              // margin: const EdgeInsets.only(right: 20),
              child: DropdownButtonFormField2(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                isExpanded: true,
                hint: const Text(
                  'Select',
                  style: TextStyle(fontSize: 14),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
                buttonHeight: 50,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: emergencyTypeItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select the emergency type.';
                  }
                },
                onChanged: (value) {
                  //Do something when changing the item if you want.
                },
                onSaved: (value) {
                  selectedEmergencyType = value.toString();
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text('Description'),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black54,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              cursorColor: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text('Alert Urgency'),
            const SizedBox(height: 10),
            
          ],
        ),
      ),
    );
  }
}
