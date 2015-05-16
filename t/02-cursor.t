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
	foo
	main
);

is_deeply(\@spellings, \@expected);

my ($file, $line, $column) = $cursr -> location;
is($file, ''); is($line, 0); is($column, 0);


my @locations = map { join ' ', my($file,$line,$column) = $_ -> location } @$cursors;
@expected     = (
	't/test.c 1 6',
	't/test.c 7 5'
);
is_deeply(\@locations, \@expected);

@locations = map { join ' ', $_ -> location } @$cursors;
@expected     = (
	't/test.c 1 6 5',
	't/test.c 7 5 11'
);
is_deeply(\@locations, \@expected);

#doing the same test on a cpp file

$index = Clang::Index -> new(0);
$tunit = $index -> parse('t/main.cpp');
$cursr = $tunit -> cursor;

is($cursr -> spelling, 't/main.cpp');
is($cursr -> displayname, 't/main.cpp');

$cursors = $cursr -> children;

@spellings = map { $_ -> spelling } @$cursors;
@expected  = qw(
	Person
	main
);

is_deeply(\@spellings, \@expected);

($file, $line, $column) = $cursr -> location;
is($file, ''); is($line, 0); is($column, 0);


@locations = map { join ' ', my($file,$line,$column) = $_ -> location } @$cursors;
@expected     = (
	't/person.h 4 7',
	't/main.cpp 3 5'
);
is_deeply(\@locations, \@expected);

@locations = map { join ' ', $_ -> location } @$cursors;
@expected     = (
	't/person.h 4 7 16',
	't/main.cpp 3 5 6'
);
is_deeply(\@locations, \@expected);

done_testing;
