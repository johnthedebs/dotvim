Installation
============

To install this vim configuration to a new machine:

    # Clone the git repository
    git clone git://github.com/johnthedebs/dotvim.git ~/.vim
    # Link the .editorconfig and .ctags files
    ln -s ~/.vim/editorconfig ~/.editorconfig
    ln -s ~/.vim/ctags ~/.ctags

    # Install dependencies
    brew install bat black ctags fd fzf par ripgrep

    # via asdf, nvm, brew, whatever:
    # node@22
    # python@3.13 

    # From within vim, to install plugins:
    :PlugInstall
    # To update plugins:
    :PlugUpdate
    # To remove plugins:
    :PlugClean

    # To update Coc extensions
    :CocUpdate
    # To remove one, delete from vimrc then:
    :CocUninstall <extension>

    # To Update plugins & coc extensions at the same time
    :Update


For tailwindcss w/ full twin.macro support:
https://github.com/iamcco/coc-tailwindcss/issues/34#issuecomment-703253001

I recommend getting the latest release of MacVim here:
https://github.com/macvim-dev/macvim/releases


Vim Resources
=============

* Cheat sheet: https://www.fprintf.net/vimCheatSheet.html
* Plugin directory: https://vimawesome.com/


Thanks to
=========

* Drew Neil – http://vimcasts.org
* Steve Losh – http://stevelosh.com/blog/2010/09/coming-home-to-vim/
* Jim Dennis – http://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim/1220118#1220118
* Alex Hunt - https://medium.com/@huntie/10-essential-vim-plugins-for-2018-39957190b7a9
* r/vim - https://www.reddit.com/r/vim/
