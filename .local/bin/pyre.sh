#!/bin/sh

if [[ -f ./.venv/bin/pyre ]]; then
	./.venv/bin/pyre "$@"
else
	/usr/bin/pyre "$@"
fi
