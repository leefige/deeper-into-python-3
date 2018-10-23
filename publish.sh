#!/bin/bash

Markdown=./Markdown
Notebook=./Notebook
HTML=./pages
Tex=./Tex
PDF=./PDF
Slides=./Slides

dests=($Markdown $HTML $Tex $PDF $Slides)

if [ $1 == "clear" ]; then
    echo "Clearing..."
    if [ -e index.html ]; then
        rm index.html
    fi
    for de in ${dests[@]}; do
        if [ -d $de ]; then
            rm -r $de
        fi
    done
    exit 0
fi

echo "Checking dirs..."
for de in ${dests[@]}; do
    if [ ! -d $de ]; then
        mkdir $de
    fi
done

# Generate the Slides and Pages
jupyter-nbconvert $Notebook/Index.ipynb --reveal-prefix=reveal.js
mv $Notebook/Index.html  index.html

cd Notebook
arr=(*.ipynb)
cd ..
for f in "${arr[@]}"; do
    # Chop off the extension
    filename=$(basename "$f")
    extension="${filename##*.}"
    filename="${filename%.*}"

    # Convert the Notebooks to HTML
    jupyter-nbconvert --to html $Notebook/"$filename".ipynb
    # Move to the HTML directory
    mv $Notebook/"$filename".html  $HTML/"$filename".html

    if [ $1 == "all" ]; then

        # Convert the Notebooks to slides
        jupyter-nbconvert --to slides $Notebook/"$filename".ipynb --reveal-prefix=reveal.js
        # Move to the Slides directory
        mv $Notebook/"$filename".slides.html  $Slides/"$filename".html

        # # Convert the Notebooks to Markdown
        # jupyter-nbconvert --to markdown $Notebook/"$filename".ipynb
        # # Move to the Markdown directory
        # mv $Notebook/"$filename".md  $Markdown/"$filename".md

        # # Convert the Notebooks to Latex
        # jupyter-nbconvert --to latex $Notebook/"$filename".ipynb
        # # Move to the Tex directory
        # mv $Notebook/"$filename".tex  $Tex/"$filename".tex

        # Convert the Notebooks to PDF
        cp $Notebook/"$filename".ipynb src/"$filename".ipynb
        cd src
        jupyter-nbconvert --to pdf "$filename".ipynb
        # Move to the html directory
        mv "$filename".pdf  ../$PDF/"$filename".pdf
        rm "$filename".ipynb
        cd ..
    fi
done

rm $HTML/Index.html

echo "All notebooks converted!"
