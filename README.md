smeagol
=======

[smeagol][smeagol] is this ugly dude who led some hobbits around.

This is an attempt by an ugly dude to lead open source hackers through their
initial bootstrapping of a machine.  I also wanted to play with chef a little more.

FWIW it was easier to just write bash for this. :(

What it does
============

* Sets you up with homebrew
* Installs git from homebrew, sets up ~/.gitconfig
* Installs postgresql, mongodb, and mysql
* Installs rvm and sets up 1.8.7 to be the default
* Installs both bundler08 and the bundler gems

These are the recipes that [cider][cider]
Running
=======

    % EDITOR="vim" EMAIL="me@mydomain.com" FULLNAME="Tyler Durden" rake smeagol:install

You may be prompted for your sudo password at some point during installation.  Everything is getting installed as your user though.

http://wiki.opscode.com/display/chef/Chef+Repository

[smeagol]: http://en.wikipedia.org/wiki/Gollum
[cider]: http://ciderapp.org
