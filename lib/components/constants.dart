import 'package:flutter/material.dart';
import 'package:otherwise/screens/principale.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

const Color mainColor = Color.fromARGB(255, 106, 80, 220);
const Color secondColor = Color.fromARGB(255, 186, 78, 44);

void informationMessage(BuildContext context, String message, bool succes,
    PanaraDialogType typeMessage, Function() action) async {
  await PanaraInfoDialog.show(
    context,
    title: "Otherwise",
    message: message,
    buttonText: "Fermer",
    onTapDismiss: () {
      if (succes) {
        action;
      } else {
        Navigator.pop(context);
      }
    },
    panaraDialogType: typeMessage,
    barrierDismissible: false,
  );
}

confirmationMessage(
    BuildContext context, String message, Function() confirm) async {
  await PanaraConfirmDialog.show(
    context,
    title: "Otherwise",
    message: message,
    confirmButtonText: "Confirmer",
    cancelButtonText: "Annuler",
    onTapConfirm: () {
      confirm;
    },
    onTapCancel: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.success,
  );
}

class MessagePrincipal extends StatelessWidget {
  final String message;
  final Function()? confirm;

  MessagePrincipal({
    required this.message,
    required this.confirm,
  });

  @override
  Widget build(BuildContext context) {
    return PanaraConfirmDialog.show(
      context,
      title: "Otherwise !",
      message: message,
      confirmButtonText: "Confirmer",
      cancelButtonText: "Annuler",
      onTapConfirm: () => confirm,
      onTapCancel: () {
        Navigator.pop(context);
      },
      panaraDialogType: PanaraDialogType.success,
    );
  }
}
