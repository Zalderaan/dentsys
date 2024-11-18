// lib/forms/personal_info_form.dart
import 'package:dentsys_client/controllers/contact_controller.dart';
import 'package:flutter/material.dart';

class ContactInfoForms extends StatefulWidget {

   const ContactInfoForms({super.key, required GlobalKey<FormState> formKey});

  @override
  ContactInfoFormsState createState() => ContactInfoFormsState();
}

class ContactInfoFormsState extends State<ContactInfoForms> {
  final _contactInformationFormKey =  GlobalKey<FormState>();
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _homeAddressController = TextEditingController();
  final TextEditingController _homeNoController = TextEditingController();
  final TextEditingController _faxNoController = TextEditingController();
  final TextEditingController _workNoController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final ContactController contactController = ContactController();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _contactInformationFormKey,
        child: Column(
          children: [
            // (Contact Information  fields)
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Contact Information",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      height: 10,
                      color: Colors.grey[400],
                      thickness: 0.5,
                    ),
                    const SizedBox(height: 10),
                    // Home Adress
                    TextFormField(
                      controller: _homeAddressController,
                      decoration: const InputDecoration(
                        labelText: "Home Address",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This item is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    // Home Number, Office Number, Fax Number
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller:  _homeNoController,
                            decoration: const InputDecoration(
                              labelText: "Home Number",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This item is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _workNoController,
                            decoration: const InputDecoration(
                              labelText: "Office Number",
                              border: OutlineInputBorder(),
                              ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This item is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _faxNoController,
                            decoration: const InputDecoration(
                              labelText: "Fax Number",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This item is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      
                      ],
                    ),
                    const SizedBox(height: 10),
                    //Contact Number and Email
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _mobileNoController,
                            decoration: const InputDecoration(
                              labelText: "Contact Number",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This item is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: "Email Address",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This item is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
    );
  }
}