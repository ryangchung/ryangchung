#!/bin/sh

DOOMDIR="$HOME/.emacs.d"
DOOMBIN="$DOOMDIR/bin/doom"

set -eu

if [ -x "$DOOMBIN" ]; then
  echo "Doom Emacs already installed at $DOOMDIR"
else
  echo "Installing Doom Emacs..."
  git clone --depth 1 https://github.com/doomemacs/doomemacs "$DOOMDIR"
  "$DOOMBIN" install
fi

"$DOOMBIN" sync
