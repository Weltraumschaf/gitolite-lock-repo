#!/usr/bin/perl

use strict;
use warnings;

use FindBin qw( $RealBin );
BEGIN { $ENV{LOCKREPO_LIBDIR} = "${RealBin}/../src/lib"; }
use lib $ENV{GL_LIBDIR};
use lib $ENV{LOCKREPO_LIBDIR};

use Test::More;
use Gitolite::LockRepo::LockData;

my %myData = ();
is( getTime(%myData), 0, 'Empty hash.');

%myData = setTime(42, %myData);
is( getTime(%myData), 42, 'Time set.');

done_testing();