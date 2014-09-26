#!/usr/bin/perl

use strict;
use warnings;

use FindBin qw( $RealBin );
BEGIN { $ENV{LOCKREPO_LIBDIR} = "${RealBin}/../src/lib"; }
use lib $ENV{GL_LIBDIR};
use lib $ENV{LOCKREPO_LIBDIR};

use Test::More;
use Gitolite::LockRepo;

is( get_lock('/foo'), (), "Should be empty hash, if file does not exist.");

my %lock = get_lock("${RealBin}/lock.fixture");
is($lock{MESSAGE}, 'message', 'Lock should contain message.');
is($lock{TIME}, '1411721884', 'Lock should contain time.');
is($lock{USER}, 'user', 'Lock should contain user.');

my $called;
{
    no warnings 'redefine';
    *Gitolite::LockRepo::error = sub { ++$called; return; };
}
is(get_lock("${RealBin}/badlock.fixture"), 0, 'Lock should be empty.');
ok($called, 'Error should be called.');

done_testing();
