#!perl -T

use Test::More;

use Clang;
use strict;
use warnings;

my $index = Clang::Index -> new(0);
my $tunit = $index -> parse('t/fragments/main.cpp');
my $cursr = $tunit -> cursor;

my $cursors = $cursr -> children;
$cursors = @$cursors[0] -> children;

my @access = map { join ' ', $_ -> access_specifier } @$cursors;
my @expected = (
		'public',
		'public',
		'public',
		'public',
		'private',
		'private',
		'private'
);
is_deeply(\@access,\@expected);

done_testing;
