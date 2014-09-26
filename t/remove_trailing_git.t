#!/usr/bin/perl

use strict;
use warnings;

use FindBin qw( $RealBin );
BEGIN { $ENV{LOCKREPO_LIBDIR} = "${RealBin}/../src/lib"; }
use lib $ENV{GL_LIBDIR};
use lib $ENV{LOCKREPO_LIBDIR};

use Test::More;
use Gitolite::LockRepo;

is( remove_trailing_git(''), '', 'Empty should return empty.');
is( remove_trailing_git('foobar'), 'foobar', 'No .git should return whole string.');
is( remove_trailing_git('foobar.git'), 'foobar', '.git should be removed.');

done_testing();
