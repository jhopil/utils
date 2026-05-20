#!/bin/bash

# tmux new -s esba
# tmux kill-session -t esba
# tmux ls
#
# session detach: ctrl + b d
# pane
#   vertical  : ctrl + b %
#   horizon   : ctrl + b "
#   print     : ctrl + b q
#   erase all : ctrl + b !
#   erase one : ctrl + b x
#   erase     : ctrl + d (=exit)
#   index move: ctrl + b '
#   move key  : ctrl + b <key>
#   command   : ctrl + b :
#   help      : ctrl + b ?
#   scroll    : ctrl + b [

tmux attach -t esba
