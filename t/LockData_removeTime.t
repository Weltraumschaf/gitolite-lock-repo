#!/usr/bin/perl

use strict;
use warnings;

use FindBin qw( $RealBin );
BEGIN { $ENV{LOCKREPO_LIBDIR} = "${RealBin}/../src/lib"; }
use lib $ENV{GL_LIBDIR};
use lib $ENV{LOCKREPO_LIBDIR};

use Test::More;
use Gitolite::LockRepo::LockData;

my %myData = setTime(42, ());
is( hasTime(%myData), 1, 'Time set.');

%myData = removeTime(%myData);
is( hasTime(%myData), 0, 'Time removed.');

done_testing();