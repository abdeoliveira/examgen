# Exam Generator 

Professors with focus on (but not restricted to) math sciences can generate individualised exams for each student.
Despite the questions are the same, variables and consequently the answers are different. Questions are also shuffled. 
Latex is in charge to beautifully build the PDFs.

Last but not least, an application for correction is included. All you have to do is to scan the exams and provide the images to the Correction application. 
See Usage section for details. The correction code will read the images and extract students answers.Then, it will compare them to the right keys, i.e., it will
perform the correction process it self. Finally, a .csv file report is generated with students scores.

# Dependencies

1. ruby
2. tex-live
3. Ruby gems: mini_magick, date, and csv.

# Usage

You need to create exam questions in a specific format, put them into the input folder and name them with a .gnxs extension. Questions can be of two types: numeric or text. Please find question templates in the input folder.
