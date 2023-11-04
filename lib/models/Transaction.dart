import 'Product.dart';
import 'Seller.dart';
import 'Buyer.dart';

class Transaction {
  final String id;
  final Product product;
  final Seller seller;
  final Buyer buyer;
  final DateTime timestamp;

  Transaction(this.id, this.product, this.seller, this.buyer, this.timestamp);
}