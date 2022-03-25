#! /usr/bin/env bash

set -Eeuo pipefail

sort-package-json &&
	npm install &&
	fd index.html -x rm {} &&
	echo "*** Cleared old generated HTML" &&
	npm run prettify-all &&
	fd index.md \
		--exec pandoc {} \
		-f markdown-auto_identifiers \
		-H '{//}'/desc.html \
		-H components/style-links.html \
		-B components/header.html \
		-A components/footer.html \
		-A components/script-link.html \
		-o '{.}'.html &&
	pandoc index-0.md \
		-f markdown-auto_identifiers \
		-H desc.html \
		-H components/style-links-main.html \
		-B components/header-main.html \
		-A components/script-link-main.html \
		-o index.html &&
	echo "*** Pandoc finished" &&
	npm run minify-html &&
	fd index.html --exec sd '<style>.*</style>' '' {} &&
	echo "*** sd round 1 finished" &&
	fd index.html --exec sd '<p class="auth.*</p></header>' '</header>' {} &&
	echo "*** sd round 2 finished" &&
	fd index.html --exec sd '<hr><ol>' '<ol>' {} &&
	echo "*** sd round 3 finished" &&
	fd index.html \
		--exec sd 'a href="http' \
		'a target="_blank" rel="noopener" href="http' {} &&
	echo "*** sd round 4 finished" &&
	npm run prettify-html &&
	npm run standardize-js
