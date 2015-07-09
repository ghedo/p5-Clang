#!perl -T

use Test::More;

use Clang;
use strict;
use warnings;

my $index = Clang::Index -> new(0);
my $tunit = $index -> parse('t/fragments/test_cursor_referenced.cpp');
my $cursr = $tunit -> cursor;
my @got = ();
my @expected = get_expected();
_visit_node($cursr -> children);

sub _visit_node {
	my ($node) = @_;
	my @children = @{$node};
	foreach my $child(@children) {
	    if($child->kind->spelling eq "CallExpr"){
            my $referenced = $child-> get_cursor_referenced();
            my $cursor = join(" ",$referenced->spelling ,$referenced->kind->spelling);
            push @got, $cursor;
        }
        _visit_node($child-> children);
    }
}
is_deeply(\@got,\@expected);

sub get_expected{
    my @expected = (
        "Person CXXConstructor",
        "sum FunctionDecl",
   );
    return @expected;
}

done_testing;
