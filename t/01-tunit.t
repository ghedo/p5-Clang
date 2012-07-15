#!perl -T

use Test::More;

use Clang::Index;

my $index = Clang::Index -> new(1);
my $tunit = $index -> parse('test.c');

is($tunit -> spelling, 'test.c');

done_testing;
