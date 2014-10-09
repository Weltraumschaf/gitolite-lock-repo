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
is( hasBranchLock('branchname', %myData), 0, "Empty hash.");

%myData = setGeneralLock('user', 42, 'message', %myData);
is( hasBranchLock('branchname', %myData), 0, "General lock.");

%myData = setBranchLock('branchname', 'user', 42, 'message', %myData);
is( hasBranchLock('branchname', %myData), 1, "Branch locked.");

is( hasBranchLock('othername', %myData), 0, "Branch not locked.");

done_testing();