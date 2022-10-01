import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class task extends StatefulWidget {
  const task({ Key? key }) : super(key: key);

  @override
  State<task> createState() => _taskState();
}

class _taskState extends State<task> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<>>(
        stream: fsService.getStudentLessonDetail(widget.user.username),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else {
            return ListView.separated(
              itemBuilder: (ctx, i) {
                return ExpandableNotifier(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: Colors.grey.withOpacity(0.2), width: 1)),
                      child: ScrollOnExpand(
                        child: ExpandablePanel(
                          theme: ExpandableThemeData(
                            tapBodyToCollapse: true,
                            tapBodyToExpand: true,
                          ),
                          header: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(snapshot.data![i].dateCreated!),
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // what it says when collapsed
                          collapsed: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data![i].lessonType!,
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(width: 1),
                              Text(
                                widget.user.role == 'teacher'
                                    ? "To: " + snapshot.data![i].studentUsername!
                                    : "By: " + snapshot.data![i].teacherUsername,
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),

                          expanded: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snapshot.data![i].lessonType!),
                                  SizedBox(
                                    width: 1,
                                  ),
                                  Text(
                                    widget.user.role == 'teacher'
                                        ? "To: " +
                                            snapshot.data![i].studentUsername!
                                        : "By: " +
                                            snapshot.data![i].teacherUsername,
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // where more lesson details go and images
                              Text(snapshot.data![i].lessonDetail!),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // edit lesson details
                                 widget.user.role == 'teacher' ?
                                  TextButton(onPressed: () => Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new EditLessonDetailScreen(widget.user),
                                              settings: RouteSettings(
                                                  arguments:
                                                      snapshot.data![i]))),
                                      child: Text('Edit')): Text(''),
                                       widget.user.role == 'teacher'?
                                  TextButton(
                                      onPressed: () =>
                                          removeItem(snapshot.data![i].id),
                                      child: Text('Delete')): Text(''),
                                ],
                              )
                            ],
                          ),
                          builder: (_, collapsed, expanded) => Padding(
                            padding: const EdgeInsets.all(8.0).copyWith(top: 0),
                            child: Expandable(
                              collapsed: collapsed,
                              expanded: expanded,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: snapshot.data!.length,
              separatorBuilder: (ctx, i) {
                return Divider(height: 1, color: Colors.white);
              },
            );
          }
        });
  }
}