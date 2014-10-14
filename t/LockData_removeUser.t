#!/usr/bin/perl

use strict;
use warnings;

use lib $ENV{GL_LIBDIR};

use Test::More;
use Gitolite::LockRepo::LockData;

my %myData = setUser('user', ());
is( hasUser(%myData), 1, 'User set.');

%myData = removeUser(%myData);
is( hasUser(%myData), 0, 'User removed.');

done_testing();
