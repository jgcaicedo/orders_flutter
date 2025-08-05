
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';


class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  DateTime? _fechaAtencion;
  List<Map<String, String>> _examenes = [
    {'nombre': '', 'codigo': ''},
  ];
  bool _loading = false;

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  Future<void> _guardarOrden() async {
    if (!_formKey.currentState!.validate()) return;
    if (_fechaAtencion == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecciona la fecha de atención.')));
      return;
    }
    if (_fechaAtencion!.isAfter(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('La fecha no puede ser futura.')));
      return;
    }
    if (_examenes.any((e) => e['nombre']!.isEmpty || e['codigo']!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Completa todos los exámenes.')));
      return;
    }
    setState(() => _loading = true);
    final provider = Provider.of<OrderProvider>(context, listen: false);
    final ok = await provider.crearOrden(
      nombrePaciente: _nombreController.text,
      fechaAtencion: _fechaAtencion!,
      examenes: _examenes,
    );
    setState(() => _loading = false);
    if (ok) {
      await provider.fetchOrdenes();
      if (mounted) Navigator.pop(context);
    } else {
      if (provider.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.error!)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Orden'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Icon(Icons.note_add, size: 80, color: Colors.grey),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del paciente',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(_fechaAtencion == null
                    ? 'Selecciona la fecha de atención'
                    : 'Fecha: ${_fechaAtencion!.toLocal().toString().split(' ')[0]}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) setState(() => _fechaAtencion = picked);
                },
              ),
              const SizedBox(height: 16),
              const Text('Exámenes', style: TextStyle(fontWeight: FontWeight.bold)),
              ..._examenes.asMap().entries.map((entry) {
                final idx = entry.key;
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Nombre'),
                        initialValue: entry.value['nombre'],
                        onChanged: (v) => _examenes[idx]['nombre'] = v,
                        validator: (v) => v == null || v.isEmpty ? 'Obligatorio' : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Código'),
                        initialValue: entry.value['codigo'],
                        onChanged: (v) => _examenes[idx]['codigo'] = v,
                        validator: (v) => v == null || v.isEmpty ? 'Obligatorio' : null,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: _examenes.length > 1
                          ? () => setState(() => _examenes.removeAt(idx))
                          : null,
                    ),
                  ],
                );
              }),
              TextButton.icon(
                onPressed: () => setState(() => _examenes.add({'nombre': '', 'codigo': ''})),
                icon: const Icon(Icons.add),
                label: const Text('Agregar examen'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _loading ? null : _guardarOrden,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: _loading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}