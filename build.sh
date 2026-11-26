#!/usr/bin/env bash
# Wraps src/app.html in a full HTML document and writes docs/index.html.
# No dependencies, no npm. Run:  bash build.sh
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p docs
{
  printf '<!doctype html>\n<html lang="en" data-theme="light">\n<head>\n<meta charset="utf-8">\n'
  printf '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
  printf '<link rel="icon" href="data:image/svg+xml,%%3Csvg xmlns=%%22http://www.w3.org/2000/svg%%22 viewBox=%%220 0 38 38%%22%%3E%%3Crect width=%%2238%%22 height=%%2238%%22 rx=%%2210%%22 fill=%%22%%23E4572E%%22/%%3E%%3Ctext x=%%2219%%22 y=%%2225%%22 font-size=%%2213%%22 font-family=%%22monospace%%22 font-weight=%%22700%%22 fill=%%22%%23FFFFFF%%22 text-anchor=%%22middle%%22%%3ERE%%3C/text%%3E%%3C/svg%%3E">
' 
  cat src/app.html
  printf '\n</html>\n'
} > docs/index.html
echo "Built docs/index.html ($(wc -c < docs/index.html | tr -d ' ') bytes)"
