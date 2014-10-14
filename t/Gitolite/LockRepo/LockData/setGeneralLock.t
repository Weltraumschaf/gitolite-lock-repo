#!/usr/bin/env perl

use strict;
use warnings;

use lib $ENV{GL_LIBDIR};

use Test::More;
use Gitolite::LockRepo::LockData;

my %myData = ();
is( hasGeneralLock(%myData), 0, 'Empty hash.');

%myData = setGeneralLock('user', 42, 'message', %myData);
is( hasGeneralLock(%myData), 1, 'User set.');
is( getUser(%myData), 'user', 'User expected.');
is( getTime(%myData), 42, 'Time expected.');
is( getMessage(%myData), 'message', 'Message expected.');

done_testing();
