#!/bin/bash

rm 00*.md

for f in ../assets/Graphics_v3.3/*.png; do  
	f=`basename $f`
	image_filename=$f
	date=`echo $f | sed 's/_.*//' | sed 's/-.*//' | sed 's/Page//' | sed 's/^/00/' | sed 's/$/-01-01/'`
	page_numbers=`echo $f | sed 's/_.*//' | sed 's/Page//'`
	title_no_spaces=`echo $f | sed 's/.*_//' | sed 's/.png//'`
	title_with_spaces=`echo $title_no_spaces | sed 's/-/ /g'`
	title_with_spaces_and_pages="Page ${page_numbers} (${title_with_spaces})"

	markdown_filename="${date}-${title_no_spaces}.md"
	cat template_page.md \
		| sed "s/TITLE/${title_with_spaces_and_pages}/g" \
		| sed "s/DATE/${date}/g" \
		| sed "s/IMAGE_FILENAME/${image_filename}/g" \
		> ${markdown_filename}
done

# Make the front cover the index.md page
cat 0001-01-01-Front-Cover.md | sed 's/post/home/g' > ../index.md
rm 0001-01-01-Front-Cover.md
