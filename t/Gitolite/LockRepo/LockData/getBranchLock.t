#!/usr/bin/env perl

use strict;
use warnings;

use lib $ENV{GL_LIBDIR};

use Test::More;
use Gitolite::LockRepo::LockData;

my %myData = ();
is( getBranchLock('branchname', %myData), (), 'Empty result expected.');

$myData{KEY_BRANCHES}{branchname}{KEY_USER} = 'user';
$myData{KEY_BRANCHES}{branchname}{KEY_TIME} = 42;
$myData{KEY_BRANCHES}{branchname}{KEY_MESSAGE} = 'message';
my %expectedData = (
    KEY_USER    => 'user',
    KEY_TIME    => 42,
    KEY_MESSAGE => 'message'
);

is( getBranchLock('branchname', %myData), %expectedData, 'Given result expected.' );

done_testing();
