
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CountryListScreen extends StatefulWidget {
  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  List<dynamic> countries = [];
  List<dynamic> filteredCountries = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    final url = 'https://restcountries.com/v3.1/all';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        countries = json.decode(response.body);
        filteredCountries = countries;
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load countries');
    }
  }

  void filterCountries(String query) {
    final filtered = countries.where((country) {
      final countryName = country['name']['common'].toLowerCase();
      final input = query.toLowerCase();

      return countryName.contains(input);
    }).toList();

    setState(() {
      filteredCountries = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF5350d5),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'World Countries',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 216, 216, 223),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (query) => filterCountries(query),
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredCountries.length,
                    itemBuilder: (context, index) {
                      final country = filteredCountries[index];
                      return ListTile(
                        leading: Image.network(
                          country['flags']['png'],
                          width: 50,
                        ),
                        title: Text(country['name']['common']),
                        subtitle: Text(
                            'Capital: ${country['capital'] != null ? country['capital'][0] : 'N/A'}'),
                        // trailing: Text(
                        //     'region: ${country['region'] != null ? country['region'][0] : 'N/A'}'),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}