import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/modules/vitals/insuline/cubit/cubit.dart';
import 'package:fristapp/modules/vitals/insuline/cubit/states.dart';
import 'package:intl/intl.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../shared/component/component.dart';
import '../../../shared/styles/MyIcon.dart.dart';

class AddNewValueinsulin extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<insulinCubit, insulinStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = insulinCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [],
            title: Text(
              "Insulin",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0,
              ),
            ),
          ),
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.all(
              20.0,
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  defultFormField(
                    lable: 'Value',
                    controller: titleController,
                    type: TextInputType.number,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'please enter Insulin value';
                      }
                      if (double.parse(value) > 1000 ||
                          double.parse(value) < 1) {
                        return 'please enter a valid Insulin value';
                      }
                    },
                    prefix: MyIcon.weight,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defultFormField(
                    lable: 'Date',
                    controller: dateController,
                    type: TextInputType.datetime,
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(Duration(days: 30)),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        dateController.text = DateFormat.yMd().format(value!);
                        print(dateController.text);
                      });
                    },
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'date must not be empty';
                      }
                    },
                    prefix: Icons.calendar_today,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defultFormField(
                    controller: timeController,
                    type: TextInputType.datetime,
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) {
                        timeController.text = value!.format(context).toString();
                        print(timeController.text);
                      });
                    },
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'time must not be empty';
                      }
                    },
                    lable: 'Time',
                    prefix: Icons.watch_later_outlined,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  ConditionalBuilder(
                    condition: State is! insulinStartAddToGoogleFitSuccessState,
                    builder: (context) => defulteButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          // Handle DateTime
                          List dateList = dateController.text.split('/');
                          String newDate =
                              '${dateList[2]}-${dateList[0]}-${dateList[1]}';
                          DateTime time_and_oldDate =
                              DateFormat.jm().parse(timeController.text);
                          String datetimeString = time_and_oldDate
                              .toString()
                              .replaceFirst('1970-01-01', newDate);
                          DateTime timeDate =
                              new DateFormat("yyyy-MM-dd hh:mm:ss")
                                  .parse(datetimeString);

                          //
                          cubit.addinsulinToGooglefit(
                            insulin: double.parse(titleController.text),
                            date: timeDate,
                          );
                          GPCubit().refreshandfetch();
                          titleController.text = '';
                          timeController.text = '';
                          dateController.text = '';
                          Navigator.pop(context);
                        }
                      },
                      text: 'ADD',
                    ),
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
