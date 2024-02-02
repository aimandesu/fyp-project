import 'package:flutter/material.dart';
import '../../report_incident/report_incident.dart';

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                SizedBox(width: 10),
                Image(
                  image: AssetImage('assets/images/alarm.png'),
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 10),
                Flexible(
                  child: ListTile(
                    title: Text(
                      "Laporan Kecelakaan",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      "Bantu hantar laporan jikalau ada kejadian bahaya semula jadi berlaku di kawasan persekitaran",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(ReportIncidence.routeName),
              child: Container(
                width: size.width * 1,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                child: const Center(
                  child: Text("Lapor"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
