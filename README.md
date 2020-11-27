Installation
============

To install this vim configuration to a new machine:

    # Clone the git repository
    git clone git://github.com/johnthedebs/dotvim.git ~/.vim
    # Link in the .vimrc file
    ln -s ~/.vim/vimrc ~/.vimrc
    # Link in the .agrc file
    ln -s ~/.vim/agrc ~/.agrc

    # Install dependencies
    brew install ag fd fzf par

    # From within vim, to install or update plugins:
    :PlugInstall

As for MacVim itself, I recommend you get the latest snapshot from here (go for the .tbz file):
https://github.com/macvim-dev/macvim/releases


Thanks to
=========

* Drew Neil – http://vimcasts.org
* Steve Losh – http://stevelosh.com/blog/2010/09/coming-home-to-vim/
* Jim Dennis – http://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim/1220118#1220118
