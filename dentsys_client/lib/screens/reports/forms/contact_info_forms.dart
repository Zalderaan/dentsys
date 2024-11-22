// lib/forms/personal_info_form.dart
import 'package:dentsys_client/controllers/contact_controller.dart';
import 'package:dentsys_client/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactInfoForms extends StatefulWidget {
  final Contact? contact;
  final TextEditingController emailController;
  final TextEditingController homeAddressController;
  final TextEditingController homeNoController;
  final TextEditingController faxNoController;
  final TextEditingController workNoController;
  final TextEditingController mobileNoController;

  const ContactInfoForms({
    super.key, 
    required this.emailController,
    required this.homeAddressController,
    required this.homeNoController,
    required this.faxNoController,
    required this.workNoController,
    required this.mobileNoController,
    required GlobalKey<FormState> formKey, 
    this.contact
  });

  @override
  ContactInfoFormsState createState() => ContactInfoFormsState();
}

class ContactInfoFormsState extends State<ContactInfoForms> {
  final _contactInformationFormKey =  GlobalKey<FormState>();

  // Future<void> handleUpdateContact() async {
  //   var patient_id = widget.contact?.patient_id;
  //   final updatedContact = Contact(
  //     patient_id: patient_id!,
  //     email: _emailController.text, 
  //     home_address: _homeAddressController.text,
  //     home_number: _homeNoController.text,
  //     fax_number: _faxNoController.text,
  //     work_number: _workNoController.text,
  //     mobile_number: _mobileNoController.text,
  //   );

  //   try {
  //     await contactController.updateContact(updatedContact);
  //     print('Contact updated successfully');
  //   } catch (error) {
  //     print('Error updating contact: $error');
  //   }
  // }

  // Contact getContactFormsData()
  // {  
  //   var patientId = widget.contact?.patient_id;
  //   return Contact (
  //     patient_id: patientId!, 
  //     email: _emailController.text, 
  //     home_address: _homeAddressController.text,
  //     home_number: _homeNoController.text,
  //     fax_number: _faxNoController.text,
  //     work_number: _workNoController.text,
  //     mobile_number: _mobileNoController.text,
  //   );
  // }

  @override
  void initState(){
    super.initState();
  }
  

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
                      controller: widget.homeAddressController,
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
                            controller:  widget.homeNoController,
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
                            controller: widget.workNoController,
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
                            controller: widget.faxNoController,
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
                            controller: widget.mobileNoController,
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
                            controller: widget.emailController,
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