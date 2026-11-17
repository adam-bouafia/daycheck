#!/usr/bin/env bash
# Renders every screen in light and dark mode and stores them as WebP in
# docs/img/screens/<light|dark>/. Needs ImageMagick.
set -euo pipefail
cd "$(dirname "$0")/../.."

flutter test tool/screenshots/screenshots_test.dart --update-goldens
for png in docs/img/screens/*/*.png; do
  magick "$png" -resize 540x -quality 82 "${png%.png}.webp"
  rm "$png"
done
du -sh docs/img/screens
