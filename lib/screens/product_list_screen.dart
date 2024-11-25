import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/producto.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Producto>> _productos;

  @override
  void initState() {
    super.initState();
    _refreshProductos();
  }

  void _refreshProductos() {
    setState(() {
      _productos = DatabaseHelper.instance.getProductos();
    });
  }

  // Método para mostrar el formulario de agregar productos
  void _showAddProductDialog() {
    final _nombreController = TextEditingController();
    final _cantidadController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Producto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre del producto'),
              ),
              TextField(
                controller: _cantidadController,
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final nombre = _nombreController.text;
                final cantidad = int.tryParse(_cantidadController.text);

                if (nombre.isNotEmpty && cantidad != null) {
                  await DatabaseHelper.instance.addProducto(
                    Producto(nombre: nombre, cantidad: cantidad),
                  );
                  _refreshProductos();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  // Método para mostrar el formulario de editar la cantidad
  void _showUpdateProductDialog(Producto producto) {
    final _cantidadController = TextEditingController(text: producto.cantidad.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Actualizar Producto'),
          content: TextField(
            controller: _cantidadController,
            decoration: const InputDecoration(labelText: 'Nueva cantidad'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final cantidad = int.tryParse(_cantidadController.text);

                if (cantidad != null) {
                  producto.cantidad = cantidad;
                  await DatabaseHelper.instance.updateProducto(producto);
                  _refreshProductos();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Actualizar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario'),
      ),
      body: FutureBuilder<List<Producto>>(
        future: _productos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final productos = snapshot.data ?? [];
            if (productos.isEmpty) {
              return const Center(child: Text('No hay productos en el inventario.'));
            }

            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
                return ListTile(
                  title: Text(producto.nombre),
                  subtitle: Text('Cantidad: ${producto.cantidad}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showUpdateProductDialog(producto);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await DatabaseHelper.instance.deleteProducto(producto.id!);
                          _refreshProductos();
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProductDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
