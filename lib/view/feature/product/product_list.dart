import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_na_wewe_sacco/domain/model/product_entity.dart';
import 'package:mimi_na_wewe_sacco/view/feature/product/product.dart';
import 'package:mimi_na_wewe_sacco/view/feature/product/product_detail.dart';
import 'package:mimi_na_wewe_sacco/view/widget/data_driven/products_container.dart';

import '../../widget/data_driven/product_container.dart';
import '../../widget/widgets.dart';
import 'product_bloc.dart';

class ProductListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListScreenState();
  }
}

class _ProductListScreenState extends State<ProductListScreen> {
  // This is the entered code
  // It will be displayed in a Text widget
  late double sizeBetween;
  late ProductBloc productBloc;

  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc.add(ShowProductPressed());
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    sizeBetween = height / 20;
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Container(
            child: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductProcessingState) {
                return buildLoading();
              } else if (state is ProductLoaded) {
                return productList(state.products!);
              } else if (state is ProductErrorState) {
                return buildErrorUi(state.error);
              }
              return Container();
            },
          ),
        )));
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  productList(List<ProductEntity> products) {
    if (products.isEmpty) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "https://res.cloudinary.com/pesabank-limited/image/upload/v1645600738/image_2022-02-10_15-37-48_rn0ehm.png",
            width: getProportionalScreenWidth(200),
            height: getProportionalScreenHeight(200),
          ),
          const Text("You have no products. Please add your products.")
        ],
      ));
    } else {
      return ListView.builder(
        itemCount: products.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                              productEntity: products[index],
                            )));
              },
              child: ProductsContainer(productEntity: products, index: index));
        },
      );
    }
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("$label", style: headingtextStyle),
          SizedBox(
            height: getProportionalScreenHeight(5),
          ),
          Text(
            value,
            style: headingtextStyle,
          )
        ],
      ),
    );
  }

  // void navigateToEditProfile(
  //     BuildContext context, ProfileEntity profileEntity) {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return EditProfileScreen(
  //       profileEntity: profileEntity,
  //     );
  //   }));
  // }

  // void navigateToAoutPage(BuildContext context) {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return AboutPage();
  //   }));
  // }
}
