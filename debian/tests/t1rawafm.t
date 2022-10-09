use strict;
use warnings;

use Test::More;
use Test::Command::Simple;
use Test::TempDir::Tiny;

my $CMD = 't1rawafm';
my $dir;

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

$dir = tempdir('PFA');
run_ok $CMD, '--output', "$dir/font.afm", $PFA;
cmp_ok stdout, 'eq', '', 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';
is -f "$dir/font.afm", 1, 'Font file created';

$dir = tempdir('PFB');
run_ok $CMD, '--output', "$dir/font.afm", $PFB;
cmp_ok stdout, 'eq', '', 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';
is -f "$dir/font.afm", 1, 'Font file created';

$dir = tempdir('CFF');
run_ok 1, $CMD, '--output', "$dir/font.afm", $CFF;
cmp_ok stdout, 'eq', '', 'Testing stdout';
cmp_ok stderr, 'eq', "$CFF: not a Type 1 font\n", 'Testing stderr';
is -f "$dir/font.afm", undef, 'Font file not created';

$dir = tempdir('TTF');
run_ok 1, $CMD, '--output', "$dir/font.afm", $TTF;
cmp_ok stdout, 'eq', '', 'Testing stdout';
cmp_ok stderr, 'eq', "$TTF: not a Type 1 font\n", 'Testing stderr';
is -f "$dir/font.afm", undef, 'Font file not created';

done_testing;
