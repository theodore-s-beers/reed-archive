#! /usr/local/bin/bash

find . -name "index.md" ! -path "./index.md" \
-execdir pandoc index.md \
-f markdown-auto_identifiers \
-H desc.html \
-H ../components/style-links.html \
-B ../components/header.html \
-A ../components/footer.html \
-A ../components/script-link.html \
-o index.html \; &&

pandoc index.md \
-f markdown-auto_identifiers \
-H desc.html \
-H components/style-links-main.html \
-B components/header-main.html \
-A components/script-link-main.html \
-o index.html &&

echo "Pandoc finished" &&

npx sort-package-json &&

npm install &&

npm run minify &&

find . -name "index.html" \
-exec sed -i '' 's/<style>.*<\/style>//' {} \; &&

echo "sed round 1 finished" &&

find . -name "index.html" \
-exec sed -i '' \
's/<p class="auth.*<\/p><\/header>/<\/header>/' \
{} \; &&

echo "sed round 2 finished" &&

find . -name "index.html" \
-exec sed -i '' \
's/a href="http/a target="_blank" rel="noopener" href="http/g' \
{} \; &&

echo "sed round 3 finished" &&

npm run prettify &&

npm run standardize
