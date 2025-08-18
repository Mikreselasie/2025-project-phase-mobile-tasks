import 'dart:io';

import 'package:ecommerce/core/presentation/constants/constants.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_event.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_state.dart';
import 'package:ecommerce/features/product/presentation/widgets/image_picker_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/button.dart';
import '../../../../core/presentation/widgets/input.dart';
import '../../domain/entities/product.dart';

class ProductForm extends StatefulWidget {
  final Product? product;

  const ProductForm({super.key, this.product});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _priceController.text = widget.product!.price.toString();
      _descriptionController.text = widget.product!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ImagePickerContainer(
            onImagePicked: (String imagePath) {
              setState(() {
                _pickedImage = File(imagePath);
              });
            },
          ),
          const SizedBox(height: 10),
          Input(
            label: 'Name',
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              Input(
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                label: 'Price',
              ),
              const Positioned(
                top: 38,
                right: 10,
                child: Icon(Icons.attach_money, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Input(
            label: 'Description',
            controller: _descriptionController,
            isMultiline: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),

          //
          SizedBox(
            width: double.infinity,
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductAddInProgress) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Button(
                  key: const Key('submitProductButton'),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      Size(double.infinity, 50),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.secondary,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  text: widget.product != null ? 'Update' : 'Add',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (mounted) {
                        if (widget.product != null) {
                          _updateProduct(context);
                        } else {
                          _addProduct(context);
                        }
                      }
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _updateProduct(BuildContext context) {
    // Update
    final imageUrl = _pickedImage?.absolute.path ?? widget.product!.imageUrl;

    context.read<ProductBloc>().add(
      ProductUpdated(
        ProductModel(
          id: widget.product!.id,
          name: _nameController.text,
          price: double.parse(_priceController.text),
          description: _descriptionController.text,
          imageUrl: imageUrl,
        ),
      ),
    );
  }

  void _addProduct(BuildContext context) {
    // Add
    final imageUrl =
        _pickedImage?.absolute.path ?? 'https://via.placeholder.com/150';

    context.read<ProductBloc>().add(
      ProductAdded(
        ProductModel(
          name: _nameController.text,
          price: double.parse(_priceController.text),
          description: _descriptionController.text,
          imageUrl: imageUrl,
          id: '',
        ),
      ),
    );
  }
}
