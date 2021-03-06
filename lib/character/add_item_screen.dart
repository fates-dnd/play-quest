import 'package:fates_for_quest/character/roll_outcomes_form.dart';
import 'package:fates_for_quest/data/character.dart';
import 'package:fates_for_quest/data/item.dart';
import 'package:fates_for_quest/data/roll_outcome.dart';
import 'package:fates_for_quest/model/character_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AddItemScreen extends StatefulWidget {
  final Character character;
  final int position;
  final Item? item;

  const AddItemScreen({
    Key? key,
    required this.character,
    required this.position,
    this.item,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddItemScreenState();
  }
}

class _AddItemScreenState extends State<AddItemScreen> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;

  var showRollOutcomes = false;

  Map<RollOutcome, String>? rollOutcomes;

  @override
  void initState() {
    nameController = TextEditingController()..text = widget.item?.name ?? "";
    descriptionController = TextEditingController()
      ..text = widget.item?.description ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text(
                    localization.name,
                    style: const TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextField(
                    controller: nameController,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Text(
                    localization.description,
                    style: const TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: descriptionController,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (showRollOutcomes)
                    RollOutcomesForm(
                      onRollOutcomesChange: (outcomes) {
                        rollOutcomes = outcomes;
                      },
                    )
                  else
                    OutlinedButton(
                      onPressed: () => setState(() {
                        showRollOutcomes = true;
                      }),
                      child: Text(localization.add_roll_outcomes),
                    )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<CharacterModel>(context, listen: false).setItemAt(
                  widget.character,
                  widget.position,
                  Item()
                    ..name = nameController.text
                    ..description = descriptionController.text
                    ..variableOutcome = rollOutcomes,
                );

                Navigator.of(context).pop();
              },
              child: Text(localization.add_new_item),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
