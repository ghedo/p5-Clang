#!perl -T

use Test::More;

use Clang;

my $index = Clang::Index -> new(0);
my $tunit = $index -> parse('t/test.c');
my $cursr = $tunit -> cursor;

is($cursr -> spelling, 't/test.c');
is($cursr -> displayname, 't/test.c');

my $cursors = $cursr -> children;

my @spellings = map { $_ -> spelling } @$cursors;
my @expected  = qw(
	__int128_t
	__uint128_t
	__builtin_va_list
	foo
	main
);

is_deeply(\@spellings, \@expected);

my ($file, $line, $column) = $cursr -> location;
is($file, ''); is($line, 0); is($column, 0);

my @locations = map { join ' ', $_ -> location } @$cursors;
@expected     = (
	' 0 0',
	' 0 0',
	' 0 0',
	't/test.c 1 6',
	't/test.c 7 5'
);
is_deeply(\@locations, \@expected);

done_testing;
