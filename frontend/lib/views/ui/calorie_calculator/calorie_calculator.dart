import 'package:fitness/models/food_item.dart';
import 'package:fitness/providers/calc_providers.dart';
import 'package:fitness/services/calc_services.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:fitness/views/utils/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalorieCalculator extends HookWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final foodItemProvider = useProvider(changeState);
    Size size = MediaQuery.of(context).size;
    String query = "";

    return Background(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            foodItemProvider.state = FoodItem();
            Navigator.pop(context);
          },
        ),
        header: "",
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height * .45,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      "Get nutrition informations of your meals!",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    Form(
                      key: formKey,
                      child: SearchBar(
                        onSaved: (val) {
                          query = val;
                        },
                        onSearch: () async {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            foodItemProvider.state =
                                await CalcServices().getMealInfo(query);
                          }
                        },
                      ),
                    ),
                    Text(
                      "Example: One 14oz prime rib and mashed potatoes.",
                      style: TextStyle(
                          color: Colors.black38,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Card(
                      child: ListTile(
                        title: Text(() {
                          if (foodItemProvider.state.items == null) {
                            return "Please insert your meal to see nutrition informations";
                          } else {
                            return "Total Calories: ${foodItemProvider.state.totalCal.toStringAsFixed(2)} Cal";
                          }
                        }()),
                        subtitle: Text(() {
                          if (foodItemProvider.state.items == null) {
                            return "";
                          } else {
                            return "Total items: ${foodItemProvider.state.items.length}";
                          }
                        }()),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: foodItemProvider.state.items == null
                                ? 0
                                : foodItemProvider.state.items.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.fastfood),
                                      title: Text(
                                          '${foodItemProvider.state.items[index].name}'),
                                      subtitle: Text(
                                          'Calories: ${foodItemProvider.state.items[index].calories}'),
                                    ),
                                  ],
                                ),
                              );
                            }))
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
