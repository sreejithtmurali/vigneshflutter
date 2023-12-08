import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vigneshflutter/constants.dart';

import 'addd.dart';
import 'empprovider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => EmployeeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Fetch Example',
      home: MyHomePage(),
      theme: ThemeData(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);
    employeeProvider.fetchEmployees();
    return Scaffold(
      body: Center(child: EmployeeListWidget()),
    );
  }
}

class EmployeeListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);
    if (employeeProvider.employees.isEmpty) {
      return CircularProgressIndicator();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.textColorwhite,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "EMPLOYEE DETAILS",
          style: TextStyle(color: AppColors.textColorwhite),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
        ),
        child: SingleChildScrollView(
          child: Container(
            height: 800,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width - 100,
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search,color: AppColors.textColorwhite,),
                            label: Text("Find Phone Number",style: TextStyle(fontSize: 12,color: Colors.white38),),
                            filled: true,
                            fillColor: Color(0x49ffffff),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 50,
                          width: 50,
                          color: Color(0x49ffffff),
                          child: IconButton(
                              tooltip: "Add User",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddEmployeeScreen()),
                                );
                              },
                              icon: Icon(
                                Icons.add_chart_outlined,
                                color: Colors.white38,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.textColorwhite,

                    // borderRadius: BorderRadius.circular(12),
                  ),
                  height: 800,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ListView.builder(
                      itemCount: employeeProvider.employees.length,
                      itemBuilder: (context, index) {
                        final employee = employeeProvider.employees[index];

                        return Card(
                          elevation: 2,
                          child: ListTile(
                            leading: FloatingActionButton(
                              onPressed: () {},
                              child: Text(
                                '${employee.employeeName![0].toUpperCase()}',
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                            ),
                            title: Text('${employee.employeeName}'),
                            subtitle: Text(
                                'Salary: ${employee.employeeSalary}, Age: ${employee.employeeAge}'),
                            trailing: Container(
                              height: 35,
                              color: AppColors.primaryColor,
                              width: 80,
                              child: Center(
                                  child: Text(
                                "select",
                                style:
                                    TextStyle(color: AppColors.textColorwhite),
                              )),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
