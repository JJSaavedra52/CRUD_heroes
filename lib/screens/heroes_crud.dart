import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/auth_service.dart';

final _authService = AuthService();
String get baseUrl => '${_authService.apiBaseUrl}/api';

Future<Map<String, String>> _authHeaders() async {
  final token = await _authService.readToken();
  final headers = <String, String>{'Content-Type': 'application/json'};
  if (token.isNotEmpty) {
    headers['Authorization'] = 'Bearer $token';
    headers['x-token'] = token; // some backends expect x-token
  }
  return headers;
}

class HeroModel {
  final String id;
  final String nombre;
  final String bio;
  final String img;
  final String aparicion; // ISO date as string
  final String casa;

  HeroModel({
    required this.id,
    required this.nombre,
    required this.bio,
    required this.img,
    required this.aparicion,
    required this.casa,
  });

  factory HeroModel.fromJson(Map<String, dynamic> json) {
    // tolerate alternative keys if present
    String s(dynamic v) => v == null ? '' : v.toString();
    return HeroModel(
      id: s(json['id'] ?? json['_id']),
      nombre: s(json['nombre'] ?? json['name']),
      bio: s(json['bio'] ?? json['descripcion'] ?? json['description']),
      img: s(json['img'] ?? json['image']),
      aparicion: s(json['aparicion'] ?? json['appearance']),
      casa: s(json['casa'] ?? json['house']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'bio': bio,
    'img': img,
    'aparicion': aparicion,
    'casa': casa,
  };

  HeroModel copyWith({
    String? nombre,
    String? bio,
    String? img,
    String? aparicion,
    String? casa,
  }) {
    return HeroModel(
      id: id,
      nombre: nombre ?? this.nombre,
      bio: bio ?? this.bio,
      img: img ?? this.img,
      aparicion: aparicion ?? this.aparicion,
      casa: casa ?? this.casa,
    );
  }
}

class HeroesCrudScreen extends StatefulWidget {
  const HeroesCrudScreen({Key? key}) : super(key: key);

  @override
  _HeroesCrudScreenState createState() => _HeroesCrudScreenState();
}

class _HeroesCrudScreenState extends State<HeroesCrudScreen> {
  List<HeroModel> _heroes = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchHeroes();
  }

  Future<void> _fetchHeroes() async {
    setState(() => _loading = true);
    try {
      final headers = await _authHeaders();
      final res = await http.get(
        Uri.parse('$baseUrl/heroes'),
        headers: headers,
      );
      if (res.statusCode == 200) {
        final body = json.decode(res.body);
        final List<dynamic> list = body is List
            ? body
            : (body['data'] ?? body['heroes'] ?? []);
        setState(() {
          _heroes = list.map((e) => HeroModel.fromJson(e)).toList();
        });
      } else {
        _showMessage('Failed to load heroes (${res.statusCode})');
      }
    } catch (e) {
      _showMessage('Error fetching heroes: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _createHero(Map<String, dynamic> data) async {
    try {
      final headers = await _authHeaders();
      final res = await http.post(
        Uri.parse('$baseUrl/heroes'),
        headers: headers,
        body: json.encode(data),
      );
      if (res.statusCode == 201 || res.statusCode == 200) {
        final created = _decodeHero(res.body);
        if (created != null) {
          setState(() => _heroes.insert(0, created));
        }
        _showMessage('Hero created');
      } else {
        _showMessage('Create failed (${res.statusCode})');
      }
    } catch (e) {
      _showMessage('Error creating hero: $e');
    }
  }

  Future<void> _updateHero(HeroModel hero, Map<String, dynamic> data) async {
    try {
      final headers = await _authHeaders();
      final res = await http.put(
        Uri.parse('$baseUrl/heroes/${hero.id}'),
        headers: headers,
        body: json.encode(data),
      );
      if (res.statusCode == 200) {
        final updated =
            _decodeHero(res.body) ??
            hero.copyWith(
              nombre: data['nombre'],
              bio: data['bio'],
              img: data['img'],
              aparicion: data['aparicion'],
              casa: data['casa'],
            );
        setState(() {
          final idx = _heroes.indexWhere((h) => h.id == hero.id);
          if (idx != -1) _heroes[idx] = updated;
        });
        _showMessage('Hero updated');
      } else {
        _showMessage('Update failed (${res.statusCode})');
      }
    } catch (e) {
      _showMessage('Error updating hero: $e');
    }
  }

  Future<void> _deleteHero(String id) async {
    try {
      final headers = await _authHeaders();
      final res = await http.delete(
        Uri.parse('$baseUrl/heroes/$id'),
        headers: headers,
      );
      if (res.statusCode == 200 || res.statusCode == 204) {
        setState(() => _heroes.removeWhere((h) => h.id == id));
        _showMessage('Hero deleted');
      } else {
        _showMessage('Delete failed (${res.statusCode})');
      }
    } catch (e) {
      _showMessage('Error deleting hero: $e');
    }
  }

  HeroModel? _decodeHero(String body) {
    try {
      final decoded = json.decode(body);
      if (decoded is Map<String, dynamic>) {
        // try common wrappers
        final cand =
            decoded['data'] ?? decoded['hero'] ?? decoded['result'] ?? decoded;
        if (cand is Map<String, dynamic>) {
          return HeroModel.fromJson(cand);
        }
        if (cand is List && cand.isNotEmpty && cand.first is Map) {
          return HeroModel.fromJson(cand.first as Map<String, dynamic>);
        }
      } else if (decoded is List && decoded.isNotEmpty) {
        return HeroModel.fromJson(decoded.first as Map<String, dynamic>);
      }
    } catch (_) {}
    return null;
  }

  Future<void> _showCreateDialog() async {
    final data = await _showHeroFormDialog(title: 'Create Hero');
    if (data != null) {
      await _createHero(data);
    }
  }

  Future<void> _showEditDialog(HeroModel hero) async {
    final data = await _showHeroFormDialog(title: 'Edit Hero', initial: hero);
    if (data != null) {
      await _updateHero(hero, data);
    }
  }

  Future<Map<String, dynamic>?> _showHeroFormDialog({
    required String title,
    HeroModel? initial,
  }) {
    final nombreCtrl = TextEditingController(text: initial?.nombre ?? '');
    final bioCtrl = TextEditingController(text: initial?.bio ?? '');
    final imgCtrl = TextEditingController(text: initial?.img ?? '');
    final aparicionCtrl = TextEditingController(text: initial?.aparicion ?? '');
    String casa = initial?.casa.isNotEmpty == true ? initial!.casa : 'DC';
    String? error;

    Future<void> pickDate(void Function(void Function()) setStateDialog) async {
      final now = DateTime.now();
      final first = DateTime(1900);
      final initialDate = DateTime.tryParse(aparicionCtrl.text) ?? now;
      final picked = await showDatePicker(
        context: context,
        initialDate: initialDate.isAfter(now) ? now : initialDate,
        firstDate: first,
        lastDate: DateTime(now.year + 5),
      );
      if (picked != null) {
        final iso = picked.toIso8601String().split('T').first; // YYYY-MM-DD
        setStateDialog(() => aparicionCtrl.text = iso);
      }
    }

    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                TextField(
                  controller: nombreCtrl,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  textInputAction: TextInputAction.next,
                ),
                TextField(
                  controller: bioCtrl,
                  decoration: const InputDecoration(labelText: 'Bio'),
                  maxLines: 3,
                ),
                TextField(
                  controller: imgCtrl,
                  decoration: const InputDecoration(labelText: 'Imagen (URL)'),
                  textInputAction: TextInputAction.next,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: aparicionCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Aparición (YYYY-MM-DD)',
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Pick date',
                      onPressed: () => pickDate(setStateDialog),
                      icon: const Icon(Icons.date_range),
                    ),
                  ],
                ),
                DropdownButtonFormField<String>(
                  value: casa,
                  items: const [
                    DropdownMenuItem(value: 'DC', child: Text('DC')),
                    DropdownMenuItem(value: 'Marvel', child: Text('Marvel')),
                  ],
                  onChanged: (v) => setStateDialog(() => casa = v ?? 'DC'),
                  decoration: const InputDecoration(labelText: 'Casa'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final nombre = nombreCtrl.text.trim();
                if (nombre.isEmpty) {
                  setStateDialog(() => error = 'El nombre es requerido');
                  return;
                }
                final data = {
                  'nombre': nombre,
                  'bio': bioCtrl.text.trim(),
                  'img': imgCtrl.text.trim(),
                  'aparicion': aparicionCtrl.text.trim(),
                  'casa': casa,
                };
                Navigator.of(context).pop(data);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(HeroModel hero) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Hero'),
        content: Text('Delete "${hero.nombre}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok == true) await _deleteHero(hero.id);
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heroes CRUD'),
        actions: [
          IconButton(onPressed: _fetchHeroes, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchHeroes,
              child: _heroes.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: 120),
                        Center(child: Text('No heroes. Tap + to add one.')),
                      ],
                    )
                  : ListView.builder(
                      itemCount: _heroes.length,
                      itemBuilder: (context, i) {
                        final hero = _heroes[i];
                        return ListTile(
                          leading: _HeroAvatar(
                            imgUrl: hero.img,
                            fallbackText: hero.nombre,
                          ),
                          title: Text(hero.nombre),
                          subtitle: Text(
                            '${hero.casa} • ${hero.aparicion.isNotEmpty ? hero.aparicion : 'Sin fecha'}',
                          ),
                          onTap: () => _showEditDialog(hero),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: 'Edit',
                                icon: const Icon(Icons.edit),
                                onPressed: () => _showEditDialog(hero),
                              ),
                              IconButton(
                                tooltip: 'Delete',
                                icon: const Icon(Icons.delete),
                                onPressed: () => _confirmDelete(hero),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateDialog,
        child: const Icon(Icons.add),
        tooltip: 'Create Hero',
      ),
    );
  }
}

class _HeroAvatar extends StatelessWidget {
  final String imgUrl;
  final String fallbackText;
  const _HeroAvatar({required this.imgUrl, required this.fallbackText});

  @override
  Widget build(BuildContext context) {
    final letter = fallbackText.isNotEmpty
        ? fallbackText[0].toUpperCase()
        : '?';
    if (imgUrl.isNotEmpty) {
      return CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
        onBackgroundImageError: (_, __) {},
        child: Container(), // keeps size consistent
      );
    }
    return CircleAvatar(child: Text(letter));
  }
}
