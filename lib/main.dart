import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ortalama',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();

  List<Ders> tumDersler = [];

  int kredi = 1;
  double harfNotu = 4;
  double ortalama = 0;
  String dersAdi = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          tumDersler.add(Ders(dersAdi, kredi, harfNotu));
          ortalamaHesapla();
        },
      ),
      appBar: AppBar(
        title: const Text("Ortalama Hesapla"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //Form Field
          Container(
            color: Colors.yellow.shade200,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Dersin Adı",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      textAlign: TextAlign.center,
                      onChanged: (girilenDersAdi) {
                        dersAdi = girilenDersAdi;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton(
                          style: const TextStyle(
                              fontSize: 32, color: Colors.black),
                          items: krediItems(),
                          value: kredi,
                          onChanged: (secilenKredi) {
                            debugPrint(secilenKredi.toString());
                            setState(() {
                              kredi = secilenKredi as int;
                            });
                          },
                        ),
                        DropdownButton(
                          style: const TextStyle(
                              fontSize: 32, color: Colors.black),
                          items: harfNotuItems(),
                          value: harfNotu,
                          onChanged: (secilenHarfNotu) {
                            debugPrint(secilenHarfNotu.toString());
                            setState(() {
                              harfNotu = secilenHarfNotu as double;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    color: Colors.red,
                    child: Text(
                      "Ortalama : $ortalama",
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
          //Derslerin Listesi
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(tumDersler[index].dersAdi),
                  ),
                );
              },
              itemCount: tumDersler.length,
            ),
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> krediItems() {
    List<DropdownMenuItem<int>> krediler = [];

    for (int i = 1; i <= 4; i++) {
      krediler.add(DropdownMenuItem(
        value: i,
        child: Text("$i Kredi"),
      ));
    }

    return krediler;
  }

  List<DropdownMenuItem<double>> harfNotuItems() {
    List<DropdownMenuItem<double>> harfNotlari = [];

    harfNotlari.add(const DropdownMenuItem(
      value: 4,
      child: Text("AA"),
    ));
    harfNotlari.add(const DropdownMenuItem(
      value: 3.5,
      child: Text("BA"),
    ));
    harfNotlari.add(const DropdownMenuItem(
      value: 3,
      child: Text("BB"),
    ));
    harfNotlari.add(const DropdownMenuItem(
      value: 2.5,
      child: Text("CB"),
    ));
    harfNotlari.add(const DropdownMenuItem(
      value: 2,
      child: Text("CC"),
    ));
    harfNotlari.add(const DropdownMenuItem(
      value: 1.5,
      child: Text("DC"),
    ));
    harfNotlari.add(const DropdownMenuItem(
      value: 1,
      child: Text("DD"),
    ));
    harfNotlari.add(const DropdownMenuItem(
      value: 0,
      child: Text("FF"),
    ));

    return harfNotlari;
  }

  void ortalamaHesapla() {
    double bolunen = 0;
    int toplamKredi = 0;

    for (int i = 0; i < tumDersler.length; i++) {
      toplamKredi += tumDersler[i].dersKredisi;
      bolunen += tumDersler[i].dersKredisi * tumDersler[i].dersHarfNotu;
    }

    setState(() {
      ortalama = bolunen / toplamKredi;
    });
  }
}

class Ders {
  String dersAdi;
  int dersKredisi;
  double dersHarfNotu;

  Ders(this.dersAdi, this.dersKredisi, this.dersHarfNotu);
}
