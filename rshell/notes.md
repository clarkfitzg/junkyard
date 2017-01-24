Mon Jan 23 13:08:04 PST 2017

Presenting to the Davis R Users Group on R and the shell.

## Topics

- Motivation: automation, sanity
- (maybe) file directories
- System `$PATH` variable
- Command line use of Rscript with `commandArgs()`
- Calling other programs with `system2()`
- (maybe) make

## Tasks

- Making R scripts executable
- Concatenating many text files into one
- Call a different program from R
- Call R script on every file in a directory
- Delaying the call of an R script
- Installing and using development versions of libraries

## Don't Forget

- Command line and Git workshops in DSI coming up

## Backstory

After programming in R for a while I started using Python in 2013. I 
also started to do more work on servers and clusters. Using the command
line doesn't come easy, and my experience was no exception. 

## Motivation

Command line tools exist to make your life as a programmer easier. Most
programming languages have a mechanism for interacting with the system
command line. (Can you think of any exceptions? Maybe SQL)
Desktops, laptops, servers and clusters, they all have command lines.
Indeed, on most servers and clusters the command line is the _only_ way to
use the machine.  So the command line can be considered the "lowest common
denominator" for interacting with a computer. 

Non example: Click on this, select the pull down menu and manually update
that, etc. This workflow might be fine for getting a quick homework
assigment done, but it's hard to document and duplicate.

Another advantage is that you have control over every aspect of your system
from the command line. Need to set an environmental variable? No problem.

In this talk we'll explore how to use R with the system command line.

For many

## Running a script in the future

The `at` command is one way to do this. `cron` allows more sophisticated
scheduling.

```
$ at now + 1 min
warning: commands will be executed using /bin/sh
at> Rscript counter.R >> output.txt
at> <EOT>    # Here I pressed CTRL+d
job 6 at Mon Jan 23 16:44:00 2017
```
