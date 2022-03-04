import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimi_na_wewe_sacco/domain/model/product_entity.dart';

import '../widgets.dart';

class ProductContainer extends StatefulWidget {
  const ProductContainer({Key? key, this.productEntity, this.index})
      : super(key: key);
  final ProductEntity? productEntity;
  final int? index;
  @override
  _ProductContainerState createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionalScreenHeight(150),
      margin: EdgeInsets.only(bottom: getProportionalScreenHeight(15)),
      padding: EdgeInsets.only(
          left: getProportionalScreenHeight(20),
          right: getProportionalScreenHeight(22)),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(getProportionalScreenHeight(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(8.0, 8.0),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: getProportionalScreenHeight(60),
                width: getProportionalScreenWidth(60),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://res.cloudinary.com/pesabank-limited/image/upload/v1644301001/debit-card_yjong0.png"),
                  ),
                ),
              ),
              SizedBox(
                width: getProportionalScreenWidth(13),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Product Name: ${widget.productEntity!.title!}",
                    style: GoogleFonts.inter(
                        fontSize: getProportionalScreenHeight(18),
                        fontWeight: FontWeight.w700,
                        color: kBlackColor),
                  ),
                  SizedBox(height: getProportionalScreenHeight(5)),
                  Text(
                    "Product Description: ${widget.productEntity!.body}",
                    style: GoogleFonts.inter(
                        fontSize: getProportionalScreenHeight(15),
                        fontWeight: FontWeight.w400,
                        color: kPrimaryColor),
                  ),
                  SizedBox(height: getProportionalScreenHeight(5)),
                  Text(
                    "Product Type Name: ${widget.productEntity!.productTypeName}",
                    style: GoogleFonts.inter(
                        fontSize: getProportionalScreenHeight(15),
                        fontWeight: FontWeight.w400,
                        color: kPrimaryColor),
                  ),
                  SizedBox(height: getProportionalScreenHeight(5)),
                  Text(
                    "Product Status: ${widget.productEntity!.status!}",
                    style: GoogleFonts.inter(
                        fontSize: getProportionalScreenHeight(15),
                        fontWeight: FontWeight.w400,
                        color: kPrimaryColor),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
