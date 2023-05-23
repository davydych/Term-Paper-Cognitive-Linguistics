# This file is based on a script used in a seminar by Prof. Dr. Jan Patrick Zeller, Universität Greifswald

setwd("~/Master/HA_Cognitive")

library(readr)
library(rvest)
library(tidyverse)
library(httr)
library(data.table)

httr::set_config(httr::user_agent("your@e.mail; Your Name; Student, University of Tromsø"))


# Uncomment the following 4 lines for the first sample (rus->ukr)
url_start <- "https://processing.ruscorpora.ru/search.xml?dpp=10&gramm1=V&lang=ru&lang_search=rus&level1=0&lex1=%D0%B4%D0%BE%2A&mode=para-ukr&mycorp=JSONeyJkb2NfaV9nZV9lbmRfeWVhciI6IFsiMTkwMCJdLCAiZG9jX2xhbmdfb3JpZyI6IFsicnVzc2lhbiJdfQ%3D%3D&p="
url_end <- "&parent1=0&sort=i_grstd&spd=10&spp=50&text=lexgramm"
dirname <- "rnc_archive_rus"
number_pages <- 7

# Uncomment the following 4 lines for the second sample (ukr->rus)
# url_start <- "https://processing.ruscorpora.ru/search.xml?dpp=10&gramm1=V&lang=ru&lang_search=ukr&level1=0&lex1=%D0%B4%D0%BE%2A&mode=para-ukr&mycorp=JSONeyJkb2NfaV9nZV9lbmRfeWVhciI6IFsiMTkwMCJdLCAiZG9jX2xhbmdfb3JpZyI6IFsiZm9yZWlnbiJdfQ%3D%3D&p="
# url_end <- "&parent1=0&sort=i_grstd&spd=10&spp=50&text=lexgramm"
# dirname <- "rnc_archive_ukr"
# number_pages <- 28


# Create directory "dirname" if it does not exist
if(!dir.exists(dirname)) dir.create(dirname)

# Loop over pages
for (i in 0:number_pages) {
    print(i)
    final_url <- paste0(url_start, i, url_end)
    Sys.sleep(15)

    # Parse html and write page to an html-file
    page <- read_html(final_url, encoding = "UTF-8")
    save_url <- paste0(dirname, "/rnc-search_", format(i, width = 2, flag = "0"), ".html")
    tmp <- page %>% as.character
    con <- file(save_url, open = "w", encoding = "native.enc")
    writeLines(tmp, con = con, useBytes = TRUE)
    close(con)

}

# Note: The resulting filenames contain spaces; these need to be removed
