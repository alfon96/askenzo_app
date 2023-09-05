import 'package:ask_enzo_app/api/api_images.dart';
import 'package:ask_enzo_app/api/api_tourist.dart';
import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/data/lingue.dart';
import 'package:ask_enzo_app/models/tourist.dart';
import 'package:ask_enzo_app/providers/generic_provider.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/providers/users_provider.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/custom_elevated_button.dart';
import 'package:ask_enzo_app/widgets/ListTile/custom_list_tile.dart';
import 'package:ask_enzo_app/widgets/MediaWidgets/custom_zoom_image.dart';
import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

const double spacingHeight = 20.0;

class UserHomeProfile extends ConsumerStatefulWidget {
  const UserHomeProfile({super.key, required this.user});
  final Tourist user;

  @override
  ConsumerState<UserHomeProfile> createState() => _UserHomeProfileState();
}

class _UserHomeProfileState extends ConsumerState<UserHomeProfile> {
  Future<Container> profileImgMaker() async {
    bool isDeviceOnline =
        await ref.watch(genericProvider.notifier).isDeviceOnline();
    bool imageNotReady = widget.user.imgProfile.isEmpty || !isDeviceOnline;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfilePicture(
            name: '${widget.user.name} ${widget.user.surname}',
            radius: 65,
            fontsize: 71,
            img: imageNotReady ? null : widget.user.imgProfile,
          ),
        ],
      ),
    );
  }

  void refreshState(ScaffoldMessengerState scaffold) {
    apiTouristGetMyInfo(scaffold);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final languageApp = ref.watch(genericProvider)[0];
    final navigationNotifier = ref.read(navigationProvider.notifier);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),

          CustomZoomProfileImage(
            imgPath: widget.user.imgProfile,
            name: widget.user.name,
            surname: widget.user.surname,
          ),
          // ELIMINA FOTO?
          TextButton(
            onPressed: () async {
              ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);
              bool decision = await showDecisionDialog(context, [
                'Elimina foto',
                'Sei sicuro di voler eliminare la tua foto profilo?',
                'Annulla',
                'Conferma'
              ]);
              if (decision) {
                if (await apiTouristUpdateInfo(scaffold,
                    newImgProfile: 'null')) {
                  if (await apiDeleteImage(scaffold,
                      imgPath: widget.user.imgProfile)) {
                    setState(() {
                      // TO DO
                      widget.user.imgProfile = 'null';
                    });
                  }
                }
              }
              navigationNotifier.pop();
            },
            child: CustomText(
                text: LingueUsersProfiles.paginaSetup[languageApp]![0],
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Configurazione.coloreDeleteAccount),
          ),
          // NOME E COGNOME
          CustomText(
            text: '${widget.user.name} ${widget.user.surname}',
            color: Configurazione.colorePrimario,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: spacingHeight),
          // IMPOSTAZIONE ACCOUNT
          ListTile(
              title: CustomText(
            text: LingueUsersProfiles.paginaSetup[languageApp]![1],
            color: Configurazione.colorePrimario,
            centered: true,
          )),

          //MODIFICA PROFILO
          FieldAccount(
              user: widget.user,
              route: editProfileRoute,
              text: LingueUsersProfiles.paginaSetup[languageApp]![2],
              icon: Icons.edit),

          FieldAccount(
              user: widget.user,
              route: changePasswordRoute,
              text: LingueUsersProfiles.paginaSetup[languageApp]![4],
              icon: Icons.lock),

          FieldAccount(
            user: widget.user,
            route: deleteAccountRoute,
            text: 'Elimina Account',
            icon: Icons.lock,
            textColor: Colors.red,
            iconColor: Colors.red,
          ),

          // Log out
          const SizedBox(height: 40),
          CustomElevatedButton(
            title: 'Log Out',
            fun: () {
              ref.read(userProvider.notifier).logout();
              ref
                  .read(navigationProvider.notifier)
                  .pushReplacement(homeRoute, arguments: 1);
            },
            paddingHorizontal: 10.0,
          ),
        ],
      ),
    );
  }
}
