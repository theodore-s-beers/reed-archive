# Build process

1. Pandoc all `index.md` files, except the one in the top directory, to `index.html`. We disable Markdown auto identifiers; specify two spaces per tab; add the meta description and CSS link to the head; then the header and footer; and finally the link to the theme selector script.

2. Pandoc `index.md` in the top directory to `index.html`. The difference here is that we have a slightly different header and omit the footer, and the paths change for the description and the CSS and JS links.

3. In the generated HTML files, add `target="_blank"` and `rel="noopener"` to all links to external sites.

4. Minify all HTML, excluding component files. (For some reason, this prevents errors in the subsequent encoding step.)

5. Encode special characters as HTML entities in the generated `index.html` files.

6. For good measure, minify all HTML again, excluding component files.

7. Run all HTML through Prettier.
