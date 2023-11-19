import 'package:flutter/material.dart';
import 'package:fyp_project/admin/identification_verifiy/widgets/front_back_ic.dart';
import 'package:fyp_project/admin/identification_verifiy/widgets/identification_info.dart';
import 'package:fyp_project/admin/identification_verifiy/widgets/list_identification.dart';
import 'package:fyp_project/admin/providers/form_provider.dart';
import 'package:fyp_project/constant.dart';
import 'package:lottie/lottie.dart';

class IdentificationVerification extends StatefulWidget {
  const IdentificationVerification({super.key});

  @override
  State<IdentificationVerification> createState() =>
      _IdentificationVerificationState();
}

class _IdentificationVerificationState
    extends State<IdentificationVerification> {
  late Future<List<Map<String, dynamic>>> identificationList;
  String? userUID;
  Map<String, dynamic>? identificationInfo;

  void setIdentificationOn(
    String user,
    Map<String, dynamic> info,
  ) {
    setState(() {
      userUID = user;
      identificationInfo = info;
    });
  }

  @override
  void initState() {
    identificationList = FormProvider().pickIdentificationList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        ListIdentification(
          identificationList: identificationList,
          userUID: userUID,
          setIdentificationOn: setIdentificationOn,
        ),
        userUID == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/help.json", repeat: false),
                  const Text(
                    "Helping people is a good deed. Have a nice day!",
                    style: textStyling,
                  )
                ],
              )
            : Expanded(
                child: Container(
                  height: size.height * 0.8,
                  margin: marginDefined,
                  decoration: decorationDefinedShadow(
                    Theme.of(context).colorScheme.onPrimary,
                    35,
                  ),
                  child: Row(
                    children: [
                      FrontBackIC(
                        identificationImage:
                            identificationInfo?["identificationImage"],
                      ),
                      Expanded(
                        child: IdentificationInfo(
                          identificationInfo: identificationInfo,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
