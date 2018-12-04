export PATH=/usr/local/git/bin:/usr/local/bin/src:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:~/bin:$PATH

# ============
# Additional files to add to .bash_profile
source ~/dotfiles/bash/bash_aliases
source ~/dotfiles/bash/bash_config
source ~/dotfiles/bash/bash_rvm

if [ -f ~/dotfiles/bashrc ]; then
    . ~/dotfiles/bashrc
fi

# ============
# Setting PATH for EPD-6.1-1
# Don't copy this unless you use this library (in which case you should have it already)
# Note that the orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PATH

MKL_NUM_THREADS=1
export MKL_NUM_THREADS

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:/Users/justin.hilliard/gcloud/google-cloud-sdk/bin:$PATH"
eval "$(pyenv init -)"

function aws_switch_profile() {
    export AWS_DEFAULT_PROFILE=$1
    export AWS_PROFILE=$1
    echo "Switching to profile $1"
}
