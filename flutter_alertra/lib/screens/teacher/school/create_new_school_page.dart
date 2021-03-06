import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_alertra/constants/constants.dart';
import 'package:flutter_alertra/services/APIServices.dart';
import 'package:flutter_alertra/widgets/custom_button.dart';
import 'package:flutter_alertra/widgets/custom_textfield.dart';

class CreateNewSchoolPage extends StatefulWidget {
  const CreateNewSchoolPage({Key? key}) : super(key: key);

  @override
  _CreateNewSchoolPageState createState() => _CreateNewSchoolPageState();
}

class _CreateNewSchoolPageState extends State<CreateNewSchoolPage> {
  final nameController = new TextEditingController();
  final addressController = new TextEditingController();
  final cityController = new TextEditingController();
  final stateController = new TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New School'),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  CustomTextField(controller: nameController, hintText: 'Name'),
                  SizedBox(height: kDefaultPadding),
                  CustomTextField(
                      controller: addressController, hintText: 'Address'),
                  SizedBox(height: kDefaultPadding),
                  CustomTextField(controller: cityController, hintText: 'City'),
                  SizedBox(height: kDefaultPadding),
                  CustomTextField(
                      controller: stateController, hintText: 'State'),
                  SizedBox(height: 2 * kDefaultPadding),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await context.read<APIServices>().createSchool(
                          nameController.text,
                          addressController.text,
                          cityController.text,
                          stateController.text);
                      Navigator.pop(context);
                    },
                    child: CustomButton(purpose: 'other', text: 'CREATE'),
                  ),
                ],
              ),
      ),
    );
  }
}
