import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mimi_na_wewe_sacco/config/routes.dart';
import '../../../data/validators/validator.dart';
import '../../../domain/model/profile_entity.dart';
import '../../widget/widgets.dart';
import '../profile/profile.dart';
import '../profile/profile_bloc.dart';
import 'product_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddProductScreenState();
  }
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDescController = TextEditingController();
  final TextEditingController productStatusController = TextEditingController();
  final TextEditingController dateLaunchedController = TextEditingController();
  int? selectMonthValue;
  int? selectedYearValue;
  DateTime? productCreatedDate;
  String? selectedCountryValue = 'Kenya';

  String productTypeSelectedValue = 'Long term';
  String? productBrandSelectedType;
  late ProfileBloc profileBloc;
  ProfileEntity? profileEntity;

  List<String>? productTypes = [
    "Car Mortgage",
    "Electronics",
    "House Mortgage"
  ];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(ShowProfilePressed());
  }

  late double sizeBetween;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    sizeBetween = height / 20;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Product',
          style: TextStyle(color: kWhiteColor),
        ),
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.arrowAltCircleLeft,
            color: kWhiteColor,
          ),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              MimiNaWeweSacco.home,
              (Route<dynamic> route) => false,
            );
          },
        ),
        backgroundColor: kSecondaryColor,
        elevation: 0,
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          // on success delete navigator stack and push to home
          if (state is ProductFinishedState) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              MimiNaWeweSacco.productList,
              (Route<dynamic> route) => false,
            );
          }
          // on failure show a snackbar
          if (state is ProductErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          // show loading screen while processing
          if (state is ProductProcessingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionalScreenWidth(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        height: SizeConfiguration.screenHeight * 0.02), // 4%
                    Text(
                      "Enter product details",
                      style: textStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfiguration.screenHeight * 0.04),
                    SizedBox(
                        width: getProportionalScreenWidth(300),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: getProportionalScreenHeight(20)),
                              SizedBox(
                                  width: SizeConfiguration.screenWidth * 0.8,
                                  child: buildProductNameFormField()),
                              SizedBox(height: getProportionalScreenHeight(20)),
                              SizedBox(
                                  width: SizeConfiguration.screenWidth * 0.8,
                                  child: buildProductDescFormField()),
                              SizedBox(height: getProportionalScreenHeight(30)),
                              SizedBox(
                                  width: SizeConfiguration.screenWidth * 0.8,
                                  child: buildProductTypeDropdownButtonField()),
                              SizedBox(height: getProportionalScreenHeight(30)),
                              SizedBox(
                                  width: SizeConfiguration.screenWidth * 0.8,
                                  child: buildProductStatusFormField()),
                              SizedBox(height: getProportionalScreenHeight(20)),
                              SizedBox(
                                  width: SizeConfiguration.screenWidth * 0.8,
                                  child: buildDateTimeField()),
                              SizedBox(height: getProportionalScreenHeight(20)),
                              OverallButton(
                                  text: 'Add Product',
                                  press: () {
                                    BlocBuilder<ProfileBloc, ProfileState>(
                                        builder: (context, state) {
                                      if (state is ProfileLoaded) {
                                        profileEntity = state.profileEntity;
                                        _validateAndSend(profileEntity!);
                                      }
                                      return buildLoading();
                                    });
                                  }),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: sizeBetween,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(getProportionalScreenHeight(8)),
        child: Text(
          message,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  TextFormField buildProductNameFormField() {
    return TextFormField(
        controller: productNameController,
        validator: Validator.valueExists,
        decoration: InputDecoration(
            labelText: "Product Name",
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(getProportionalScreenHeight(25)),
              borderSide: const BorderSide(),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always));
  }

//Product Details
  TextFormField buildProductDescFormField() {
    return TextFormField(
        controller: productDescController,
        maxLines: 2,
        keyboardType: TextInputType.text,
        validator: Validator.valueExists,
        decoration: InputDecoration(
            labelText: "Product Description",
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(getProportionalScreenHeight(25)),
              borderSide: const BorderSide(),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always));
  }

  // TextFormField buildDateLaunchedFormField() {
  //   return TextFormField(
  //       controller: dateLaunchedController,
  //       validator: Validator.valueExists,
  //       keyboardType: TextInputType.text,
  //       decoration: InputDecoration(
  //           labelText: "Date Launched",
  //           fillColor: Colors.grey,
  //           border: OutlineInputBorder(
  //             borderRadius:
  //                 BorderRadius.circular(getProportionalScreenHeight(25)),
  //             borderSide: const BorderSide(),
  //           ),
  //           floatingLabelBehavior: FloatingLabelBehavior.always));
  // }

  TextFormField buildProductStatusFormField() {
    return TextFormField(
        controller: productStatusController,
        validator: Validator.valueExists,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: "Product Status",
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(getProportionalScreenHeight(25)),
              borderSide: const BorderSide(),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always));
  }

  Widget buildDateTimeField() {
    return DateTimeField(
      onChanged: (value) => productCreatedDate = value,
      // onDateSelected: (DateTime? value) {
      //   setState(() {
      //     productCreatedDate = value;
      //   });
      // },
      decoration: InputDecoration(
          labelText: "Launching Date",
          fillColor: Colors.grey,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(getProportionalScreenHeight(25)),
            borderSide: BorderSide(),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always),
      // dateFormat: DateFormat.(),
      // selectedDate: selectedDateValue,
      format: DateFormat.yMMMd(),
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
    );
  }

  Widget buildProductTypeDropdownButtonField() {
    return DropdownButtonFormField(
      validator: Validator.valueExists,
      decoration: InputDecoration(
          labelText: "Select Product Type",
          //fillColor: Colors.grey,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(getProportionalScreenHeight(25)),
            borderSide: const BorderSide(),
          ),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never),
      items: productTypes?.map((String productType) {
        return DropdownMenuItem<String>(
          child: Text(productType),
          value: productType,
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          productTypeSelectedValue = value!;
        });
      },
    );
  }

  void _validateAndSend(ProfileEntity profileEntity) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pushNamed(MimiNaWeweSacco.productList);
      return BlocProvider.of<ProductBloc>(context).add(ProductPressed(
          addedBy: profileEntity.username,
          title: productNameController.text,
          body: productDescController.text,
          productTypeName: productTypeSelectedValue,
          dateLaunched: productCreatedDate.toString(),
          status: productStatusController.text,
          img: ""));
    }
  }
}
