#! /usr/local/bin/bash

find . -name "index.md" ! -path "./index.md" \
-execdir pandoc index.md \
-f markdown-auto_identifiers \
--tab-stop=2 \
-H desc.html \
-H ../components/style-links.html \
-B ../components/header.html \
-A ../components/footer.html \
-A ../components/script-link.html \
-o index.html \; && 

pandoc index.md \
-f markdown-auto_identifiers \
--tab-stop=2 \
-H desc.html \
-H components/style-links-main.html \
-B components/header-main.html \
-A components/script-link-main.html \
-o index.html &&

find . -name "index.html" \
-exec sed -i '' \
's/a href="http/a target="_blank" rel="noopener" href="http/g' \
{} \; &&

find . -name "*.html" ! -path "./components/*" \
-exec html-minifier {} \
--collapse-whitespace \
--minify-css true \
-o {} \; &&

for i in $(find . -name "index.html");
do he --encode --allow-unsafe < "$i" > "$i".out;
done &&

find . -name "index.html.out" \
-execdir mv index.html.out index.html \; &&

find . -name "*.html" ! -path "./components/*" \
-exec html-minifier {} \
--collapse-whitespace \
--minify-css true \
-o {} \; &&

find . -name "*.html" \
-exec prettier --write {} \;
