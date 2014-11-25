#!/usr/bin/env perl

use strict;
use warnings;

use lib $ENV{GL_LIBDIR};

use Test::More;
use Gitolite::LockRepo::LockData;

my %myData = ();
is( getUser(%myData), '', 'Empty string expected for empty hash.');

%myData = setUser('user', %myData);
is( getUser(%myData), 'user', 'User expected.');

done_testing();
