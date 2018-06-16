#!/bin/bash

# add local bin to path
export PATH=/usr/local/bin:$PATH

# if the terminal has stdin (eg. is interactive) and ~/.bashrc exists then load it
test -t 0 && [ -f ~/.bashrc ] && . ~/.bashrc
