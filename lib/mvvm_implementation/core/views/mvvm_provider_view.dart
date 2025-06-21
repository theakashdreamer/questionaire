import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questionaire/mvvm_implementation/core/api/post_api.dart';
import 'package:questionaire/mvvm_implementation/core/model/org_qual_course.dart';
import 'package:questionaire/mvvm_implementation/core/views/unitCard.dart' show UnitCard;
import 'package:questionaire/mvvm_implementation/viewmodel/home_view_model.dart';
import '../../base_widget.dart';

class MvvmProviderView extends StatefulWidget {
  const MvvmProviderView({super.key});

  @override
  State<MvvmProviderView> createState() => _HomeViewState();
}

class _HomeViewState extends State<MvvmProviderView> {
  String? selectedClassId;
  String? selectedSubjectId;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      model: HomeViewModel(
        postApi: Provider.of<PostApi>(context, listen: false),
      ),
      onModelReady: (model) async {
        debugPrint('🧠 onModelReady triggered');
        await model.initModel();
      },
      builder: (context, model, _) {
        debugPrint('📦 HomeView building');
        return Scaffold(
          appBar: AppBar(
            title: const Text('Class Master Data'),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'Refresh Class Data',
                onPressed: () async {
                  debugPrint('🔄 Refresh button clicked');
                  await model.fetchClassMasterData();
                  setState(() {
                    selectedClassId = null;
                    selectedSubjectId = null;
                    model.subjectList.clear();
                    model.unitChapterList.clear();
                  });
                },
              ),
            ],
          ),

          body: _buildBody(context, model),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, HomeViewModel model) {
    debugPrint('🔧 _buildBody → busy = ${model.busy}');
    if (model.busy) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 16),

            // 🔽 Class Dropdown
            if (model.classList.isNotEmpty)
              DropdownButton<String>(
                isExpanded: true,
                hint: const Text("Select a Class"),
                value: selectedClassId,
                items: model.classList.map((course) {
                  return DropdownMenuItem<String>(
                    value: course.id,
                    child: Text(course.className ?? course.title ?? 'Unnamed'),
                  );
                }).toList(),
                onChanged: (value) async {
                  setState(() {
                    selectedClassId = value;
                    selectedSubjectId = null;
                    model.subjectList.clear();
                    model.unitChapterList.clear();
                  });
                  if (value != null) {
                    await model.fetchSubjectsByClassId(value);
                  }
                },
              ),

            const SizedBox(height: 16),

            // 🔽 Subject Dropdown
            if (model.subjectList.isNotEmpty)
              DropdownButton<String>(
                isExpanded: true,
                hint: const Text("Select a Subject"),
                value: selectedSubjectId,
                items: model.subjectList.map((subject) {
                  return DropdownMenuItem<String>(
                    value: subject.id,
                    child: Text(subject.name ?? 'Unknown'),
                  );
                }).toList(),
                onChanged: (value) async {
                  setState(() {
                    selectedSubjectId = value;
                    model.unitChapterList.clear();
                  });
                  if (selectedClassId != null && value != null) {
                    await model.fetchLessonAccToSubject(selectedClassId!, value);
                  }
                },
              ),

            const SizedBox(height: 16),

            // 📘 Unit List
            model.unitChapterList.isNotEmpty
                ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: model.unitChapterList.length,
              itemBuilder: (context, index) {
                final unit = model.unitChapterList[index];
                return UnitCard(
                  unit: unit,
                  index: index,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Tapped: ${unit.chapterNameOrLessonName}"),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.redAccent,
                        action: SnackBarAction(
                          label: 'Close',
                          textColor: Colors.white,
                          onPressed: () {
                            // optional: do something when snackbar action is clicked
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ) : const Text("No units to display yet."),
          ],
        ),
      ),
    );
  }
}






