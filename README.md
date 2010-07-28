smeagol
=======

[smeagol][smeagol] is this ugly dude who led some hobbits around, this is kinda the same thing.
Except, like, instead of hiking mordor you're trying to write some open source code on a mac.

FWIW it was easier to just write bash for this. :(

What it does
============

* Sets you up with homebrew
* Installs git from homebrew, sets up ~/.gitconfig
* Installs postgresql, mysql, redis, and mongodb
* Installs rvm and sets up 1.8.7 to be the default, self manages on 1.9.2 as well
* Installs common ruby frameworks, imagemagick, sqlite3 and all that bullshit
* Installs a pretty sane ~/.irbrc
* Installs a badass node.js development environment
* Installs a modern python environment
* Installs MacVim and the mvim shortcut

This is what I run on my system, [cider][cider] is a subset of that.

Running
=======

  % EDITOR="vim" GITHUB_USER="fightclub" GITHUB_TOKEN="..." EMAIL="tyler@paperstreetsoap.com" FULLNAME="Tyler Durden" rake smeagol:install

You may be prompted for your sudo password at some point during installation.  Everything is getting installed as your user though.

http://wiki.opscode.com/display/chef/Chef+Repository

[smeagol]: http://en.wikipedia.org/wiki/Gollum
[cider]: http://ciderapp.org

