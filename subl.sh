#!/bin/bash
set -e

cp -R ./subl/ "${HOME}/Library/Application Support/Sublime Text/"
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ~/.bin/subl
