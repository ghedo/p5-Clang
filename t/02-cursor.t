#!perl -T

use Test::More;

use Clang::Index;

my $index = Clang::Index -> new(0);
my $tunit = $index -> parse('t/test.c');
my $cursr = $tunit -> cursor;

is($cursr -> spelling, 't/test.c');
is($cursr -> displayname, 't/test.c');

my $cursors = $cursr -> children;

my @spellings = map { $_ -> spelling } @$cursors;

my @expected = qw(__int128_t __uint128_t __va_list_tag __va_list_tag
	__builtin_va_list foo main);
is_deeply(\@spellings, \@expected);

done_testing;
