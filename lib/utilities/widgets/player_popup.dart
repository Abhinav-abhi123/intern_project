import 'package:flutter/material.dart';
import '../../service/state_management/AddPlayer/player_store.dart';
import '../../model/player_model.dart';
import '../app_color.dart';
import 'get_input.dart';

Future<void> showPlayerPopup({
  required BuildContext context,
  required PlayerStore store,
  Player? existingPlayer,
}) async {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: existingPlayer?.name ?? '');
  final emailController = TextEditingController(text: existingPlayer?.email ?? '');
  final phoneController = TextEditingController(text: existingPlayer?.phone ?? '');
  final dateController = TextEditingController(text: existingPlayer?.date ?? '');
  final stateController = TextEditingController(text: existingPlayer?.state ?? '');
  final zipController = TextEditingController(text: existingPlayer?.zip ?? '');

  final isEdit = existingPlayer != null;

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: AppColors.purewhite,
      title: Text(isEdit ? 'Edit Player' : 'Add Player'),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: PlayerFormFields(
            formKey: formKey,
            nameController: nameController,
            emailController: emailController,
            phoneController: phoneController,
            dateController: dateController,
            stateController: stateController,
            zipController: zipController,
          ),
        ),
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.popbutton,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                String message = '';

                if (isEdit) {
                  // ✅ Update player
                  final updatedPlayer = existingPlayer!.copyWith(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    date: dateController.text,
                    state: stateController.text,
                    zip: zipController.text,
                    updatedAt: DateTime.now().toIso8601String(),
                  );

                  await store.updatePlayer(updatedPlayer);
                  message = 'Player updated successfully';
                } else {
                  // ✅ Add new player
                  final newPlayer = Player(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    date: dateController.text,
                    state: stateController.text,
                    zip: zipController.text,
                    createdAt: DateTime.now().toIso8601String(),
                    updatedAt: '',
                  );

                  await store.addPlayer(newPlayer);
                  message = 'Player added successfully';
                }

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Text(
              isEdit ? 'Update' : 'Submit',
              style: TextStyle(color: AppColors.purewhite),
            ),
          ),
        ),
      ],
    ),
  );
}
