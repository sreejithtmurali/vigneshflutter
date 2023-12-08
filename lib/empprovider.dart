import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/Data.dart';

class EmployeeProvider extends ChangeNotifier {
  List<Data> employees = [];

  Future<void> fetchEmployees() async {
    // try {
    final response = await http
        .get(Uri.parse("https://dummy.restapiexample.com/api/v1/employees"));
    print(response.body.toString());
//pr
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> employeeData = data['data'];

      employees = employeeData.map((e) => Data.fromJson(e)).toList();

      notifyListeners();
      //   } else {
      //     throw Exception(
      //         'Failed to fetch employees. Status Code: ${response.statusCode}');
      //   }
      // } catch (error) {
      //   throw Exception('Failed to fetch employees: $error');
      // }
    }
  }

  Future<void> addEmployee(String name, String salary, String age) async {
    final url = Uri.parse("https://dummy.restapiexample.com/api/v1/create");
    final Map<String, String> requestBody = {
      "name": name,
      "salary": salary,
      "age": age,
    };

    try {
      final response = await http.post(url, body: requestBody);

      if (response.statusCode == 200) {
        print("----------------------------------------------");
        print("${requestBody}");
        print("${response.body}");
        employees.add(Data(
            employeeName: name,
            employeeAge: int.parse(age),
            employeeSalary: double.parse(salary)));
        notifyListeners();
      } else {
        throw Exception(
            'Failed to add employee. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to add employee: $error');
    }
  }
}
