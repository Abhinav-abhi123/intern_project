import 'package:flutter/material.dart';
import '../utilities.dart';

class PlayerFormFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController dateController;
  final TextEditingController stateController;
  final TextEditingController zipController;

  const PlayerFormFields({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.dateController,
    required this.stateController,
    required this.zipController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Enter a name',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppColors.purewhite,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.inputboder,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.inputboder,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.inputline,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 1, 2, 1),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            SizedBox(height: 30),
            // Email
            TextFormField(
              controller: emailController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Enter an email',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppColors.purewhite,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.inputboder,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.inputboder,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.inputline,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 1, 2, 1),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                } else if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 30),
            // Phone
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    initialValue: '+91',
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      fillColor: AppColors.purewhite,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColors.inputboder,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColors.inputboder,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColors.inputline,
                          width: 2,
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(10, 1, 2, 1),
                    ),
                    enabled: false,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: phoneController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Enter a phone number',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: AppColors.purewhite,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColors.inputboder,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColors.inputboder,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColors.inputline,
                          width: 2,
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 1, 2, 1),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Please enter a valid 10-digit number';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            // Date
            TextFormField(
              controller: dateController,
              style: TextStyle(color: Colors.black),
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Enter a date',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppColors.purewhite,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.inputboder,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.inputboder,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.inputline,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 1, 2, 1),
                suffixIcon: GestureDetector(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      dateController.text = "${date.day}-${date.month}-${date.year}";
                    }
                  },
                  child: Icon(Icons.calendar_today),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a date';
                }
                return null;
              },
            ),
            SizedBox(height: 30),
            // State
            TextFormField(
              controller: stateController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Enter a state',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppColors.purewhite,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.inputboder,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.inputboder,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.inputline,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 1, 2, 1),
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a state';
                }
                return null;
              },
            ),
            SizedBox(height: 30),
            // Zip
            TextFormField(
              controller: zipController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Enter a pin code',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppColors.purewhite,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.inputboder,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.inputboder,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.inputline,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 2, 2, 1),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a pin code';
                } else if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                  return 'Please enter a valid 6-digit zip code';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
