#!/bin/sh
# Dependency-free static export for Vercel. Only the public site is copied.
set -eu
cd "$(dirname "$0")/.."
mkdir -p dist/assets
for file in index.html style.css app.js content.js questions.js; do
  cp "$file" "dist/$file"
done
cp -R assets/. dist/assets/
printf 'Canada Joloo: static site exported to dist/\n'
