import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  void updateImage() {
    setState(() {});
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<ProductList>(context, listen: false).saveProduct(_formData);

    Navigator.of(context).pop();
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['image'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  dispose() {
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _nameFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['name']?.toString(),
                onSaved: (name) => _formData['name'] = name ?? '',
                decoration: const InputDecoration(labelText: 'nome'),
                textInputAction: TextInputAction.next,
                focusNode: _nameFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                validator: (name) {
                  final nameAux = name ?? '';
                  if (nameAux.trim().isEmpty) {
                    return 'campo nome é obrigatório.';
                  }
                  if (nameAux.trim().length < 3) {
                    return 'campo nome precisa no mínimo três letras.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['price']?.toString(),
                onSaved: (price) =>
                    _formData['price'] = double.parse(price ?? '0'),
                decoration: const InputDecoration(labelText: 'preco'),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                validator: (price) {
                  final priceAux = price ?? '-1';
                  final priceDouble = double.tryParse(priceAux) ?? -1;
                  if (priceDouble <= 0) {
                    return 'informe um preço válido.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['description']?.toString(),
                decoration: const InputDecoration(labelText: 'descricao'),
                onSaved: (description) =>
                    _formData['description'] = description ?? '',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocus,
                maxLines: 8,
                maxLength: 300,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_imageUrlFocus);
                },
                validator: (name) {
                  final nameAux = name ?? '';
                  if (nameAux.trim().isEmpty) {
                    return 'campo descrição é obrigatório.';
                  }
                  if (nameAux.trim().length < 10) {
                    return 'campo descrição precisa no mínimo três letras.';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      onSaved: (image) => _formData['image'] = image ?? '',
                      decoration:
                          const InputDecoration(labelText: 'Url da image'),
                      focusNode: _imageUrlFocus,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      onFieldSubmitted: (value) {
                        _submitForm();
                      },
                      validator: (image) {
                        final imageUrl = image ?? '';
                        if (!isValidImageUrl(imageUrl)) {
                          return 'informe uma URL válida.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Informe a URL')
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(
                              _imageUrlController.text,
                              errorBuilder: ((context, error, stackTrace) {
                                return Container();
                              }),
                            ),
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}