import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_in_flutter/feature/product/data/models/product_model.dart';
import 'package:layout_in_flutter/feature/product/presentation/bloc/bloc/product_bloc.dart';
import 'package:layout_in_flutter/feature/product/presentation/bloc/bloc/product_event.dart';
import 'package:layout_in_flutter/main.dart';

class DescriptionPage extends StatefulWidget {
  final ProductModel product;

  const DescriptionPage({super.key, required this.product});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  late TextEditingController _productNameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  int? _selectedSize;
  String? _selectedAction;

  @override
  void initState() {
    super.initState();
    _productNameController =
        TextEditingController(text: widget.product.productName);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
    _descriptionController =
        TextEditingController(text: widget.product.description);
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 254, 254, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(15.0)),
                  ),
                  margin: EdgeInsets.zero,
                  color: const Color.fromRGBO(254, 254, 254, 1),
                  elevation: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15.0)),
                          color: Colors.black,
                        ),
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Men shoe',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 187, 184, 184),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Text(
                                      '4.0',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 187, 184, 184),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    controller: _productNameController,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 0),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    controller: _priceController,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 0),
                                      prefixText: '\$',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                    radius: 20,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Color.fromRGBO(63, 81, 243, 1), size: 24),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      iconSize: 16,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            buildSizeSection(),
            const SizedBox(height: 20),
            buildDescriptionText(),
            const SizedBox(height: 30),
            buildActionButtons(product.id), // Pass product ID to action buttons
          ],
        ),
      ),
    );
  }

  Widget buildSizeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Size:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(50, (index) {
                final size = 39 + index;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.03),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: ChoiceChip(
                      label: Text(
                        size.toString(),
                        style: TextStyle(
                          color: _selectedSize == size
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selected: _selectedSize == size,
                      selectedColor: const Color.fromRGBO(63, 81, 243, 1),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      side: BorderSide.none,
                      onSelected: (selected) {
                        setState(() {
                          _selectedSize = selected ? size : null;
                        });
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDescriptionText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: _descriptionController,
        maxLines: null,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          height: 1.5,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildActionButtons(String productId) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: _selectedAction == 'delete'
                    ? const Color.fromRGBO(63, 81, 243, 1)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: _selectedAction == 'delete'
                      ? Colors.transparent
                      : Colors.red,
                  width: 1,
                ),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _selectedAction = 'delete';
                  });
                  BlocProvider.of<ProductBloc>(context)
                      .add(DeleteProductEvent(productId));
                  Navigator.pop(
                      context); // Optionally navigate back after deletion
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color:
                        _selectedAction == 'delete' ? Colors.white : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: _selectedAction == 'update'
                    ? const Color.fromRGBO(63, 81, 243, 1)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: _selectedAction == 'update'
                      ? Colors.transparent
                      : Colors.red,
                  width: 1,
                ),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _selectedAction = 'update';
                  });
                  BlocProvider.of<ProductBloc>(context).add(
                    UpdateProductEvent(productId,
                        id: widget.product.id,
                        productName: _productNameController.text,
                        price:double.parse(_priceController.text),
                        description: _descriptionController.text,
                        imageUrl: widget.product.imageUrl),
                  );
                  BlocProvider.of<ProductBloc>(context).add(LoadAllProductEvent());
                  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => HomePage()),
);

                  // Trigger update event here if needed
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'Update',
                  style: TextStyle(
                    color:
                        _selectedAction == 'update' ? Colors.white : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
