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
3. ImageMagick
4. Ruby gems: mini_magick, date, and csv.

If you are using a debian-based distribution, something like 

`sudo apt-get install ruby ruby-dev texlive-latex-base texlive-science imagemagick`

and also 

`gem install mini_magick csv date`

will solve the aforementioned dependencies. For other distros, please check distro-specific docs for directions.

# Usage

## Quick Start

If you are in a hurry, and want a quick result, do as follows:

1. Install git (in debian-based distros, do `sudo update && sudo apt install git`)
2. Clone this repo: `git clone https://github.com/abdeoliveira/examgen`
3. Enter the `src` dir inside the repo folder: `cd examgen/src`
4. Copy the auxiliary script into the `src` folder: `cp ../candy/test.sh .`
5. Run the auxiliary script: `./test.sh`

If everything went well a PDF will opened in your screen containing a sample exam.

## Manual

First, you need to clone this repo (this is the jargon for donwload this whole git project). For doing that you need to have [git installed](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) on your machine. 

Once you have git, cast `git clone https://github.com/abdeoliveira/examgen`

From now on, I will assume `~` as being the cloned repo folder, i.e., `cd examgen`.

## Language and localization

Despite the docs and comments through the codes are in English, the LaTex header was conceived to work with the pt_br locale as follows:

* Words are separated according to the Portuguese language.
* Comma is used as decimal separator.

If you want to localize your text to other language, you must edit the file `~/aux/header.tex` in two lines. 
The first is indeed the first line, which reads `\documentclass[9pt,twocolumn,brazil]{article}`,
in which you can change `brazil` and accomodate your needs.

The second place is the line ```\mathcode`,="002C```. Commenting this line, i.e. putting a `%` in front of it,  makes LaTex to use 'point' instead of 'comma' for decimal separator.  

## Exam Header

xxx



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

Check screenshots with the `inline:` variable in action. 

**inline:1**
![alt text](screenshots/inline-1.png "inline:1")

-----

**inline:2**
![alt text](screenshots/inline-2.png "inline:2")

-----

**inline:8** [Note the code handles the case in which there are fewer alternatives, 5, than inline: argument, 8]
![alt text](screenshots/inline-5.png "inline:8")

-----


### The `@question` block

The only entry is a text following [LaTex](https://www.latex-project.org/) format. Thus equations, bolds, italics, colors and so on, will all follow LaTex format.  
**Note:** If the question is in `mode:numeric` then you have to deal with the `@VAR()` function in the `@question` block . Better than spending my whole [Mana](https://en.wikipedia.org/wiki/Magic_(game_terminology)) trying to explain the `@VAR()` function, I prefer to give a couple of examples of its usage.  




