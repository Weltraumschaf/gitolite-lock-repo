#!/usr/bin/env perl

use strict;
use warnings;

use lib $ENV{GL_LIBDIR};

use FindBin qw( $RealBin );
use Test::More;
use Gitolite::LockRepo;

my $fixtureDir = "${RealBin}/../../fixtures";

is( get_lock('/foo'), (), "Should be empty hash, if file does not exist." );

# Good input file.

my %lock = get_lock("$fixtureDir/lock");
is( $lock{MESSAGE}, 'message',    'Lock should contain message.' );
is( $lock{TIME},    '1411721884', 'Lock should contain time.' );
is( $lock{USER},    'user',       'Lock should contain user.' );

# Bad input file.

my $called;
{
    no warnings 'redefine';
    *Gitolite::LockRepo::error = sub { ++$called; return; };
}
is( get_lock("$fixtureDir/badlock"), 0, 'Lock should be empty.' );
ok( $called, 'Error should be called.' );

done_testing();
