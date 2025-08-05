import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_event.dart';
import 'package:ecommerce/features/product/presentation/constants/constants.dart';
import 'package:ecommerce/features/product/presentation/widgets/image_picker_container.dart';
import 'package:ecommerce/features/product/presentation/widgets/input_inserted.dart';
import 'package:ecommerce/features/product/presentation/widgets/input_type_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdatePage extends StatefulWidget {
  const AddUpdatePage({super.key});

  @override
  State<AddUpdatePage> createState() => _AddUpdatePageState();
}

class _AddUpdatePageState extends State<AddUpdatePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _imageURL;
  String? _action; // 'add' or 'update'
  ProductModel? _product;

  bool _initialized =
      false; // To prevent reinitialization in didChangeDependencies

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _action = args['action'] as String?;
      _product = args['product'] as ProductModel?;

      if (_action == 'update' && _product != null) {
        _nameController.text = _product!.name;
        _priceController.text = _product!.price.toString();
        _descriptionController.text = _product!.description;
        _imageURL = _product!.imageUrl;
      }

      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = _action == 'update';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.secondary,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "${_action?.toUpperCase()} Product",
                          style: AppTextStyles.addProductText,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                ImagePickerContainer(
                  onImagePicked: (imageUrl) {
                    setState(() {
                      _imageURL = imageUrl;
                    });
                  },
                ),

                InputTypeName(name: "name"),
                InputInserted(controller: _nameController),
                InputTypeName(name: "price"),
                InputInserted(controller: _priceController),
                InputTypeName(name: "description"),
                InputInserted(controller: _descriptionController, height: 120),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      if (_imageURL == null ||
                          _nameController.text.isEmpty ||
                          _priceController.text.isEmpty)
                        return;

                      if (_action == "add") {
                        final newProduct = ProductModel(
                          id: DateTime.now().toString(),
                          name: _nameController.text,
                          price: double.parse(_priceController.text),
                          description: _descriptionController.text,
                          imageUrl: _imageURL!,
                        );
                        context.read<ProductBloc>().add(
                          CreateProductEvent(newProduct.toJson()),
                        );
                      } else if (isUpdate && _product != null) {
                        final updatedProduct = _product!.copyWith(
                          name: _nameController.text,
                          price: double.parse(_priceController.text),
                          description: _descriptionController.text,
                          imageUrl: _imageURL!,
                        );
                        context.read<ProductBloc>().add(
                          UpdateProductEvent(updatedProduct: updatedProduct),
                        );
                      }

                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      _action?.toUpperCase() ?? '',
                      style: AppTextStyles.updateButton,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                if (isUpdate && _product != null)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<ProductBloc>().add(
                          DeleteProductEvent(_product!.id),
                        );
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: const BorderSide(color: Colors.red, width: 1),
                      ),
                      child: const Text(
                        "DELETE",
                        style: AppTextStyles.deleteButton,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
