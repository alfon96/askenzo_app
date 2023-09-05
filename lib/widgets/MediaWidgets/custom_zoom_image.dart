import 'package:ask_enzo_app/widgets/MediaWidgets/profile_image.dart';
import 'package:flutter/material.dart';

class CustomZoomProfileImage extends StatelessWidget {
  const CustomZoomProfileImage({
    super.key,
    required this.name,
    required this.surname,
    required this.imgPath,
  });

  final String name;
  final String surname;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: const CircleBorder(),
                backgroundColor: Colors.transparent,
                child: SizedBox(
                  height: 420,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      InteractiveViewer(
                        child: Center(
                          child: ProfileImage(
                            size: MediaQuery.of(context).size.width / 1.25,
                            name: name,
                            surname: surname,
                            imgPath: imgPath,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: IconButton(
                          icon: const Icon(
                            size: 28,
                            Icons.close,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      child: ProfileImage(
        size: 150,
        name: name,
        surname: surname,
        imgPath: imgPath,
      ),
    );
  }
}
