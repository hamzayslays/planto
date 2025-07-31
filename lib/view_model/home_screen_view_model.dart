import 'package:flutter/material.dart';
import '../model/category_model.dart';

class HomeViewModel extends ChangeNotifier {
  final List<String> imagePaths = [
    'asset/caousel1.png',
    'asset/vibrant-green-plant-beige-pot-peaceful-home-decor.png',
    'asset/Rose Gold Feminine Calligraphy Monogram Logo(20) 7.png',
  ];

  final List<String> textTitle = [
     'Desk Plant',
    'Calathea Plant',
    'Show plant'
  ];

  final List<String> subTitle =[
    'Lorem ipsum dolor sit amet, consectetur adipiscing been the consectetur adipiscing been the  ' ,
    'Lorem ipsum dolor sit amet, consectetur adipiscing been the consectetur adipiscing been the ' ,
    'Lorem ipsum dolor sit amet, consectetur adipiscing been the consectetur adipiscing been the ' ,
  ];


  final List<String> gridImagePaths = [
    'asset/logo.png',
    'asset/logo.png',
    'asset/logo.png',
    'asset/logo.png',
    'asset/logo.png',
    'asset/logo.png',
    'asset/logo.png',

  ];

  final List<String> gridTitles = [
    'Snake Plant',
    'Peace Lily',
    'Aloe Vera',
    'Spider Plant',
  ];

  List<CategoryModel> categories = [
    CategoryModel(icon: Icons.spa, name: 'Indoor'),
    CategoryModel(icon: Icons.park, name: 'Outdoor'),
    CategoryModel(icon: Icons.eco, name: 'Succulent'),
  ];

  List<String> gridNames = [
    'Calathea ai plant',
    'Calathea ai plant',
    'Calathea ai plant',
    'Calathea ai plant','Calathea ai plant',
    'Calathea ai plant',
    'Calathea ai plant',
    'Calathea ai plant',

  ];

  List<String> gridPrice = [
    '35',
    '41',
    '69',
    '56', '35',
    '41',
    '69',
    '56',

  ];


}
