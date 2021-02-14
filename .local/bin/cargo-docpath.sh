#!/bin/bash

PATH="$(pwd)/target/doc/settings.html"

if [[ -f "$PATH" ]]; then
	echo "file://${PATH}"
else
	echo "Docs do not exist, run \`cargo doc\`"
fi

