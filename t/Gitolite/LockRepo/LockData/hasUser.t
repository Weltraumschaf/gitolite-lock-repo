#!/usr/bin/env perl

use strict;
use warnings;

use lib $ENV{GL_LIBDIR};

use Test::More;
use Gitolite::LockRepo::LockData;

my %myData = ();
is( hasUser(%myData), '', 'False for empty hash.');

%myData = setUser('user', %myData);
is( hasUser(%myData), 1, 'User set.');

done_testing();
