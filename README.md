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
3. Enter the cloned repo: `cd examgen`
4. Run `./examgen.sh 1`

If everything went well a PDF will be opened in your screen containing one sample exam.  

## Manual

First, you need to clone this repo (this is the jargon for donwload this whole git project). For doing that you need to have [git installed](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) on your machine. 

Once you have git, cast `git clone https://github.com/abdeoliveira/examgen`

From now on, I will assume `~` as being the cloned repo folder, i.e., `cd examgen`. Thus if I referr to `~/src` for example, it means `/path/to/examgen/src`.

## Language and localization

Despite the docs and comments through the codes are in English, the default localization of this project is the Brazilian Portuguese. Thus the defaults are as follows:

* Words are separated according to the Portuguese language.
* Comma is used as decimal separator (instead of point as used in English).

If you want to localize the exams to the English language you must create a blank file named (exactly) `locale_en` inside the `~/input` folder. Simple like that.

I intend to implement other localizations in the future. If you want to tweak the code and do it for yourself, please contact me for help if needed.


## Exam Header

xxx


## Creating questions

You need to create exam questions in a specific format, necessarily with `.gnxs` extension. You may want to take a look in example files in the `~/input` folder while reading the next section. 

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
**Note:** If the question is in `mode:numeric` then you will have to deal with the `@VAR()` function in the `@question` block . Better than spending my whole [Mana](https://en.wikipedia.org/wiki/Magic_(game_terminology)) trying to explain the `@VAR()` function, I prefer to give a couple of examples of its usage.  




