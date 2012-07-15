package Clang::Index;

use strict;
use warnings;

use Clang;

=head1 NAME

Clang::Index - Perl bindings to the Clang compiler's Index interface

=head1 SYNOPSIS

    use Clang::Index;

    my $index = Clang::Index -> new(1);

    my $tunit = $index -> parse('file.c');

=head1 DESCRIPTION

B<Clang::Index> provides Perl bindings to the Clang indexing interface, used
for extracting high-level symbol information from source files without exposing
the full Clang C++ API.

B<Attention>: note that this module is still under development and currently
lacks most of the functionality needed to make it useful.

=head1 METHODS

=head2 new( $exclude_declarations )

Create a new C<Clang::Index> object.

=head2 parse( $file )

Parse a source file and return a new translation unit.

=head1 AUTHOR

Alessandro Ghedini <alexbio@cpan.org>

=head1 LICENSE AND COPYRIGHT

Copyright 2012 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of Clang::Index
