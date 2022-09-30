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

You can adjust the number of alternatives for questions globally, i.e., all questions must have the same number of alternatives. This subject will be approached later.

### The `@config` block

It has 2 entries: `mode:` and `inline:`. 

`mode:` expects one of the following arguments, `numeric` or `text`. `numeric` is intended for questions with alternatives as numbers. 
`text` is intended for questions with alternatives as texts. 

`inline:` expects an integer number as argment and it stands for the number of alternatives in one line. Something between 5 and 8 do well for `mode:numeric` (e.g. `inline:8`) 
and I recommend `inline:1` for `mode:text`

Check screenshots with `inline:` variable in action. Hoover mouse pointer for caption.

![alt text](screenshots/inline-1.png "inline:1")

![alt text](screenshots/inline-2.png "inline:2")

![alt text](screenshots/inline-5.png "inline:5")


### The `@question` block

The only entry is a text following [LaTex](https://www.latex-project.org/) format. Thus equations, bolds, italics, colors and so on, will all follow LaTex format.  
**Note:** If the question is in `mode:numeric` then you have to deal with the `@VAR()` function in the `@question` block . Better than spending my whole [Mana](https://en.wikipedia.org/wiki/Magic_(game_terminology)) trying to explain the `@VAR()` function, I prefer to give a couple of examples of its usage.  




