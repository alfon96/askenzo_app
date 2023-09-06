import 'package:flutter/material.dart';
import 'package:ask_enzo_app/models/countries.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ask_enzo_app/providers/generic_provider.dart';
import 'package:ask_enzo_app/data/lingue.dart';

class DisplayFlagsPhoneCode extends ConsumerStatefulWidget {
  const DisplayFlagsPhoneCode({super.key});

  @override
  ConsumerState<DisplayFlagsPhoneCode> createState() =>
      _DispalyFlagsPhoneCodeState();
}
/// The `_DisplayFlagsPhoneCodeState` class is a stateful widget that displays a dialog with a search
/// bar and a list of flags, allowing the user to select a country flag.

class _DispalyFlagsPhoneCodeState extends ConsumerState<DisplayFlagsPhoneCode> {
  List<Country> items = countries;
  List<Country> filteredItems = countries;

  @override
  void initState() {
    super.initState();
    filteredItems = items;
  }

  void filterList(String keyword) {
    setState(() {
      filteredItems = items
          .where(
            (item) => item.name.toLowerCase().contains(
                  keyword.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageApp = ref.watch(genericProvider)[0];
    return Dialog(
      child: SizedBox(
        height: 300,
        width: 350,
        child: Column(children: [
          TextField(
            textCapitalization: TextCapitalization.sentences,
            onChanged: filterList,
            decoration: InputDecoration(
              hintText: PhoneNumberZone.researchPhoneZone[languageApp],
              hintStyle: const TextStyle(fontSize: 20),
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = filteredItems[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pop(context, item); // Return the selected item
                      ref
                          .read(genericProvider.notifier)
                          .toggleChosenCountry(item);
                    },
                    child: Flag(state: filteredItems[index]),
                  );
                }),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}

/// The `Flag` class is a stateless widget that displays a flag image, country name, and dial code.
class Flag extends StatelessWidget {
  const Flag({Key? key, required this.state}) : super(key: key);
  final Country state;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        'assets/flags/${state.code.toLowerCase()}.png',
        width: 32,
      ),
      title: Text(state.name),
      trailing: Text('+${state.dialCode}'),
    );
  }
}
