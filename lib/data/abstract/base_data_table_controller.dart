import 'package:e_commerce_admin_pannel/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_admin_pannel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/sizes.dart';

abstract class TBaseController<T> extends GetxController {
  RxBool isLoading = false .obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<T> allItems = <T>[].obs;
  RxList<T> filteredItems = <T>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;
  final searchTextController = TextEditingController();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  /// Abstract method to be implemented by subclasses for fetching items.
  Future<List<T>> fetchItems();

  /// Abstract method to be implemented by subclasses for deleting item.
  Future<void> deleteItem(T item);

  /// Abstract method to be implemented by subclasses for checking if an item contain the search query.
  bool containSearchQuery(T item, String query);

  /// Common method for fetching data.
  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<T> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await fetchItems();
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);
      selectedRows.assignAll(List.generate(
        allItems.length,
        (_) => false,
      ));
    } catch (e) {
      isLoading.value = false;
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Common method for searching base on a query
  void searchQuery(String query) {
    filteredItems.assignAll(allItems.where(
      (item) => containSearchQuery(item, query),
    ));
  }

  /// Common method for sorting items by a property
  void sortByProperty(
      int sortColumnIndex, bool ascending, Function(T) property) {
    this.sortColumnIndex.value = sortColumnIndex;
    sortAscending.value = ascending;
    filteredItems.sort(
      (a, b) {
        if (ascending) {
          return property(a).compareTo(property(b));
        } else {
          return property(b).compareTo(property(a));
        }
      },
    );
  }

  /// Method for adding an item to the lists.
  void addItemToLists(T item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (_) => false));
  }

  /// Method for updating an item in the list
  void updateItemFromList(T item) {
    final itemIndex = allItems.indexWhere(
      (i) => i == item,
    );
    final filteredItemIndex = filteredItems.indexWhere(
      (i) => i == item,
    );

    if (itemIndex != -1) allItems[itemIndex] = item;

    if (filteredItemIndex != -1) filteredItems[filteredItemIndex] = item;

    filteredItems.refresh();
  }

  /// Method for deleting an item in the list
  void removeItemFromLists(T item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (_) => false));
  }

  /// Method for delete confirmation
  void confirmAndDeleteItem(T category) {
    Get.defaultDialog(
        title: 'Delete Item',
        content: const Text('Are you sure you want to delete this item?'),
        confirm: SizedBox(
          width: 60,
          child: ElevatedButton(
              onPressed: () async => await deleteOnConfirm(category),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical: TSizes.buttonHeight / 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          TSizes.buttonRadius * 5))
              ),
              child: Text('Ok')),
        ),
        cancel: SizedBox(
          width: 80,
          child: OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: TSizes.buttonHeight/2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.buttonRadius * 5))
              ),
              child: Text('Cancel')),
        )
    );
  }

  /// Method to be implemented by subclass for handling confirmation before deleting an item
  Future<void> deleteOnConfirm(T item) async {
    try {
      // Remove the Confirmation Dialog
      TFullScreenLoader.stopLoading();

      // Start the loader
      TFullScreenLoader.popUpCircular();

      // Delete Firestore Data
      await deleteItem(item);

      removeItemFromLists(item);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Item Deleted', message: 'Your Item has been Deleted');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
