import 'package:flutter/material.dart';
import './dummy_data.dart';
import './filter_screen.dart';
import './tab_screen.dart';
import './category_meals.dart';
import './meal_detail_screen.dart';
import './categories_screen.dart';
import 'model/meal.dart';

void main() {
  runApp(MealsApp());
}

class MealsApp extends StatefulWidget {
  @override
  _MealsAppState createState() => _MealsAppState();
}

class _MealsAppState extends State<MealsApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> filteredMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void _setFilters(Map <String, bool> filteredData) {
    setState(() {
      filters = filteredData;
      filteredMeals = DUMMY_MEALS.where((mealItem){
        if(filters['gluten'] && !mealItem.isGlutenFree) {
          return false;
        }
        if(filters['lactose'] && !mealItem.isLactoseFree) {
          return false;
        }
        if(filters['vegan'] && !mealItem.isVegan) {
          return false;
        }
        if(filters['vegetarian'] && !mealItem.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toogleFavorite(String id) {
    final existingIndex = favoriteMeals.indexWhere((meal){
      return meal.id == id;
    });
    
    if(existingIndex >= 0) { //meal exist already in favorites
      setState(() {
        favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((mealItem){
          return mealItem.id == id;
        }));
      });
    }
  }

  bool isFavorite(String id) {
    return favoriteMeals.any((meal){
      return meal.id == id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            title: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoCondensed',
            )),
      ),
      title: 'Meals App',
      //home: TabScreen(),//PagerTabScreen(),
      routes: {
        '/': (ctx) => TabScreen(favoriteMeals),
        CategoryMeals.ROUTE_NAME: (ctx) => CategoryMeals(filteredMeals),
        MealDetailScreen.ROUTE_NAME: (ctx) => MealDetailScreen(_toogleFavorite, isFavorite),
        FilterScreen.ROUTE_NAME: (ctx) => FilterScreen(filters,_setFilters),
      },
      /*onGenerateRoute: (settings) {
        print (settings.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },*/
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
