import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planer/src/blocs/study_plans_bloc.dart';
import 'package:study_planer/src/models.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  final String title = 'Study planer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/icon/icon-white.png'),
        ),
        title: Text(title),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: BlocListener<StudyPlansBloc, StudyPlansState>(
          listener: (context, state) {
            if (state is StudyPlanAdded) {
              String message = state.successful
                  ? 'New study plan ${state.studyPlan} created.'
                  : "Error: study plan ${state.studyPlan} couldn't be created.";
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text(message)));
            }
          },
          child: BlocBuilder<StudyPlansBloc, StudyPlansState>(
            buildWhen: (previous, current) => !(current is StudyPlanAdded),
            builder: (context, state) {
              if (state is StudyPlansEmpty) {
                return _buildEmpty();
              } else if (state is StudyPlansLoading) {
                return _buildLoading();
              } else if (state is StudyPlansLoaded) {
                return _buildStudyPlanListView(state.studyPlans);
              } else {
                return _buildErrorNoSuchState(state);
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

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildStudyPlanListView(Stream<List<StudyPlan>> studyPlans) {
    return StreamBuilder(
      stream: studyPlans,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return StudyPlanListView(snapshot.data);
        } else {
          return _buildLoading();
        }
      },
    );
  }

  Widget _buildErrorNoSuchState(StudyPlansState state) {
    return Center(child: Text("ERROR. Couldn't handle state $state."));
  }
}

class StudyPlanListView extends StatelessWidget {
  final List<StudyPlan> data;

  StudyPlanListView(this.data);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: data.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.black,
      ),
      itemBuilder: (BuildContext context, int index) {
        var studyPlan = data[index];
        return ListTile(
          title: Text('${studyPlan.subject}'),
          subtitle: Text('exam date: ${studyPlan.examDate}'),
        );
      },
    );
  }
}
