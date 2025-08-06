import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planto/view_model/home_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../data/reponse/status.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewModel.getAllPlants();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => homeViewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, value, child) {


          switch (value.getPlants.status) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Text('SOmething went wrong');
            case Status.COMPLETED:
              return Scaffold(
                body: ListView.builder(
                  itemCount: value.getPlants.data!.data!.length,
                  itemBuilder: (context, index) {
                    var plant = value.getPlants.data!.data![index];
                    return Container(
                      height: 200,
                      width: 200,
                      color: Colors.pink,
                      child: Column(
                        children: [
                          Image.network(plant.image.toString(), height: 50),
                          Text(
                            value.getPlants.data!.data![index].plantname
                                .toString(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            default:
              return Text('nothing');
          }
        },
      ),
    );
  }
}
