Installation
============

To install this vim configuration to a new machine:

    # Clone the git repository and submodules
    git clone --recurse-submodules -j8 git://github.com/johnthedebs/dotvim.git ~/.vim
    # Link in the .vimrc file
    ln -s ~/.vim/vimrc ~/.vimrc
    # Link in the .ackrc file
    ln -s ~/.vim/ackrc ~/.ackrc

    brew install ack par

As for MacVim itself, I recommend you get the latest snapshot from here (go for the .tbz file):
https://github.com/macvim-dev/macvim/releases

To update all the submodules to their latest versions:

    # Update each submodule
    git submodule foreach git pull

    # To add a submodule
    git submodule add https://<package_url>.git bundle/<package_name>


Thanks to
=========

* Drew Neil – http://vimcasts.org
* Steve Losh – http://stevelosh.com/blog/2010/09/coming-home-to-vim/
* Jim Dennis – http://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim/1220118#1220118
