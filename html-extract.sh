# Note: Files with the numbers 0 to 9 have to be renamed to 00-09

# Directory containing the html files
archive_dir="/.../"

# Remove files from previous runs
rm $archive_dir/*.html.extracted

# Loop over html files in this directory
for file in $archive_dir/*.html; do

    # Get line numbers of lines containing "trim_up.html end"
    # Store line numbers in tmp.txt
    sed -n '/trim_up.html end/=' $file > tmp.txt

    # Read tmp.txt line by line
    while read line; do

        # Precede extracted content with <entry>
        echo "<entry>" >> $file.extracted

        # Extracted relevant content
        sed -n $line,`expr $line + 3`p $file >> $file.extracted

        # Add </entry> after extracted content
        echo "</entry>" >> $file.extracted
    done < tmp.txt
done

# Create file that will contain all the extracted content
touch complete.xml
# Add XML prolog and "<results>"
echo '<?xml version="1.0" encoding="UTF-8"?>' > complete.xml
echo '<results>' >> complete.xml

# Loop over files and add their content to complete.xml
for file in $archive_dir/rnc-search*.html.extracted; do
    cat $file >> complete.xml
done

echo '</results>' >> complete.xml
