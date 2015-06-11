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

my @locations = map { join ' ', $_ -> location } @$cursors;
@expected     = (
	't/test.c 1 6 5 2',
	't/test.c 7 5 11 2'
);
is_deeply(\@locations, \@expected);

$index = Clang::Index -> new(0);
$tunit = $index -> parse('t/main.cpp');
$cursr = $tunit -> cursor;

#Testing of method spelling
is($cursr -> spelling, 't/main.cpp');

#Testing of method num_arguments

my $num_arguments = 0;
_visit_node_arguments($cursr);

sub _visit_node_arguments {
	my $node = shift;
	if($node->kind->spelling() eq "FunctionDecl"){
		$num_arguments = $node->num_arguments;
	}
	my $children = $node->children;
	foreach my $child(@$children) {
		_visit_node_arguments($child);
	}
}
is($num_arguments, 2);

#Testing of method displayname
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

@locations = map { join ' ', $_ -> location } @$cursors;
@expected     = (
	't/person.h 4 7 13 2',
	't/main.cpp 3 5 5 2'
);
is_deeply(\@locations, \@expected);

$cursors = @$cursors[0] -> children;

@access = map { join ' ', $_ -> access_specifier } @$cursors;
@expected = (
		'public',
		'public',
		'public',
		'public',
		'private',
		'private',
		'private'
);
is_deeply(\@access,\@expected);

#Testing if a method is pure virtual or not

$index = Clang::Index -> new(0);
$tunit = $index -> parse('t/cpp/cat.cc');
$cursr = $tunit -> cursor;
$kind = $cursr -> kind;
$cursors = $cursr -> children;

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

#Testing if a method is virtual or not

$index = Clang::Index -> new(0);
$tunit = $index -> parse('t/cpp/cat.cc');
$cursr = $tunit -> cursor;
$kind = $cursr -> kind;
$cursors = $cursr -> children;

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

$tunit = $index -> parse('t/main.cpp');
$cursr = $tunit -> cursor;
my $method_num_arguments = -4;

sub _visit_node_method_arguments {
	my $node = shift;
	if($node->kind->spelling() eq "CXXMethod"){
		if ($node->spelling() eq "walk"){
				$method_num_arguments = $node->num_arguments;
				is($method_num_arguments, 2);
			}
		else{ ## test methods getAge() and getId()
			$method_num_arguments = $node->num_arguments;
			is($method_num_arguments, 0);
		}
	}
	my $children = $node->children;
	foreach my $child(@$children) {
		_visit_node_method_arguments($child);
	}
}

_visit_node_method_arguments($cursr);

done_testing;
