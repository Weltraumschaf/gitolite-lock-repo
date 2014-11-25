#!/usr/bin/env perl

use strict;
use warnings;

use lib $ENV{GL_LIBDIR};

use Test::More;
use Gitolite::LockRepo::LockData;

my %myData = ();
is( getTime(%myData), 0, 'Zero expected for empty hash.');

%myData = setTime(42, %myData);
is( getTime(%myData), 42, 'Time expected.');

done_testing();
