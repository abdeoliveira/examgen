# Exam Generator 

Professors with focus on (but not restricted to) math sciences can generate individualised exams for each student.
Despite the questions are the same, variables and consequently the answers are different. Questions are also shuffled. 
Latex is in charge to beautifully build the PDFs.

Last but not least, an application for correction is included. All you have to do is to scan the exams and provide the images to the Correction application. 
See Usage section for details. The correction code will read the images and extract students answers.Then, it will compare them to the right keys, i.e., it will
perform the correction process itself. Finally, a .csv file report is generated with students scores.

# Dependencies

1. ruby
2. tex-live
3. Ruby gems: mini_magick, date, and csv.

# Usage

First, you need to clone this repo (this is the jargon for donwload this whole git project). For doing that you need to have [git installed](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) on your machine. 

Once you have git, cast `git clone https://github.com/abdeoliveira/examgen`

From now on, I will assume `~` as being the cloned repo folder, i.e., `cd examgen`.

## Creating questions

You need to create exam questions in a specific format, necessarily with `.gnxs` extension.  

Question files must have 4 blocks, which are `@config`, `@question`, `@figure`, and `@answer`, and must terminate with `@end`.

+ @config block

Has 2 entries: `mode` and `inline`.

++ `mode` can be `numeric` or `text`. 

+++ `numeric`: is intended for questions in which the student must calculate the answer, with alternatives as numbers.
+++ `text`: is intended for questions with alternatives as written texts. 

Questions can be of two types: numeric or text. Please find question templates in the input folder. 







