import 'package:flutter/material.dart';
import './dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const ROUTE_NAME = 'meal-detal';
  final Function handler;
  final Function isFavoriteHandler;

  MealDetailScreen(this.handler, this.isFavoriteHandler);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((mealItem) {
      return mealItem.id == mealId;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                width: double.infinity,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildContainerTitle(context, 'Ingredients'),
              buildContainerListView(
                context,
                ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(
                          selectedMeal.ingredients[index],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                  itemCount: selectedMeal.ingredients.length,
                ),
              ),
              buildContainerTitle(context, 'Steps'),
              buildContainerListView(
                  context,
                  ListView.builder(
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              child: Text('# ${index + 1}'),
                            ),
                            title: Text(
                              selectedMeal.steps[index],
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                        ],
                      );
                    },
                    itemCount: selectedMeal.steps.length,
                  ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavoriteHandler(mealId) ? Icons.favorite : Icons.favorite_border,
        ),
        onPressed: (){
          handler(mealId);
        },
      ),
    );
  }

  Container buildContainerTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainerListView(BuildContext ctx, Widget child) {
    return Container(
        child: child,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        height: (MediaQuery.of(ctx).size.height -
                MediaQuery.of(ctx).padding.top -
                AppBar().preferredSize.height) *
            0.40,
        width: 330);
  }
}
