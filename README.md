smeagol
=======

[smeagol][smeagol] is this ugly dude who led some hobbits around, this is kinda the same thing.  Except, like, instead of hiking mordor you're trying to write some open source code on a mac.

FWIW it was easier to just write bash for this at first.  Over time I've enjoyed maintaining this with chef more than I think I would've enjoyed straight up shell.

What it does
============

* Sets you up with [homebrew]
* Installs [git] from homebrew, sets up ~/.gitconfig
* Installs [postgresql], [mysql], [redis], [memcached] and [mongodb].  They're all configured to run when you login.
* Installs [rvm] and sets up 1.8.7 to be the default, self manages on 1.9.2 as well
* Installs common ruby gems: rails 3, sinatra, fog, sqlite3, imagemagick, and all that bullshit
* Installs a pretty sane ~/.irbrc
* Installs a [node.js] development environment with [npm]
* Installs a modern [python] environment with [pip]
* Installs an [erlang] environment
* Installs [MacVim] and sets up [janus]

This is what I run on my system, [cinderella][cinderella] is a subset of that.

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
[npm]: http://npmjs.org/
[pip]: http://pypi.python.org/pypi/pip
[mysql]: http://www.mysql.com/
[redis]: http://code.google.com/p/redis/
[janus]: http://github.com/carlhuda/janus
[MacVim]: http://code.google.com/p/macvim/
[erlang]: http://www.erlang.org/
[python]: http://www.python.org
[mongodb]: http://www.mongodb.org/
[node.js]: http://nodejs.org
[smeagol]: http://en.wikipedia.org/wiki/Gollum
[homebrew]: http://github.com/mxcl/homebrew
[memcached]: http://memcached.org/
[cinderella]: http://ciderapp.org
[postgresql]: http://www.postgresql.org/
