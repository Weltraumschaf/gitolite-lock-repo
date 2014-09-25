#!//usr/bin/perl -T

use warning;
use strict;

use FindBin;
BEGIN { $ENV{LOCKREPO_LIBDIR} = "${FindBin::RealBin}/../src/lib"; }

use lib $ENV{LOCKREPO_LIBDIR};
use Test::More
use Gitolite::LockRepo;

ok(true);

done_testing();