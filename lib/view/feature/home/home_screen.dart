import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_na_wewe_sacco/config/routes.dart';
import 'package:mimi_na_wewe_sacco/data/repository/user/user_api_handler.dart';
import 'package:mimi_na_wewe_sacco/domain/model/product_entity.dart';
import 'package:mimi_na_wewe_sacco/view/feature/authentication/authentication.dart';
import 'package:mimi_na_wewe_sacco/view/feature/product/product.dart';
import 'package:mimi_na_wewe_sacco/view/widget/data_driven/home_card.dart';

import '../../../domain/model/profile_entity.dart';
import '../../widget/data_driven/speed_dial.dart';
import '../../widget/widgets.dart';
import '../profile/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int current = 0;
  int _currentCauroselSlider = 0;
  String? username;
  var isDialOpen = ValueNotifier<bool>(false);
  UserApiHandler profileApiHandler = UserApiHandler();
  List<Widget> menuWidgets = [];

  final PageController _pageController = PageController(initialPage: 0);
  late ProductBloc productBloc;
  late ProfileBloc profileBloc;
  List<ProductEntity?>? products;
  ProfileEntity? profileEntity;
  late Card card;

  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc.add(ShowProductPressed());
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(ShowProfilePressed());
  }

  //@override
  void dispose() {
    // implement dispose
    _pageController.dispose();
    super.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentCauroselSlider = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: getProportionalScreenWidth(8)),
            child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
              if (state is ProfileLoaded) {
                var timeNow = DateTime.now().hour;
                profileEntity = state.profileEntity!;
                if (timeNow < 12) {
                  return Text(
                    'Good Morning, ${state.profileEntity!.firstName}',
                    style: headingtextStyle,
                  );
                } else if ((timeNow >= 12) && (timeNow < 16)) {
                  return Text(
                    'Good Afternoon, ${state.profileEntity!.firstName}',
                    style: headingtextStyle,
                  );
                } else if ((timeNow >= 16) && (timeNow < 20)) {
                  return Text(
                    'Good Evening, ${state.profileEntity!.firstName}',
                    style: headingtextStyle,
                  );
                } else {
                  return Text(
                    'Hi, ${state.profileEntity!.firstName}',
                    style: headingtextStyle,
                  );
                }
              }
              return const Text('Hi, Welcome to Mimi na Wewe Sacco');
            }),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () {
                authenticationBloc.add(LoggedOut());
                Navigator.of(context).pushNamedAndRemoveUntil(
                  MimiNaWeweSacco.signinwithemail,
                  (Route<dynamic> route) => false,
                );
              },
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: const SpeedDialWidget(),
        body: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                //physics: ClampingScrollPhysics(),
                children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: getProportionalScreenHeight(8)),
                  height: getProportionalScreenHeight(230),
                  child: BlocListener<ProductBloc, ProductState>(
                      listener: (context, state) {
                    if (state is ProductErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                        ),
                      );
                    }
                  }, child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductProcessingState) {
                        //return buildLoading();
                      } else if (state is ProductLoaded) {
                        products = state.products!;
                        //return cardList(userCards);
                      } else if (state is ProductErrorState) {
                        //return buildErrorUi(state.error);
                      }
                      return Container();
                    },
                  )))
            ])));
  }

  transactionTypesGridList() {
    final ScrollController controller = ScrollController();
    return GridView.builder(
      controller: controller,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 0,
          childAspectRatio: 1.1),
      itemCount: menu.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              current = index;
              menuWidgets = [
                //   SendMoneyTab(
                //       card: userCards,
                //       profileEntity: profileEntity,
                //       bankAccount: bankAccounts),
                //   LoadCashTab(
                //     card: userCards,
                //     profileEntity: profileEntity,
                //     bankAccount: bankAccounts),
                // BuyAirtimeTabs(
                //   card: userCards,
                //   profileEntity: profileEntity,
                //   bankAccount: bankAccounts,
                // ),
                // PayGoodsServicesTabs(
                //   card: userCards,
                //   profileEntity: profileEntity,
                //   bankAccount: bankAccounts,
                // ),
                //   profileEntity!.pbUserIdentificationCountryOfIssue == 'Kenya'
                //       ? Text("Use Send Money to phone")
                //       : ExpressPayTabs(
                //           card: userCards,
                //           profileEntity: profileEntity,
                //           bankAccount: bankAccounts,
                //         ),
                //   BalanceEnquiryTabs(card: userCards, bank: bankAccounts)
              ];
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => menuWidgets[index]));
            });
          },
          child: HomeCard(
            name: menu[index].name,
            selectedIcon: menu[index].selectedIcon,
            unselectedIcon: menu[index].unselectedIcon,
            isSelected: current == index,
          ),
        );
      },
    );
  }
}
