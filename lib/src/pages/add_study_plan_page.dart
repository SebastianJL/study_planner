import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:study_planner/src/blocs/study_plan_cubit.dart';
import 'package:study_planner/src/blocs/study_plan_form_bloc.dart';

class AddStudyPlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StudyPlanFormBloc(BlocProvider.of<StudyPlanCubit>(context)),
      child: Builder(
        builder: (context) {
          // ignore: close_sinks
          final formBloc = context.bloc<StudyPlanFormBloc>();

          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: CloseButton(),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: RaisedButton(
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      textColor: Theme.of(context).colorScheme.primary,
                      color: Theme.of(context).colorScheme.onPrimary,
                      elevation: 0,
                      onPressed: () => formBloc.submit(),
                      child: Text('Create study plan')),
                ),
              ],
            ),
            body: FormBlocListener<StudyPlanFormBloc, String, String>(
              onSubmitting: (context, state) {
                LoadingDialog.show(context);
              },
              onSuccess: (context, state) {
                LoadingDialog.hide(context);
                Navigator.of(context).pop();
              },
              onFailure: (context, state) {
                LoadingDialog.hide(context);
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(state.failureResponse)));
              },
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextFieldBlocBuilder(
                      textFieldBloc: formBloc.subject,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.subject),
                        labelText: 'Subject',
                        hintText: 'Maths, biology, ...',
                      ),
                    ),
                    DateTimeFieldBlocBuilder(
                      dateTimeFieldBloc: formBloc.examDate,
                      format: DateFormat('dd-mm-yyyy'),
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                      decoration: InputDecoration(
                        labelText: 'Exam date',
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                    BlocBuilder(
                      cubit: formBloc.learningGoals,
                      builder: (context, state) {
                        if (state.fieldBlocs.isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.fieldBlocs.length,
                            itemBuilder: (context, index) => LearningGoalCard(
                              memberIndex: index,
                              learningGoalField: state.fieldBlocs[index],
                              onRemoveLearningGoal: () =>
                                  formBloc.removeLearningGoal(index),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    RaisedButton(
                      padding: const EdgeInsets.all(8),
                      child: Text('Add learning goal'),
                      onPressed: () => formBloc.addLearningGoal(),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class LearningGoalCard extends StatelessWidget {
  final int memberIndex;
  final LearningGoalFieldBloc learningGoalField;

  final VoidCallback onRemoveLearningGoal;

  const LearningGoalCard({
    Key key,
    @required this.memberIndex,
    @required this.learningGoalField,
    @required this.onRemoveLearningGoal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Learning Goal #${memberIndex + 1}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: onRemoveLearningGoal,
                ),
              ],
            ),
            TextFieldBlocBuilder(
              textFieldBloc: learningGoalField.description,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.description),
                labelText: 'Description',
                hintText: 'Script, pdf, lecture videos, ...',
              ),
            ),
            TextFieldBlocBuilder(
              textFieldBloc: learningGoalField.quantity,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity',
              ),
            ),
            TextFieldBlocBuilder(
              textFieldBloc: learningGoalField.quantifier,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Quantifier',
                hintText: 'Pages, lectures, ...',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
