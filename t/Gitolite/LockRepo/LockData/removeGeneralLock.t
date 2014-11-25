#!/usr/bin/env perl

use strict;
use warnings;

use lib $ENV{GL_LIBDIR};

use Test::More;
use Gitolite::LockRepo::LockData;

my %myData = setGeneralLock('user', 42, 'message', ());
is( hasGeneralLock(%myData), '1', 'Lock expected');

%myData = removeGeneralLock(%myData);
is( hasGeneralLock(%myData), '', 'Removed lock expected.');

is( getUser(%myData), '', 'Empty user expected.');
is( getTime(%myData), 0, '0 time expected.');
is( getMessage(%myData), '', 'Empty message expected.');

done_testing();
