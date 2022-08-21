import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocode/geocode.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateReport extends StatefulWidget {
  CreateReport({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateReport> createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {
  final List<String> emergencyTypeItems = [
    'Suspicious Individual',
    'Harassment',
    'Bullying',
    'Substance Abuse',
    'Animal Sighting',
    'Violence',
    'Bad Weather',
    'Accident',
    'Missing Person',
  ];

  final List<String> emergencyPriority = [
    'Low',
    'Medium',
    'High',
  ];

  String? _address;
  String? selectedEmergencyType;
  String? selectedUrgencyType;

  final ImagePicker _picker = ImagePicker();

  late XFile? pickedImage = null;

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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('What is the type of your emergency?'),
                const SizedBox(height: 10),
                DropdownButtonFormField2(
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
                DropdownButtonFormField2(
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
                  items: emergencyPriority
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select the emergency level.';
                    }
                  },
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {
                    setState(() {
                      selectedUrgencyType = value.toString();
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Location'),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.white,
                      onPrimary: Colors.grey,
                      side: const BorderSide(
                        color: Colors.black54,
                        width: 1,
                        style: BorderStyle.solid
                      ),
                    ),
                    onPressed: () async {
                      LocationPermission permission;
                      permission = await Geolocator.requestPermission();

                      Position position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high,
                      );

                      // var altitude = position.altitude;
                      // var floor = position.floor;
                      // var latitude = position.latitude;
                      // var longitude = position.longitude;

                      GeoCode geoCode = GeoCode();
                      var address = await geoCode.reverseGeocoding(
                          latitude: position.latitude,
                          longitude: position.longitude);

                      var fullAddress =
                          '${address.streetNumber} ${address.streetAddress}, ${address.city}, ${address.region}, ${address.postal}';

                      setState(() {
                        _address = fullAddress;
                      });
                    },
                    child: const Text('Get current location'),
                  ),
                ),
                Text(_address != null ? _address! : "Please select location"),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.white,
                    onPrimary: Colors.grey,
                    side: const BorderSide(
                        color: Colors.black54,
                        width: 1,
                        style: BorderStyle.solid
                      ),
                  ),
                  onPressed: () async {
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);

                    setState(() {
                      pickedImage = image;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    width: double.infinity,
                    child: Column(children: const [
                      Icon(Icons.add_a_photo),
                      SizedBox(height: 10,),
                      Text('Upload Image'),
                    ]),
                  ),
                ),
                const SizedBox(height: 20.0),
                pickedImage != null
                    ? Image.file(File(pickedImage!.path))
                    : const Text('No image selected'),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ));
  }
}
