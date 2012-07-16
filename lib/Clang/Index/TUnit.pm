package Clang::Index::TUnit;

use strict;
use warnings;

=head1 NAME

Clang::Index::TUnit - Clang translation unit class

=head1 DESCRIPTION

A C<Clang::Index::TUnit> represents a single translation unit which resides in
an index.

=head1 METHODS

=head2 cursor( )

Retrieve the L<Clang::Index::Cursor> corresponding to the given translation unit.

=head2 spelling( )

Retrieve the original translation unit source file name.

=head1 AUTHOR

Alessandro Ghedini <alexbio@cpan.org>

=head1 LICENSE AND COPYRIGHT

Copyright 2012 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of Clang::Index::TUnit
