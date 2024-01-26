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
        height: mediaQuery.size.height * 0.6,
        width: mediaQuery.size.width * 1,
        decoration: decorationDefinedShadow(
            Theme.of(context).colorScheme.onPrimary, 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: marginDefined,
                child: Text(
                  "Kes ID: $kesID",
                  style: textStyling20,
                ),
              ),
              Container(
                height: mediaQuery.size.height * 0.4,
                width: mediaQuery.size.width * 0.9,
                margin: marginDefined,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Nama",
                          style: textStyling17,
                        ),
                        Text(
                          nama,
                          style: textStyling17,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "No Phone",
                          style: textStyling17,
                        ),
                        Text(
                          noPhone,
                          style: textStyling17,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "No Kad Pengenalan",
                          style: textStyling17,
                        ),
                        Text(
                          noKadPengenalan,
                          style: textStyling17,
                        )
                      ],
                    )
                  ],
                ),
              ),
              approval != null
                  ? approval == true
                      ? const Text(
                          "Permohonan Diterima",
                          style: textStyling17,
                        )
                      : const Text(
                          "Permohonan Sedang Dipantau",
                          style: textStyling17,
                        )
                  : Container(),
              Container(
                margin: marginDefined,
                child: message == ''
                    ? const Text(
                        "Harap maklum, maklumat dan kes anda sedang disiasat. Maklum balas akan disampaikan apabila sudah selesai",
                        style: textStyling17,
                      )
                    : Text(message,   style: textStyling17,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
