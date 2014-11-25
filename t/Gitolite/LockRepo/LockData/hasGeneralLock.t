#!/usr/bin/env perl

use strict;
use warnings;

use lib $ENV{GL_LIBDIR};

use Test::More;
use Gitolite::LockRepo::LockData;

my %myData = ();

is( hasGeneralLock(%myData), '', 'False for empty hash.');

%myData = setUser('user', %myData);
is( hasGeneralLock(%myData), '', 'User set.');

%myData = setTime(123456789, %myData);
is( hasGeneralLock(%myData), '', 'User and time set.');

%myData = setMessage('message', %myData);
is( hasGeneralLock(%myData), '1', 'User, time and message set.');

$myData{KEY_BRANCHES} = ();
is( hasGeneralLock(%myData), '1', 'User, time, message and empty branches set.');

done_testing();
