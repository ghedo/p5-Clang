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

my $check_virtual = 'false';
my $virtual_name = 'undef';

_visit_node_virtual($cursr);

sub _visit_node_virtual {
	my $node = shift;
	if($node->is_virtual){
		$virtual_name = $node->spelling;
		$check_virtual = 'true';
	}
	my $children = $node->children;
	foreach my $child(@$children) {
		_visit_node_virtual($child);
	}
}
is($check_virtual,'true');
is($virtual_name,'name');

done_testing;
