#!perl -T

use Test::More;

use Clang::Index;

my $index = Clang::Index -> new(1);
my $tunit = $index -> parse('test.c');
my $cursr = $tunit -> cursor;

is($cursr -> spelling, 'test.c');
is($cursr -> displayname, 'test.c');

done_testing;
