import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/main.dart';
import 'package:study_planner/presentation/custom_icons.dart';
import 'package:study_planner/src/blocs/study_plan_cubit.dart';
import 'package:study_planner/src/models.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudyPlanCubit, StudyPlanState>(
      listener: (context, state) {
        String message;
        if (state is StudyPlanAdded) {
          message = 'New study plan ${state.studyPlan} created.';
        } else if (state is AddStudyPlanFailed) {
          message = "Error: Study plan ${state.studyPlan} couldn't be created.";
        } else if (state is StudyPlanRemoved) {
          message = 'Study plan ${state.studyPlan} deleted.';
        }
        if (message != null) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(
              CustomIcons.app_icon,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            title: Text(appName),
            actions: [
              IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () => showAboutDialog(
                  context: context,
                  applicationIcon: Icon(CustomIcons.app_icon),
                  applicationName: appName,
                ),
              )
            ],
            bottom: TabBar(
              tabs: [
                Tab(text: 'Overview'),
                Tab(text: 'Today'),
              ],
            ),
          ),
          body: TabBarView(children: [
            OverviewTab(),
            Center(
              child: Icon(Icons.error, size: 150),
            )
          ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/forms/AddStudyPlanPage',
              );
            },
            tooltip: 'Add study plan.',
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class OverviewTab extends StatefulWidget {
  const OverviewTab({
    Key key,
  }) : super(key: key);

  @override
  _OverviewTabState createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab>
    with AutomaticKeepAliveClientMixin<OverviewTab> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: StreamBuilder(
        stream: BlocProvider.of<StudyPlanCubit>(context).studyPlans,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isEmpty) {
              return _buildEmpty();
            } else {
              return _StudyPlanListView(snapshot.data);
            }
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return _buildGenericError(snapshot.error);
          } else {
            return _buildEmpty();
          }
        },
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(child: Text('No study plans yet. Press "+" to create.'));
  }

  Widget _buildGenericError(Error error) {
    return Center(child: Text('Error: $error.'));
  }

  @override
  bool get wantKeepAlive => true;
}

class _StudyPlanListView extends StatelessWidget {
  final List<StudyPlan> data;

  _StudyPlanListView(this.data);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        var studyPlan = data[index];
        return Dismissible(
          key: UniqueKey(),
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
