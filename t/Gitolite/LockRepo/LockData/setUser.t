#!/usr/bin/env perl

use strict;
use warnings;

use lib $ENV{GL_LIBDIR};

use Test::More;
use Gitolite::LockRepo::LockData;

my %myData = ();
is( getUser(%myData), '', 'Empty hash.');

%myData = setUser('user', %myData);
is( getUser(%myData), 'user', 'User set.');

done_testing();
