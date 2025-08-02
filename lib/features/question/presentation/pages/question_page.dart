// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:online_exam_app/core/utiles/dialog/dialog_helper.dart';
// import 'package:online_exam_app/features/question/presentation/cubit/question_cubit.dart';
// import 'dart:async';

// class QuestionPage extends StatefulWidget {
//   const QuestionPage({super.key});
//   static const String routeName = 'question';
//   @override
//   _QuestionPageState createState() =>
//       _QuestionPageState();
// }

// class _QuestionPageState extends State<QuestionPage> {
//   int currentIndex = 0;
//   int totalSeconds = 0;
//   Timer? timer;
//   List<List<int>> selectedAnswers = [];

//   void startTimer() {
//     timer?.cancel();
//     timer = Timer.periodic(const Duration(seconds: 1), (
//       Timer t,
//     ) {
//       if (totalSeconds > 0) {
//         setState(() {
//           totalSeconds--;
//         });
//       } else {
//         t.cancel();
//         DialogHelper.showFinishDialog(context);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: BlocBuilder<QuestionCubit, QuestionState>(
//           builder: (context, state) {
//             if (state is QuestionsLoadingState ||
//                 state is QuestionsInitialState) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }

//             if (state is QuestionsErrorState) {
//               return Center(
//                 child: Text(state.errorMessage ?? ''),
//               );
//             }

//             if (state is QuestionsSuccessState) {
//               var questions = state.questions ?? [];

//               if (questions.isEmpty) {
//                 return const Center(
//                   child: Text("No questions available"),
//                 );
//               }

//               /// ✅ تأمين قيمة `duration` لتجنب `setState` بعد `dispose`
//               if (questions.isNotEmpty &&
//                   totalSeconds == 0 &&
//                   timer == null) {
//                 WidgetsBinding.instance
//                     .addPostFrameCallback((_) {
//                       if (mounted) {
//                         setState(() {
//                           totalSeconds =
//                               (questions
//                                       .first
//                                       .exam
//                                       ?.duration ??
//                                   0) *
//                               60;
//                         });
//                         startTimer();
//                       }
//                     });
//               }

//               if (selectedAnswers.isEmpty) {
//                 selectedAnswers = List.generate(
//                   questions.length,
//                   (index) => [],
//                 );
//               }

//               var question = questions[currentIndex];
//               bool isMultiple =
//                   question.type == "multiple_choice";

//               return Column(
//                 crossAxisAlignment:
//                     CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 40.h),
//                   Row(
//                     mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.arrow_back_ios_new,
//                             color: Colors.black,
//                             size: 25,
//                           ),
//                           Text(
//                             "Exam",
//                             style: Theme.of(
//                               context,
//                             ).textTheme.labelLarge,
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           const SizedBox(
//                             height: 40,
//                             width: 40,
//                             child: Icon(Icons.timer),
//                           ),
//                           Text(
//                             formatTime(totalSeconds),
//                             style: TextStyle(
//                               color: totalSeconds < 900
//                                   ? Colors.red
//                                   : Colors.green,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Text(
//                     "Question ${currentIndex + 1} of ${questions.length}",
//                     style: Theme.of(
//                       context,
//                     ).textTheme.bodyMedium,
//                   ),
//                   LinearProgressIndicator(
//                     value:
//                         (currentIndex + 1) /
//                         questions.length,
//                     backgroundColor: Colors.grey[300],
//                     color: Colors.blue,
//                     minHeight: 8,
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     question.question ?? "No Question",
//                     style: Theme.of(
//                       context,
//                     ).textTheme.labelLarge,
//                   ),
//                   const SizedBox(height: 20),
//                   Column(
//                     children: List.generate(
//                       question.answers?.length ?? 0,
//                       (index) {
//                         String option =
//                             question
//                                 .answers?[index]
//                                 .answer ??
//                             "";

//                         return isMultiple
//                             ? CheckboxListTile(
//                                 title: Text(option),
//                                 value:
//                                     selectedAnswers[currentIndex]
//                                         .contains(index),
//                                 onChanged: (bool? value) {
//                                   setState(() {
//                                     if (value == true) {
//                                       selectedAnswers[currentIndex]
//                                           .add(index);
//                                     } else {
//                                       selectedAnswers[currentIndex]
//                                           .remove(index);
//                                     }
//                                   });
//                                 },
//                               )
//                             : RadioListTile<int>(
//                                 title: Text(option),
//                                 value: index,
//                                 groupValue:
//                                     selectedAnswers[currentIndex]
//                                         .isEmpty
//                                     ? -1
//                                     : selectedAnswers[currentIndex]
//                                           .first,
//                                 // ✅ تأمين قيمة `groupValue`
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedAnswers[currentIndex] =
//                                         [value!];
//                                   });
//                                 },
//                               );
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 20.h),
//                   Spacer(),
//                   Row(
//                     mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                     children: [
//                       QuizButton(
//                         ontap: currentIndex > 0
//                             ? () => setState(
//                                 () => currentIndex--,
//                               )
//                             : null,
//                         text: const Text(
//                           "Back",
//                           style: TextStyle(
//                             color: Colors.blue,
//                           ),
//                         ),
//                         backgroundcolor: Colors.white,
//                       ),
//                       QuizButton(
//                         ontap:
//                             currentIndex ==
//                                 questions.length - 1
//                             ? () {
//                                 // تجهيز قائمة تحتوي على جميع الإجابات لكل الأسئلة كـ List<Map<String, dynamic>>

