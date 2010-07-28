smeagol
=======

[smeagol][smeagol] is this ugly dude who led some hobbits around, this is kinda the same thing.
Except, like, instead of hiking mordor you're trying to write some open source code on a mac.

FWIW it was easier to just write bash for this. :(

What it does
============

* Sets you up with [homebrew]
* Installs [git] from homebrew, sets up ~/.gitconfig
* Installs [postgresql], [mysql], [redis], and [mongodb]
* Installs [rvm] and sets up 1.8.7 to be the default, self manages on 1.9.2 as well
* Installs common ruby gems: rails 3, sinatra, fog, sqlite3, imagemagick, and all that bullshit
* Installs a pretty sane ~/.irbrc
* Installs a badass [node.js] development environment
* Installs a modern [python] environment
* Installs an [ewlang] environment
* Installs [MacVim] and the mvim shortcut

This is what I run on my system, [cider][cider] is a subset of that.

Running
=======

    % EDITOR="vim" \
      GITHUB_USER="fightclub" \
      GITHUB_TOKEN="..." \
      EMAIL="tyler@paperstreetsoap.com" \
      FULLNAME="Tyler Durden" \
      rake smeagol:install

[git]: http://git-scm.com/
[rvm]: http://rvm.beginrescueend.com
[cider]: http://ciderapp.org
[mysql]: http://www.mysql.com/
[redis]: http://code.google.com/p/redis/
[MacVim]: http://code.google.com/p/macvim/
[ewlang]: http://www.erlang.org/
[python]: http://www.python.org
[mongodb]: http://www.mongodb.org/
[node.js]: http://nodejs.org
[smeagol]: http://en.wikipedia.org/wiki/Gollum
[homebrew]: http://github.com/mxcl/homebrew
[postgresql]: http://www.postgresql.org/
