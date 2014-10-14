#!/usr/bin/perl

use strict;
use warnings;

use lib $ENV{GL_LIBDIR};

use Test::More;
use Gitolite::LockRepo::LockData;

my %myData = ();
is( hasTime(%myData), 0, 'Empty hash.');

%myData = setTime(1234, %myData);
is( hasTime(%myData), 1, 'Time set.');

done_testing();
