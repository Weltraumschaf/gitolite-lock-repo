#!/usr/bin/env perl

use strict;
use warnings;

use lib $ENV{GL_LIBDIR};

use Test::More;
use Gitolite::LockRepo::LockData;

is( getBranchLock(undef, ()), (), 'Empty result expected for undef branchname and undef data.');

is( getBranchLock('branchname', undef), (), 'Empty result expected for undef data.');

is( getBranchLock('branchname', {}), (), 'Empty result expected for empty data.');

my $expectedData = {
    KEY_USER => 'user',
    KEY_TIME => 42,
    KEY_MESSAGE => 'message'
};

is(
    getBranchLock('branchname', {
        KEY_BRANCHES => {
            branchname => $expectedData
        }
    }),
    $expectedData,
    'Given result expected for existing branch name.' );

is(
    getBranchLock('foobar', {
        KEY_BRANCHES => {
            branchname => $expectedData
        }
    }),
    (),
    'Empty result expected for wrong branch name.' );

is(
    getBranchLock(undef, {
        KEY_BRANCHES => {
            branchname => $expectedData
        }
    }),
    (),
    'Empty result expected for undef branch name.' );

done_testing();
