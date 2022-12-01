import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _descriptionFocus = FocusNode();
  final _formData = <String, Object>{};
  final _formKey = GlobalKey<FormState>();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocus = FocusNode();
  bool _isLoading = false;
  final _nameFocus = FocusNode();
  final _priceFocus = FocusNode();

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
  initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  Future<void> _submitForm(BuildContext context) async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<ProductList>(context, listen: false)
          .saveProduct(_formData);
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Ocorreu um erro'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: () async {
              await _submitForm(context);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                            onSaved: (image) =>
                                _formData['image'] = image ?? '',
                            decoration: const InputDecoration(
                                labelText: 'Url da image'),
                            focusNode: _imageUrlFocus,
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            onFieldSubmitted: (value) {
                              _submitForm(context);
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
                                    errorBuilder:
                                        ((context, error, stackTrace) {
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
