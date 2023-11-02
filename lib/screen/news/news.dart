import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, snapshot) {
        return Container(
          width: size.width * 1,
          height: size.height * 0.15,
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                decoration: decorationDefinedShadow(
                  Theme.of(context).colorScheme.primaryContainer,
                  25,
                ),
              ),
              Positioned(
                top: -10,
                left: 0,
                child: SizedBox(
                    height: size.height * 0.14,
                    width: size.width * 0.4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25), // Image border
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(48), // Image radius
                        child: Image.network(
                            'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/cdd253101782941.5f28676168067.gif',
                            fit: BoxFit.cover),
                      ),
                    )),
              ),
              Positioned(
                left: size.width * 0.4,
                child: SizedBox(
                  width: size.width * 0.5,
                  height: size.height * 0.1,
                  child: const ListTile(
                    title: Text("Simpang Pulai"),
                    subtitle: SingleChildScrollView(
                      child: Text(
                        "Pokok tumbang berdekatan tol Simpang Pulai menghala ke arah laluan lampu isyarat",
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}








