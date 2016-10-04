use strict;
use FindBin;
use Test::More;
use File::Temp qw/tempdir/;

use App::MechaCPAN;

# Note: we don't test with git or ssh since those require some kind of login
foreach my $src (qw[
  test_dists/NoDeps/NoDeps-1.0.tar.gz
  authors/id/E/ET/ETHER/Try-Tiny-0.24.tar.gz
  E/ET/ETHER/Try-Tiny-0.24.tar.gz
  ETHER/Try-Tiny-0.24.tar.gz
  https://github.com/p5sagit/Try-Tiny.git
  https://github.com/p5sagit/Try-Tiny.git@v0.24
  https://github.com/p5sagit/Try-Tiny/archive/v0.24.zip
  Try::Tiny
  Try::Tiny@0.24
  Try::Tiny~0.24
  Try::Tiny~<0.24
 ],
 [qw/Try::Tiny 0.24/],
 [qw/Try::Tiny <0.24/],
 )
{
  local $App::MechaCPAN::Install::dest_dir = tempdir( TEMPLATE => 't_mechacpan_XXXXXXXX', CLEANUP => 1 );
  local $@;
  my $tgz = eval { App::MechaCPAN::Install::_get_targz($src) };
  diag("Error: '$@'")
    if $@;
  ok(-s $tgz, "Got '$src'");
}

done_testing;
