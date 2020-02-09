import 'package:flutter/material.dart';
import './meal_item.dart';
import 'model/meal.dart';

class CategoryMeals extends StatelessWidget {
  static const ROUTE_NAME = 'category-meals';

  List<Meal> listofMeal(String id) {
    return filteredMeals.where((meal) {
      return meal.categories.contains(id);
    }).toList();
  }

  final List<Meal> filteredMeals;

  CategoryMeals(this.filteredMeals);

  @override
  Widget build(BuildContext context) {
    Map<String, String> routeArgs = ModalRoute.of(context).settings.arguments;
    final String id = routeArgs['id'];

    final meals = listofMeal(id);

    return Scaffold(
        appBar: AppBar(title: Text(routeArgs['title'])),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              title: meals[index].title,
              affordability: meals[index].affordability,
              duration: meals[index].duration,
              complexity: meals[index].complexity,
              imageUrl: meals[index].imageUrl,
              id: meals[index].id,
            );
          },
          itemCount: meals.length,
        ));
  }
}
