# gitolite-lock-repo

Command to lock repo at [Gitolite][gitolite] via SSH command.
For detailed information see the [command documentation][doc].

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

## Testing

To ru nthe unit tests it is necessary to define an environment varibale where
the Gitolite lib is found:

    $> export GL_LIBDIR=/some/where/gitolite/src/lib

After that invoke [prove(1)][prove] in the project's base directory:

    $> prove

Or for convenience invoke the script `./test` (after changing the `GL_LIBDIR`).

[gitolite]: http://gitolite.com/gitolite/index.html
[doc]:      https://raw.githubusercontent.com/Weltraumschaf/gitolite-lock-repo/master/commands/lock-repo
[prove]:    http://linux.die.net/man/1/prove
