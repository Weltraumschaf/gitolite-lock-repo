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
is( hasBranches(%myData), 0, 'Empty hash.');

$myData{KEY_BRANCHES} = ();
is( hasBranches(%myData), 0, 'Branches set empty.');

$myData{KEY_BRANCHES}{branchname} = ();
is( hasBranches(%myData), 1, 'Branche empty set.');

$myData{KEY_BRANCHES}{branchname}{KEY_MESSAGE} = 'message';
$myData{KEY_BRANCHES}{branchname}{KEY_TIME} = 42;
$myData{KEY_BRANCHES}{branchname}{KEY_USER} = 'user';
is( hasBranches(%myData), 1, 'Branche complete set.');

done_testing();