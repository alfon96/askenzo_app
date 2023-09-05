import 'dart:io';
import 'package:ask_enzo_app/api/api_tourist.dart';
import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/models/tourist.dart';
import 'package:ask_enzo_app/providers/generic_provider.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/providers/users_provider.dart';
import 'package:ask_enzo_app/screens/Profiles/user_home_profile.dart';
import 'package:ask_enzo_app/shared/images_db_handling.dart';
import 'package:ask_enzo_app/shared/shared_functions.dart';
import 'package:ask_enzo_app/shared/validators.dart';
import 'package:ask_enzo_app/widgets/AppBar/app_bar.dart';
import 'package:ask_enzo_app/widgets/CardsAndButtons/custom_elevated_button.dart';
import 'package:ask_enzo_app/widgets/Drawer/custom_drawer.dart';
import 'package:ask_enzo_app/widgets/Form/custom_text_form_field.dart';
import 'package:ask_enzo_app/widgets/MediaWidgets/profile_image.dart';
import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:ask_enzo_app/widgets/waiting/custom_waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key, required this.user});
  final Tourist user;

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  File? image;
  bool isLoading = false;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  TextEditingController editedName = TextEditingController();
  TextEditingController editedSurname = TextEditingController();
  TextEditingController editedEmail = TextEditingController();
  TextEditingController editedPhone = TextEditingController();
  TextEditingController imgPath = TextEditingController();
  bool isChangingPic = false;

  @override
  void dispose() {
    editedName.dispose();
    editedSurname.dispose();
    editedEmail.dispose();
    editedPhone.dispose();
    imgPath.dispose();

    super.dispose();
  }

  Future<File?> getImage(bool isCamera) async {
    final pickedFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<void> saveImage(
    File image,
    ScaffoldMessengerState scaffold,
  ) async {
    String? resultPath;

    if (widget.user.imgProfile.isEmpty) {
      resultPath = await changeImage(scaffold, image);
    } else {
      {
        resultPath = await changeImage(scaffold, image,
            oldImgPath: widget.user.imgProfile);
      }
    }
    if (resultPath != null) {
      clearImageCache(resultPath);
      imgPath.text = resultPath;
      setState(() {});
    }
  }

  void salvaModifiche(navigationNotifier) async {
    ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);
    NavigatorState navigator = Navigator.of(context);
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        bool confirm = await showDecisionDialog(
          context,
          [
            'Modifica Profilo',
            'Sei sicuro di voler aggiornare le tue informazioni?',
            'Annulla',
            'Conferma'
          ],
        );
        if (confirm) {
          navigator.pop();
          setState(() {
            isLoading = true;
          });
          if (imgPath.text != widget.user.imgProfile && image != null) {
            await saveImage(image!, scaffold);
          }
          if (await apiTouristUpdateInfo(
            scaffold,
            newName: editedName.text,
            newSurname: editedSurname.text,
            newEmail: editedEmail.text,
            newImgProfile: imgPath.text,
            newTelephone: editedPhone.text,
          )) {
            setState(() {
              isLoading = false;
            });
            ref.read(userProvider.notifier).toggleRefreshUserData(scaffold);
            showCustomSnackBar(scaffold, 'Dati aggiornati correttamente');
          }
        }
      }
    }
    navigationNotifier.pop();
  }

  @override
  void initState() {
    imgPath.text = widget.user.imgProfile;
    editedName.text = widget.user.name;
    editedSurname.text = widget.user.surname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navigationNotifier = ref.watch(navigationProvider.notifier);
    void updateImageFun() async {
      bool isDeviceOnline =
          await ref.watch(genericProvider.notifier).isDeviceOnline();
      if (isDeviceOnline) {
        showModalBottomSheet(
            context: scaffoldKey.currentContext!,
            builder: (BuildContext bc) {
              return Wrap(
                alignment: WrapAlignment.start,
                children: <Widget>[
                  const ListTile(
                      title: CustomText(
                    text: 'Modifica Immagine',
                    centered: true,
                    fontSize: 16,
                    color: Configurazione.colorePrimario,
                  )),
                  ListTile(
                      leading: const Icon(
                        Icons.camera,
                        color: Configurazione.colorePrimario,
                      ),
                      title: const CustomText(text: 'Fotocamera'),
                      onTap: () async {
                        NavigatorState navigator = Navigator.of(context);
                        image = await getImage(true);
                        if (image != null) {
                          setState(() {
                            imgPath.text = image!.path;
                          });
                        }
                        navigator.pop();
                      }),
                  ListTile(
                    leading: const Icon(
                      Icons.image,
                      color: Configurazione.colorePrimario,
                    ),
                    title: const CustomText(text: 'Galleria'),
                    onTap: () async {
                      NavigatorState navigator = Navigator.of(context);
                      image = await getImage(false);
                      if (image != null) {
                        setState(() {
                          imgPath.text = image!.path;
                        });
                      }
                      navigator.pop();
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              );
            });
      }
    }

    return CustomWaitingWidget(
      isWaiting: isLoading,
      child: WillPopScope(
        onWillPop: () async {
          navigationNotifier.pop();
          return false;
        },
        child: Scaffold(
          appBar: const CustomAppBar(
            title: 'Modifica Profilo',
            useLogo: false,
          ),
          key: scaffoldKey,
          endDrawer: const CustomDrawer(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: spacingHeight * 2),
                    GestureDetector(
                      onTap: () async => updateImageFun(),
                      child: ProfileImage(
                        size: 160,
                        imgPath: imgPath.text,
                        name: editedName.text,
                        surname: editedSurname.text,
                      ),
                    ),
                    const SizedBox(height: spacingHeight * 2),
                    CustomTextFormField(
                      title: 'Nome',
                      initialValue: widget.user.name,
                      fieldValue: editedName,
                      validatorFun: validateUsername,
                    ),
                    const SizedBox(height: spacingHeight),
                    CustomTextFormField(
                      title: 'Cognome',
                      initialValue: widget.user.surname,
                      fieldValue: editedSurname,
                      validatorFun: validateUsername,
                    ),
                    const SizedBox(height: spacingHeight),
                    CustomTextFormField(
                      title: 'Nuemero di Telefono',
                      initialValue: widget.user.telephone,
                      fieldValue: editedPhone,
                      validatorFun: validatePhone,
                    ),
                    const SizedBox(height: spacingHeight),
                    CustomTextFormField(
                      title: 'Indirizzo email',
                      initialValue: widget.user.email,
                      fieldValue: editedEmail,
                      validatorFun: validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: spacingHeight * 2),
                    CustomElevatedButton(
                        title: 'Salva Modifiche',
                        fun: () => salvaModifiche(navigationNotifier))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
