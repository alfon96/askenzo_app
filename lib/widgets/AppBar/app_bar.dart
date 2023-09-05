import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';
import 'package:ask_enzo_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.fullTransparent = false,
    this.useLogo = false,
  });
  final String title;
  final bool fullTransparent;
  final bool useLogo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationNotifier = ref.read(navigationProvider.notifier);

    return AppBar(
        centerTitle: true,
        title: CustomText(
          text: title,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          centered: true,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        backgroundColor: fullTransparent
            ? const Color.fromARGB(0, 255, 255, 255)
            : Configurazione.colorePrimario,
        leading: useLogo
            ? Image.asset(
                'assets/images/logo/logo_ask_enzo.png',
                fit: BoxFit.fitHeight,
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => navigationNotifier.pop(),
              ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
