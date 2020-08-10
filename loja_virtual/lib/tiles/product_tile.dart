import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/product_data.dart';
import 'package:lojavirtual/screens/product_screen.dart';

class ProductTile extends StatelessWidget {

  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {

    Widget _gridCol() => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 0.8,
          child: Image.network(
            product.images[0],
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0, bottom: 8.0),
            child: Column(
              children: <Widget>[
                Text(product.title, style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),),
                Text('R\$${product.price.toStringAsFixed(2)}', style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: Theme.of(context).primaryColor,
                ),),
              ],
            ),
          ),
        ),
      ],
    );

    Widget _gridRow() => Row(
      children: <Widget>[
        Flexible(flex: 1,
        child: Image.network(
            product.images[0],
            fit: BoxFit.cover,
            height: 250.0,
          ),
        ),
        Flexible(flex: 1,
        child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(product.title, style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0
                ),),
                Text('R\$${product.price.toStringAsFixed(2)}', style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0,
                  color: Theme.of(context).primaryColor,
                ),),
              ],
            ),
          ),
        ),
      ],
    );

    return InkWell(
      child: Card(
         child: type == 'grid' ?
          _gridCol() : _gridRow(),
      ),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>ProductScreen(product))
        );
      },
    );
  }
}