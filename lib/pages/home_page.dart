import 'package:butche_app/pages/profile_details.dart';
import 'package:butche_app/pages/profile_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../widgets/header_section.dart';
import '../widgets/budget_distribution.dart';
import '../widgets/transaction_list.dart';
import 'login_page.dart';

const String host =
    'https://fintechprojectapiapi20240711020738.azurewebsites.net';
const String incomeEndpoint = '$host/api/Transactions/CreateIncomeTransaction';
const String expenseEndpoint =
    '$host/api/Transactions/CreateExpenseTransaction';

const String getCategoryEndpoint = '$host/api/Categories';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 1;
  List screens = [
    const MyLoginPage(),
    const HomePageBody(),
    const ProfileDetails(),
  ];

  void _showAddTransactionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTransactionDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 81, 45, 168),
        onPressed: _showAddTransactionDialog,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.grey[300],
        indicatorColor: Colors.grey[400],
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _index,
        onDestinationSelected: (index) {
          setState(() {
            _index = index;
          });
        },
        height: 70,
        elevation: 0,
        destinations: const [
          NavigationDestination(
            icon: Icon(Iconsax.chart_3),
            label: 'İstatistik',
          ),
          NavigationDestination(
            icon: Icon(Iconsax.home),
            label: 'Ana Sayfa',
          ),
          NavigationDestination(
              icon: Icon(Iconsax.profile_circle), label: 'Profil'),
        ],
      ),
      body: screens[_index],
    );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({
    super.key,
  });

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  List<Map<String, String>> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');

    final response = await http.get(
      Uri.parse(getCategoryEndpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> categories = jsonDecode(response.body);
      setState(() {
        _categories = categories
            .map((category) => {
                  'id': category['id'].toString(),
                  'name': category['name'].toString(),
                })
            .toList();
      });
    } else {
      print('Error fetching categories: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 243, 243, 243),
        child: Column(
          children: [
            const HeaderSection(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        'Bütçe Dağılımı',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lexend',
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: BudgetDistributionSection(),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        'Geçmiş İşlemler',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lexend',
                        ),
                      ),
                    ),
                    TransactionList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddTransactionDialog extends StatefulWidget {
  const AddTransactionDialog({super.key});

  @override
  _AddTransactionDialogState createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  String _transactionType = 'Gelir';
  String? _categoryId;
  DateTime _selectedDate = DateTime.now();
  final storage = const FlutterSecureStorage();
  List<Map<String, String>> _categories = [];

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    String? token = await storage.read(key: 'accessToken');

    final response = await http.get(
      Uri.parse(getCategoryEndpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> categories = jsonDecode(response.body);
      setState(() {
        _categories = categories
            .map((category) => {
                  'id': category['id'].toString(),
                  'name': category['name'].toString(),
                })
            .toList();
        if (_categories.isNotEmpty) {
          _categoryId = _categories[0]['id'];
        }
      });
    } else {
      print('Error fetching categories: ${response.statusCode}');
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final transactionData = {
        'categoryId': _categoryId,
        'description': _descriptionController.text,
        'amount': double.tryParse(_amountController.text) ?? 0.0,
        'transactionDate': _selectedDate.toIso8601String(),
      };
      String? token = await storage.read(key: 'accessToken');
      String url =
          _transactionType == 'Gelir' ? incomeEndpoint : expenseEndpoint;

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token',
        },
        body: jsonEncode(transactionData),
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
      } else {
        print('Transaction saving error: ${response.statusCode}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Hata'),
            content: const Text('İşlem kaydedilemedi. Lütfen tekrar deneyin.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Tamam'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[200],
      title: const Text(
        'Gelir/Gider Ekle',
        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Lexend'),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _transactionType,
                decoration: const InputDecoration(labelText: 'Türü'),
                items: ['Gelir', 'Gider'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _transactionType = newValue!;
                  });
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Tutar'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir tutar girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Açıklama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir açıklama girin';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _categoryId,
                decoration: const InputDecoration(labelText: 'Kategori'),
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category['id'],
                    child: Text(category['name']!),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _categoryId = newValue;
                  });
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Tarih: ${_selectedDate.toLocal()}".split(' ')[0],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != _selectedDate) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                    child: const Text(
                      'Tarih Seç',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Lexend'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'İptal',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Lexend',
                color: Colors.red),
          ),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text(
            'Kaydet',
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Lexend'),
          ),
        ),
      ],
    );
  }
}
