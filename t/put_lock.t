#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
BEGIN { $ENV{LOCKREPO_LIBDIR} = "${FindBin::RealBin}/../src/lib"; }

use lib $ENV{GL_LIBDIR};
use lib $ENV{LOCKREPO_LIBDIR};

use Test::More;
use File::Temp qw( tempfile tempdir );
use Gitolite::Common;

use Gitolite::LockRepo;

my ($fh, $filename) = tempfile();
put_lock($filename, ());
is( slurp($filename), '%lock = ();' . "\n", "Expect empty hash structure." );

my %myData = ();
$myData{USER}    = 'username';
$myData{TIME}    = 123456789;
$myData{MESSAGE} = 'message';
put_lock($filename, %myData);
my $expected = <<'END_TEXT';
%lock = (
  'MESSAGE' => 'message',
  'TIME' => 123456789,
  'USER' => 'username'
);
END_TEXT

is( slurp($filename), $expected, "Expect hash structure." );

done_testing();
