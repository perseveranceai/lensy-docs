#!/bin/zsh
# Build the static site into dist/.
#   ./build.sh [base-path] [site-origin]
# Each page gets its own folder with a copy of the docsify shell, so GitHub Pages
# serves deep links with a 200, and each shell carries that page's own metadata
# and declares its markdown twin.
set -e
cd "${0:A:h}"
BASE="${1:-/lensy-docs/}"
ORIGIN="${2:-https://perseveranceai.github.io}"
SITE="$ORIGIN$BASE"
TODAY=$(date +%Y-%m-%d)

# slug|title|description  (slug "" is the home page, backed by README.md)
PAGES=(
  "|Lensy Docs|Learn how to use Lensy to check whether AI tools can find, read, and cite your developer documentation."
  "quickstart|Quickstart|Run your first Lensy audit on a docs page and download the report."
  "reading-your-report|Reading your report|What each part of a Lensy report means: readiness score, signals, fixes, AI bot access, and AI citations."
  "fix-with-your-coding-agent|Fix it with your coding agent|Download the Markdown report and let Claude Code, Cursor, or Copilot work through the fixes in your docs repo."
  "faq|FAQ|Answers to common questions about Lensy: pricing, rejected pages, crawlers, and accuracy."
)

rm -rf dist && mkdir -p dist
cp src/logo.png dist/
for f in src/*.md; do sed "s#](/#]($BASE#g" "$f" > "dist/${f:t}"; done
touch dist/.nojekyll

head_block() { # $1 slug, $2 title, $3 description
  local url="$SITE$1" md="$BASE${1:-README}.md" full="$2" crumb=""
  if [[ -n $1 ]]; then
    full="$2 - Lensy Docs"
    crumb=",{\"@type\":\"ListItem\",\"position\":2,\"name\":\"$2\",\"item\":\"$url\"}"
  fi
  cat <<EOF
<title>$full</title>
  <meta name="description" content="$3">
  <link rel="canonical" href="$url">
  <link rel="alternate" type="text/markdown" href="$md">
  <meta property="og:type" content="article">
  <meta property="og:site_name" content="Lensy Docs">
  <meta property="og:title" content="$full">
  <meta property="og:description" content="$3">
  <meta property="og:url" content="$url">
  <meta property="og:image" content="${SITE}logo.png">
  <meta name="twitter:card" content="summary">
  <meta name="twitter:site" content="@getperseverance">
  <script type="application/ld+json">
  {"@context":"https://schema.org","@graph":[
    {"@type":"TechArticle","headline":"$2","description":"$3","url":"$url","dateModified":"$TODAY","inLanguage":"en","publisher":{"@type":"Organization","name":"Perseverance AI","url":"https://perseveranceai.com","logo":"${SITE}logo.png"}},
    {"@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"name":"Lensy Docs","item":"$SITE"}$crumb]}
  ]}
  </script>
EOF
}

render() { # $1 slug, $2 title, $3 description
  local headfile=$(mktemp)
  head_block "$1" "$2" "$3" > "$headfile"
  sed "s#__BASE__#$BASE#g" src/index.html |
    perl -pe 'BEGIN { open F, "<", shift @ARGV; local $/; $h = <F>; chomp $h } s/__HEAD__/$h/' "$headfile"
  rm -f "$headfile"
}

sitemap=()
for entry in "${PAGES[@]}"; do
  IFS='|' read -r slug title desc <<< "$entry"
  if [[ -z $slug ]]; then
    render "" "$title" "$desc" > dist/index.html
    render "" "$title" "$desc" > dist/404.html
  else
    mkdir -p dist/$slug
    render "$slug" "$title" "$desc" > dist/$slug/index.html
    cp dist/$slug.md dist/$slug/README.md   # docsify loads <route>/README.md for trailing-slash URLs
    cp dist/_sidebar.md dist/$slug/_sidebar.md
  fi
  sitemap+=("  <url><loc>$SITE$slug</loc><lastmod>$TODAY</lastmod></url>")
done

{ echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
  printf '%s\n' "${sitemap[@]}"
  echo '</urlset>'; } > dist/sitemap.xml

{ echo "# Lensy Docs"
  echo
  echo "> How to use Lensy, the AI readiness checker for developer docs by Perseverance AI."
  echo
  echo "## Docs"
  echo
  for entry in "${PAGES[@]}"; do
    IFS='|' read -r slug title desc <<< "$entry"
    echo "- [$title]($SITE${slug:-README}.md): $desc"
  done; } > dist/llms.txt

printf 'User-agent: *\nAllow: /\n\nSitemap: %ssitemap.xml\n' "$SITE" > dist/robots.txt
echo "built dist/ for $SITE"
