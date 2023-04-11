#!/usr/bin/env bash

echo `tmux select-window -t -T ; xrun -v | rg TOOL | cut -d ":" -f 2`
