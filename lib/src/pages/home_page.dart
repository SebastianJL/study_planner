import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/presentation/custom_icons.dart';
import 'package:study_planner/src/blocs/study_plan_cubit.dart';
import 'package:study_planner/src/models.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  final String title = 'Study planner';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          CustomIcons.app_icon,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        title: Text(title),
      ),
      body: Container(
        child: BlocListener<StudyPlanCubit, StudyPlanState>(
          listener: (context, state) {
            String message;
            if (state is StudyPlanAdded) {
              message = 'New study plan ${state.studyPlan} created.';
            } else if (state is AddStudyPlanFailed) {
              message =
                  "Error: study plan ${state.studyPlan} couldn't be created.";
            } else if (state is StudyPlanRemoved) {
              message = 'Study plan ${state.studyPlan} deleted.';
            }
            if (message != null) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            }
          },
          child: StreamBuilder(
            stream: BlocProvider.of<StudyPlanCubit>(context).studyPlans,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.isEmpty) {
                  return _buildEmpty();
                } else {
                  return StudyPlanListView(snapshot.data);
                }
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return _buildGenericError(snapshot.error);
              } else {
                return _buildEmpty();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/forms/AddStudyPlanPage',
          );
        },
        tooltip: 'Add study plan.',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(child: Text('No study plans yet. Press "+" to create.'));
  }

  Widget _buildGenericError(Error error) {
    return Center(child: Text('Error: $error.'));
  }
}

class StudyPlanListView extends StatelessWidget {
  final List<StudyPlan> data;

  StudyPlanListView(this.data);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        var studyPlan = data[index];
        return Dismissible(
          key: Key('StudyPlan $index'),
          background: Container(
            color: Colors.blue,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 27,
                ),
              ),
            ),
          ),
          secondaryBackground: Container(
            color: Colors.amber,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 27,
                ),
              ),
            ),
          ),
          confirmDismiss: (direction) {
            if (direction == DismissDirection.endToStart) {
              return _showDeleteDialog(context, studyPlan);
            } else {
              Navigator.of(context)
                  .pushNamed('/forms/AddStudyPlanPage', arguments: studyPlan);
              return Future.value(false);
            }
          },
          onDismissed: (direction) => BlocProvider.of<StudyPlanCubit>(context)
              .removeStudyPlan(index, studyPlan),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withAlpha(150),
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              child: Text(studyPlan.subject[0]),
            ),
            title: Text('${studyPlan.subject}'),
            subtitle: Text('exam date: ${studyPlan.examDate}'),
          ),
        );
      },
    );
  }

  Future<bool> _showDeleteDialog(BuildContext context, StudyPlan studyPlan) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          var nav = Navigator.of(context);
          return AlertDialog(
            title: Text('Delete $studyPlan?'),
            actions: [
              FlatButton(
                child: Text('No'),
                onPressed: () => nav.pop(false),
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () => nav.pop(true),
              ),
            ],
          );
        });
  }
}
