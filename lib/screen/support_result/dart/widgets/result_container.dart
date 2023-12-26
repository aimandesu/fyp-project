import 'package:flutter/material.dart';
import '../../../../constant.dart';

class ResultContainer extends StatelessWidget {
  const ResultContainer({
    super.key,
    required this.kesID,
    required this.nama,
    required this.noPhone,
    required this.noKadPengenalan,
    required this.message,
    required this.approval,
  });

  final String kesID;
  final String nama;
  final String noPhone;
  final String noKadPengenalan;
  final String message;
  final bool? approval;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: marginDefined,
        height: mediaQuery.size.height * 0.5,
        width: mediaQuery.size.width * 1,
        decoration: decorationDefinedShadow(
            Theme.of(context).colorScheme.primaryContainer, 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: marginDefined,
              child: Text("Kes ID: $kesID"),
            ),
            Container(
              height: mediaQuery.size.height * 0.3,
              width: mediaQuery.size.width * 0.9,
              margin: marginDefined,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [const Text("Nama"), Text("$nama")],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("No Phone"), Text("$noPhone")],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("No Kad Pengenalan"),
                      Text(" $noKadPengenalan")
                    ],
                  )
                ],
              ),
            ),
            approval != null
                ? approval == true
                    ? const Text("diterima")
                    : const Text("ditolak")
                : Container(),
            Container(
              margin: marginDefined,
              child: message == ''
                  ? const Text(
                      "Harap maklum, maklumat dan kes anda sedang disiasat. Maklum balas akan disampaikan apabila sudah selesai",
                    )
                  : Text(message),
            ),
          ],
        ),
      ),
    );
  }
}
