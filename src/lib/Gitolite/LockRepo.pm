package Gitolite::LockRepo;

# Common functions for lock-repo command and update hook.
# -------------------------------------------------------

#<<<
@EXPORT = qw(
  foo
);
#>>>
use Exporter 'import';

use strict;
use warnings;

# ----------------------------------------------------------------------


sub foo {
    return 'foo';
}

1;
