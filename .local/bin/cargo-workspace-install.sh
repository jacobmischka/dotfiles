#!/bin/bash

if [[ "$1" = "workspace-install" ]]; then
	BIN="$2"
else
	BIN="$1"
fi

if [[ -z "$BIN" ]]; then
	echo "Specify a bin as a single argument"
	exit 1
fi

cargo build --release --bin "$BIN" && cp "target/release/$BIN" "$HOME/.cargo/bin/" && echo "$BIN installed to ~/.cargo/bin/"
