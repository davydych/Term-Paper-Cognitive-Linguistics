library(XML)
library(tidyverse)

# Uncomment one of these lines
setwd("/PATH/TO/rnc_archive_rus")
#setwd("/PATH/TO/rnc_archive_ukr/")

# Parse file with extracted contents
rnc_results <- xmlParse("complete.xml")

number_nodes <- xmlSize(xmlRoot(rnc_results))

# Nodeset containing all entries
entry_nodeset <- getNodeSet(rnc_results, '/results/entry')

# Add column names to new data frame
df <- data.frame(lang=character(), left_context=character(), center=character(), right_context=character(), title=character(), stringsAsFactors=FALSE)


# Function for retrieving left context, center, and right context
concat_from_nodes <- function(nodes) {
  
  # Variable that determines whether the context comes before or after the match
  context <- "l"
  # Number of nodes
  n <- length(nodes)

  left_context <- ""
  center <- ""
  right_context <- ""

  # Loop over nodes
  for (i in 1:n) {

    # Each word is a text inside a <span> element with different "classes" as attributes
    # Get class of current entry
    span_class <- xmlGetAttr(nodes[[i]], name = 'class')

    # Words in the left context have these attributes
    # Add them to left_context string
    if (span_class == "b-wrd-expl" && context == "l") {
      left_context <- paste(left_context, xmlValue(nodes[[i]]), sep=" ")
    }
    
    # The center (= match) has this attribute; add to center variable
    # Entries after center will be from the right context -> change context variable
    else if (span_class == "b-wrd-expl g-em") {
      center <- xmlValue(nodes[[i]])
      context <- "r"
    }
    
    # Add words from right context to the respective variable
    else if (span_class == "b-wrd-expl" && context == "r") {
        right_context <- paste(right_context, xmlValue(nodes[[i]]))
    }

  }
  
  return (list(left_context, center, right_context))

}


# Loop over nodes to extract relevant content
for (i in 1:number_nodes) {
  entry <- entry_nodeset[[i]]
    
  # Get left context, center, and right context
  text_nodeset <- getNodeSet(entry, './/span[starts-with(@class, "b-wrd-expl")]')
  text_complete <- concat_from_nodes(text_nodeset)
  # Text was retrieved as a list; assign its contents to variables
  left_context <- text_complete[[1]]
  center <- text_complete[[2]]
  right_context <- text_complete[[3]]

  # Get this entry's language
  lang <- xpathSApply(entry, './/descendant::span[1]', function(x) xmlGetAttr(x, name = "l"))

  # Get information on source (Author, Title, Year)
  title <- xpathSApply(entry, './/span[@class="doc"]', xmlValue)

  # Add current entry to data frame
  df[nrow(df) + 1,] <- c(lang, left_context, center, right_context, title)
}


write.table(df, "test_rus.csv", sep="\t")

