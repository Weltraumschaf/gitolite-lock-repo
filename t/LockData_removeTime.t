#!/usr/bin/perl

use strict;
use warnings;

use lib $ENV{GL_LIBDIR};

use Test::More;
use Gitolite::LockRepo::LockData;

my %myData = setTime(42, ());
is( hasTime(%myData), 1, 'Time set.');

%myData = removeTime(%myData);
is( hasTime(%myData), 0, 'Time removed.');

done_testing();
