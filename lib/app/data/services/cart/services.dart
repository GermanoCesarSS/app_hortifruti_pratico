import 'package:app_hortifruti_pratico/app/data/models/cart_product.dart';
import 'package:app_hortifruti_pratico/app/data/models/store.dart';
import 'package:get/get.dart';

class CartService extends GetxService {
  List<CartProductModel> products = RxList<CartProductModel>.empty();
  final store = Rxn<StoreModel>();
  final observation = RxString('');

  num get total =>
      products.fold(0, (total, cartProduct) => total + cartProduct.total);

  bool isANexStore(StoreModel newStore) {
    if (store.value == null) {
      return true;
    }
    return store.value!.id != newStore.id;
  }

  void clearCart() {
    products.clear();
  }

  void newCart(StoreModel newStore) {
    store.value = newStore;
  }

  void addProductToCart(CartProductModel cartProduct) {
    products.add(cartProduct);
  }

  void removeProductFromCart(CartProductModel cartProduct) {
    products.remove(cartProduct);
  }
}
