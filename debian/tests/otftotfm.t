use strict;
use warnings;

use Test::More;
use Test::Command::Simple;
use Test::TempDir::Tiny;

my $CMD = 'otftotfm';
my $dir;

my $CFF = '/usr/share/fonts/opentype/artemisia/GFSArtemisia.otf';
my $TTF = '/usr/share/fonts/truetype/font-awesome/fontawesome-webfont.ttf';

run_ok $CMD, '--version';
like stdout, qr/$CMD \(LCDF typetools\) [0-9.]+/, 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';

run_ok $CMD, '--help';
like stdout, qr/Usage: $CMD/, 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';

$dir = tempdir('CFF');
run_ok $CMD, qw/--encoding - --x-height font --directory/, $dir, $CFF;
cmp_ok stdout, 'eq', "GFSArtemisia-Regular GFSArtemisia-Regular \"AutoEnc_tlpfyxp3lo5cgcbyilrtblm2sf ReEncodeFont\" <[a_tlpfyx.enc <GFSArtemisia-Regular.pfb\n", 'Testing stdout';
cmp_ok stderr, 'eq', "I had to round some heights by 15.0000000 units.\nI had to round some depths by 4.0000000 units.\n", 'Testing stderr';

$dir = tempdir('TTF');
run_ok $CMD, qw/--encoding texnansx --no-type1 --x-height font --directory/, $dir, $TTF;
cmp_ok stdout, 'eq', "FontAwesome--texnansx--base FontAwesome \"AutoEnc_nnlvqm6glbqscthqdvzsdms22e ReEncodeFont\" <[a_nnlvqm.enc <fontawesome-webfont.ttf\n", 'Testing stdout';
cmp_ok stderr, 'eq', "otftotfm: warning: TrueType-flavored font support is experimental\n", 'Testing stderr';

$dir = tempdir('no explicit encoding');
run_ok 1, $CMD, qw/--encoding - --x-height font --directory/, $dir, $TTF;
cmp_ok stdout, 'eq', '', 'Testing stdout';
cmp_ok stderr, 'eq', "otftotfm: explicit encoding required for TrueType fonts\notftotfm: (Use '-e ENCODING' to choose an encoding. '-e texnansx' often works.)\n", 'Testing stderr';

done_testing;
