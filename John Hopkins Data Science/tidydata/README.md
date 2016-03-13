# Introduction

This is the course project for the Getting and Cleaning Data class at Johns Hopkins offered on Coursera (https://www.coursera.org/course/getdata).

The goal of this project is to read in some raw data recorded by Samsung mobile phones during an experiment and tidy this up a bit.

In particular, the raw data are spread across multiple different files. In some cases, files correspond to what should be header rows. In other cases, they are simple "labels" corresponding to numeric constants that were embedded in other data. Basically then, we load in all the data, merge various files, set appropriate header names and trim it down to just the data/variables that interest us, before outputting some summary data. The details of all of this can be found in the Code Book (see below). 

Files
-----

* **Readme.md** - this read me file
* **CodeBook.md** - describes transformations that were applied to the raw data in order to create the tidy dataset as well as the variables in the resulting tidy dataset
* **Raw Data** - contained in the `/data` folder of this repository
* **run_analysis.R** - The R script which was run to read in the raw data, transform this and output the results as *tidy data*. 
* **Tidy data** - written to `/output/tidy.csv` folder  