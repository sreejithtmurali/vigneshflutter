// add_employee_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vigneshflutter/constants.dart';
import 'empprovider.dart';

class AddEmployeeScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        leading:IconButton(onPressed: () {
          Navigator.pop(context);
        },
         icon: Icon(
            Icons.arrow_back,
            color: AppColors.textColorwhite,
          ),),
        title: Text(
          'EMPLOYEE DETAILS',
          style: TextStyle(color: AppColors.textColorwhite),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height-100,
              color: AppColors.primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.textColorwhite,
                    border: Border.all(
                      color: AppColors.textColorwhite,
                      width: 8,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView(

                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (String? value) {
                            return (value!.length<2) ? 'Name Too Short' : null;
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                              hintText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              suffixIcon: Icon(
                                Icons.task_alt,
                                color: AppColors.primaryColor,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (String? value) {
                            return (value!.isEmpty || int.parse(value)<1000) ? 'Please enter your salary' : null;
                          },
                          keyboardType: TextInputType.number,
                          controller: salaryController,
                          decoration: InputDecoration(
                              hintText: 'Salary',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              suffixIcon: Icon(
                                Icons.task_alt,
                                color: AppColors.primaryColor,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (String? value) {
                            return (value!.isEmpty|| int.parse(value)>120) ? 'Age not look like normal' : null;
                          },
                          controller: ageController,
                          decoration: InputDecoration(
                              hintText: 'Age',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              suffixIcon: Icon(
                                Icons.task_alt,
                                color: AppColors.primaryColor,
                              )),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(

                        child: Row(
                          children: [
                            Checkbox(value: false, onChanged: (value){



                            }),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width:300,
                                    child: Text("By Creating Accou nt You Agree to our",style: TextStyle(fontSize: 10),)),
                                Container(
                                  width: 300,
                                    child: Text("Terms And Conditions",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ],
                        ),
                      ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: GestureDetector(
                         onTap: () async {
                          if(_formKey.currentState!.validate()){
                            final name = nameController.text;
                            final salary = salaryController.text;
                            final age = ageController.text;

                            if (name.isNotEmpty &&
                                salary.isNotEmpty &&
                                age.isNotEmpty) {
                              await Provider.of<EmployeeProvider>(context,
                                  listen: false)
                                  .addEmployee(name, salary, age)
                                  .then((value) => Navigator.pop(context));

                              // Close the Add Employee screen
                            } else {
                              // Show error message or handle validation as needed
                            }
                          }
                         },
                         child: Container(
                           decoration: BoxDecoration(
                             color: AppColors.primaryColor,

                             // border: Border.all(
                             //   width: 1,
                             // ),
                             borderRadius: BorderRadius.circular(12),
                           ),
                           height: 55,
                           child: Center(child: Text("Register",style: TextStyle(color: AppColors.textColorwhite),),),
                         ),
                       ),
                     )

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
