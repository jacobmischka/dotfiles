#!/bin/sh

if [[ -f ./.venv/bin/pylint ]]; then
	./.venv/bin/pylint "$@"
else
	/usr/bin/pylint "$@"
fi
