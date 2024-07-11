import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/header_section.dart';
import '../widgets/budget_distribution.dart';
import '../widgets/transaction_list.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index=1;
  List screens=[
    MyLoginPage(),
    HomePageBody(),
    MyLoginPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(onPressed: () {  },child: Icon(Icons.add,color: Colors.black,),),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index){
        setState(() {
_index=index;
        });
      },
        height: 80,
        elevation: 0,
        destinations: const [
          NavigationDestination(
            icon: Icon(Iconsax.chart_3),
            label: 'Statistics',
          ),
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Ana Sayfa'),
          NavigationDestination(
              icon: Icon(Iconsax.profile_circle), label: 'Profil'),
        ],
      ),
      body: screens[_index],
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          HeaderSection(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bütçe Dağılımı',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: BudgetDistributionSection(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Geçmiş İşlemler',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
    );
  }
}
