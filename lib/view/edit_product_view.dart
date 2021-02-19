//Form input is good practice to use local state and not provider!
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class EditProductView extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<EditProductView> {
  //built in flutter and store that focusNode. (
  // No need to put the FocusNode on description because it works as default
  //priceFocusNode shows an example on how it can be done manually.
  final _priceFocusNode = FocusNode();

  //This one is needed for the listener
  final _imageUrlFocusNode = FocusNode();

  // neeeded for preview
  final _imageUrlController = TextEditingController();

  //golbal key
  final _form = GlobalKey<FormState>();

  var _editedProduct = Product(id: null, title: '', price: 0, description: '', imageUrl: '');
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      // mandatory to check for null because there are 2 Navigation to this page add/edit (one with argument and the other one without).
      if (productId != null) {
        _editedProduct = Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,~
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    _priceFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      var value = _imageUrlController.text;
      if (value.isEmpty ||
          !value.startsWith('http') ||
          !value.startsWith('https') ||
          !value.endsWith('.jpeg') ||
          !value.endsWith('.png') ||
          !value.endsWith('.jpg')) {
        return;
      }
      setState(() {});
    }
  }

  // submit my form with the help of the Form Widget from build.
  // we need to use a Global key.
  void _saveForm() {
    //triggers the validators
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    //will trigger a method on every textFormField and let us do what ever we want with the data.
    _form.currentState.save();
    final productsProvider = Provider.of<Products>(context, listen: false);
    if (_editedProduct.id != null) {
      productsProvider.updateProduct(_editedProduct.id, _editedProduct);
    } else {
      productsProvider.addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
    // print(_editedProduct.title);
    // print(_editedProduct.price);
    // print(_editedProduct.description);
    // print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: _saveForm)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          //this is the global key.
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  //we tell Flutter that when the first is submitted, move to the next one
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                //currently input value
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Input must have a value';
                  }
                  if (value.length > 20) {
                    return 'Title length is too big. Max characters is 20';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _editedProduct = new Product(
                    id: _editedProduct.id,
                    title: value,
                    price: _editedProduct.price,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    isFavorite: _editedProduct.isFavorite,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                //By default it works without focusNode
                focusNode: _priceFocusNode,
                //currently input value
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Input must have a value';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Invalid price. Price must be a number';
                  }
                  if (value.length > 10) {
                    return 'Price is unrealistic. Please add a correct price';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number bigger than 0';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _editedProduct = new Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    price: double.parse(value),
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    isFavorite: _editedProduct.isFavorite,
                  );
                },
              ),
              TextFormField(
                  initialValue: _initValues['description'],
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Description cannot be empty';
                    }
                    if (value.length < 10) {
                      return 'Description must be at least 10 characters';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _editedProduct = new Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        price: _editedProduct.price,
                        description: value,
                        imageUrl: _editedProduct.imageUrl,
                        isFavorite: _editedProduct.isFavorite);
                  }),
              //Image with preview ()
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 15,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    //here we want to preview
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter an URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      //eather use the controller with initial value or this initialValue.
                      //initialValue: _initValues['imageUrl'],
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.start,
                      //this is updated when we type in the image url
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      //anonimusFunction
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'URL cannot be empty';
                        }
                        if (!value.startsWith('http') || !value.startsWith('https')) {
                          return 'Please enter a valid URL.';
                        }
                        if (!value.endsWith('.jpeg') && !value.endsWith('.png') && !value.endsWith('.jpg')) {
                          return 'Please enter a valid image URL.';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _editedProduct = new Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          imageUrl: value,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
