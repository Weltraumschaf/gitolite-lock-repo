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

is( hasGeneralLock(%myData), 0, 'Empty hash.');

%myData = setUser('user', %myData);
is( hasGeneralLock(%myData), 0, 'User set.');

%myData = setTime(123456789, %myData);
is( hasGeneralLock(%myData), 0, 'User and time set.');

%myData = setMessage('message', %myData);
is( hasGeneralLock(%myData), 1, 'User, time and message set.');

$myData{KEY_BRANCHES} = ();
is( hasGeneralLock(%myData), 1, 'User, time, message and empty branches set.');

done_testing();