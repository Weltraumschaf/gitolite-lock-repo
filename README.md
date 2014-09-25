# gitolite-lock-repo

Command to lock repo at [Gitolite][gitolite] via SSH command.

## Installation

Clone this repo into your site local location:

    $> git clone git@github.com:Weltraumschaf/gitolite-lock-repo.git local

Add this location to your `.gitolite.rc`:

    # this one is managed directly on the server
    LOCAL_CODE  =>  "$ENV{HOME}/local",

And then add the push hook to the `conf/gitolite.conf`:

    repo @all
        -   VREF/lock-repo  =   @all

The example above activates the hook for all repos for everyone.

[gitolite]: http://gitolite.com/gitolite/index.html
