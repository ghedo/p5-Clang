#!perl -T

use Test::More;

use Clang;
use strict;
use warnings;

my $index = Clang::Index -> new(0);
my $tunit = $index -> parse('t/fragments/cat.cc');
my $cursr = $tunit -> cursor;
my $kind = $cursr -> kind;
my $cursors = $cursr -> children;

my $check_pure_virtual = 'false';
my $pure_virtual_name = 'undef';

_visit_node($cursr);

sub _visit_node {
	my $node = shift;
	if($node->is_pure_virtual){
		$pure_virtual_name = $node->spelling;
		$check_pure_virtual = 'true';
	}
	my $children = $node->children;
	foreach my $child(@$children) {
		_visit_node($child);
	}
}
is($check_pure_virtual,'true');
is($pure_virtual_name,'name');

done_testing;