//                                 List<Map<String, String>>
//                                 answersList = [];

//                                 for (
//                                   int i = 0;
//                                   i < questions.length;
//                                   i++
//                                 ) {
//                                   if (selectedAnswers[i]
//                                       .isNotEmpty) {
//                                     answersList.add({
//                                       "questionId":
//                                           questions[i]
//                                               .id ??
//                                           "", // ✅ تأمين القيمة
//                                       "correct": selectedAnswers[i]
//                                           .map(
//                                             (index) =>
//                                                 questions[i]
//                                                     .answers?[index]
//                                                     .key ??
//                                                 "",
//                                           )
//                                           .join(
//                                             ",",
//                                           ), // ✅ تحويل القائمة إلى String مفصول بفاصلة
//                                     });
//                                   }
//                                 }

//                                 // Navigator.push(
//                                 //   context,
//                                 //   MaterialPageRoute(
//                                 //     builder: (context) => ExamScoreScreen(
//                                 //       questions: state.response.data?.questions??[],
//                                 //       exam: widget.exam,
//                                 //       examID: widget.examID,
//                                 //       answers: answersList.cast<Map<String, String>>(), // ✅ تحويل البيانات للنمط الصحيح
//                                 //       time: (questions.first.exam?.duration ?? 0) * 60 - totalSeconds, // ✅ تمرير الوقت بشكل منفصل
//                                 //     ),
//                                 //   ),
//                                 // );
//                               }
//                             : () => setState(
//                                 () => currentIndex++,
//                               ),
//                         text: Text(
//                           currentIndex ==
//                                   questions.length - 1
//                               ? "Submit"
//                               : "Next",
//                           style: Theme.of(context)
//                               .textTheme
//                               .labelMedium
//                               ?.copyWith(
//                                 color: Colors.white,
//                               ),
//                         ),
//                         backgroundcolor: Colors.blue,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 50.h),
//                 ],
//               );
//             }
//             return const SizedBox();
//           },
//         ),
//       ),
//     );
//   }

//   void submitQuiz() {
//     print("Quiz submitted successfully!");
//   }

//   void printQuestionsTesttt(String question) {
//     print(question);
//   }
// }

// String formatTime(int seconds) {
//   int minutes = seconds ~/ 60;
//   int remainingSeconds = seconds % 60;
//   return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
// }

// // ignore: must_be_immutable
// class QuizButton extends StatelessWidget {
//   void Function()? ontap;
//   Widget text;
//   Color backgroundcolor;
//   QuizButton({
//     required this.ontap,
//     required this.text,
//     required this.backgroundcolor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return InkWell(
//       onTap: ontap,
//       child: Container(
//         width: width * 0.44,
//         height: height * 0.07,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: backgroundcolor,
//           border: Border.all(color: Colors.blue),
//         ),
//         child: Align(
//           alignment: Alignment.center,
//           child: text,
//         ),
//       ),
//     );
//   }
// }
