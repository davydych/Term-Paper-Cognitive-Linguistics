# Term-Paper-Cognitive-Linguistics
Scripts and data for my termpaper in RUS-3030 at University of Tromsø, Spring 2023

This repository contains scripts and data used for my termpaper with the title "The verbal prefix *do-* in Russian and Ukrainian". For my corpus lingustics approach, I used data from the Ukrainian parallel corpus of the Russian National Corpus (www.ruscorpora.ru). Though this corpus allows to save search results as a file, at the time of writing this functionality did not work properly. Therefore, I extracted the results with three scripts.

The script "rnc-scraper.R" saves every html-page of my search results. Although the results are retrievable through a weblink, the results might differ if you repeat the search as the corpus might have changed in the meanwhile.

The bash script "html-extract.sh" extracts the relevant information from the html files and stores it in a "complete.xml" file. Note that bash (Bourne Agaian Shell) is mainly used on Linux. MacOS uses zsh (Z Shell), which is similar but the script has not been developed or tested for compatibility with zsh.

"html-to-csv.R" converts the information in "complete.xml" to a csv file which can be opened in a spreadsheet programm like Microsoft Excel or LibreOffice Calc.

As the results might not be reproducible in the future, I added two folders with the data I retrieved.

The folder "rnc-archive-rus" contains the data for the first sample of my study. The search was conducted in a subcorpus containing only Russian source texts and their translations. 
The search parameters were the following: verbs beginning with *do-*, search in Russian texts only. 

The folder "rnc-archive-ukr" contains the date for the second sample. The search was conducted in a subcorpus containing only Ukrainian source texts and their translations.
The search parameters were the following: verbs beginning with *do-*, search in Ukrainian texts only.

Both folders contain:
- all html-pages with the search results (retrieved through the "rnc-scraper.R" script)
- an extracted version of each page with the file ending ".extracted" (created by the "html-extract.sh" script)
- a "complete.xml" file with the content of all *extracted* files (created by the "html-extract.sh" script)
- a csv-file with all the results (created by the "html-to-csv.R" script)

Furthermore, both folders contain a .ods-file (file format used by LibreOffice Calc). It is based on the csv-file in the respective folder and contains the samples themselves.
The methodology is described in my term paper.
