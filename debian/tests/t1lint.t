use strict;
use warnings;

use Test::More;
use Test::Command::Simple;

my $CMD = 't1lint';

my $PFA = '/usr/share/fonts/type1/urw-base35/C059-BdIta.t1';
my $PFB = '/usr/share/fonts/type1/gsfonts/a010013l.pfb';
my $CFF = '/usr/share/fonts/opentype/artemisia/GFSArtemisia.otf';
my $TTF = '/usr/share/fonts/truetype/font-awesome/fontawesome-webfont.ttf';

run_ok $CMD, qw/--version/;
like stdout, qr/$CMD \(LCDF typetools\) [0-9.]+/, 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';

run_ok $CMD, qw/--help/;
like stdout, qr/Usage: $CMD/, 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';

run_ok $CMD, $PFA;
cmp_ok stdout, 'eq', "/usr/share/fonts/type1/urw-base35/C059-BdIta.t1: warning: StdVW not in StemSnapV array\n", 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';

run_ok $CMD, $PFB;
cmp_ok stdout, 'eq', '', 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';

run_ok 1, $CMD, $CFF;
cmp_ok stdout, 'eq', "/usr/share/fonts/opentype/artemisia/GFSArtemisia.otf: BlueValues not defined\n", 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';

run_ok 1, $CMD, $TTF;
cmp_ok stdout, 'eq', "/usr/share/fonts/truetype/font-awesome/fontawesome-webfont.ttf: BlueValues not defined\n", 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';

done_testing;
