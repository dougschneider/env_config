export PATH=/spgear/spgear/bin:/spgear/tools/bin:/opt/rational/clearcase/bin:/bin:/usr/bin

export PYTHONPATH=~/git/chimera/yycli/:~/git/chimera/yycli/commonPythonLibrary/

export PATH=$PATH:~/jython2.5.2/:/msg/spgear/bin:/msg/spgear/tools/bin:/bin:/usr/bin:/usr/local/bin:/home/runner/bin:$HOME/.gem/ruby/1.8/bin/:/usr/local/autotest/cli/

export PYTHONPATH=.:$PYTHONPATH:/usr/local/lib/python2.6/dist-packages/:/usr/lib/pymodules/python2.6/
alias ack="ack-grep"

# enable full colors in the terminal
export TERM="xterm-256color"

alias cleanup="find . -name "*.swp" | xargs rm && find . -name "*.swo" | xargs rm"

# make the prompt small
export PS1="\w "

alias ls="ls --color"

function uva {
    g++ -lm -lcrypt -O2 -std=c++0x -pipe -DONLINE_JUDGE UVA$1.C                   
}
