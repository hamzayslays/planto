import 'package:flutter/material.dart';
import '../data/reponse/api_response.dart';
import '../model/category_model.dart';
import '../model/item_mode.dart';
import '../model/plants_model.dart';
import '../repositories/plants_repo.dart';

class HomeViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> item = [
    {
      'Image': '',
      'Price': 200,
      'Title': 'ALovera',
      'Des':
      'loerm ipsojsNJ EWWjFVJ V sjv Vprice: provider.gridPrice[index].toStringAsFixed(2)',
    },

    {
      'Image': '',
      'Price': 200,
      'Title': 'ALovera',
      'Des':
      'loerm ipsojsNJ EWWjFVJ V sjv Vprice: provider.gridPrice[index].toStringAsFixed(2)',
    },
  ];

  final List<String> imagePaths = [
    'asset/caousel1.png',
    'asset/vibrant-green-plant-beige-pot-peaceful-home-decor.png',
    'asset/Rose Gold Feminine Calligraphy Monogram Logo(20) 7.png',
  ];

  final List<String> textTitle = ['Desk Plant', 'Calathea Plant', 'Show plant'];

  final List<String> subTitle = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing been the consectetur adipiscing been the  ',
    'Lorem ipsum dolor sit amet, consectetur adipiscing been the consectetur adipiscing been the ',
    'Lorem ipsum dolor sit amet, consectetur adipiscing been the consectetur adipiscing been the ',
  ];

  final List<String> gridImagePaths = [
    'asset/logo.png',
    'asset/calathea plant image.png',
    'asset/caousel1.png',
    'asset/logo.png',
    'asset/vibrant-green-plant-beige-pot-peaceful-home-decor.png',
    'asset/eco.png',
    'asset/Rose Gold Feminine Calligraphy Monogram Logo(20) 7.png',
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
    'Snake Plant',
    'Peace Lily',
    'Aloe Vera',
    'Spider Plant',
    'Calathea Orbifolia',
    'Fiddle Leaf Fig',
    'ZZ Plant',
    'Pothos Golden',
  ];

  List<String> gridPrice = ['35', '41', '69', '56', '35', '41', '69', '56'];

  final PlantsRepo plantsRepo = PlantsRepo();

  ApiResponse<PlantsModel> getPlants = ApiResponse.loading();

  void setPlantLoading(ApiResponse<PlantsModel> response) {
    getPlants = response;
    notifyListeners();
  }

  Future<void> getAllPlants() async {
    print("Fetching Plants data...");

    setPlantLoading(ApiResponse.loading()); // Set loading state

    try {
      // Fetch data from the repository (with delay handled inside the repository)

      final response = await plantsRepo.getPlants();

      print("API Response: $response");

      // Check success field

      if (response != null) {
        // Parse and set data if successful

        final PlantsModel plantsModel = PlantsModel.fromJson(response);

        setPlantLoading(ApiResponse.completed(plantsModel));
      } else {
        // Handle failure

        final String message = response['message'] ?? "An error occurred";

        print("Error message from API: $message");

        setPlantLoading(ApiResponse.error(message)); // Update to ERROR state
      }
    } catch (error) {
      // Handle exceptions and update the state to ERROR

      print("Exception occurred: $error");

      setPlantLoading(ApiResponse.error(error.toString()));
    }
  }
}

List<ItemModel> allItems = [
  ItemModel(
    title: "Snake Plant",
    price: 35,
    image: "asset/logo.png",
    description: "Low-maintenance indoor plant",
  ),
  ItemModel(
    title: "Aloe Vera",
    price: 69,
    image: "asset/logo.png",
    description: "Healing medicinal plant",
  ),
];
