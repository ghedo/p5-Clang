package Clang::Index::Cursor;

use strict;
use warnings;

=head1 NAME

Clang::Index::Cursor - Clang cursor class

=head1 DESCRIPTION

A <Clang::Index::Cursor> represents an element in the abstract syntax tree of a
translation unit.

=head1 METHODS

=head2 kind( )

Retrieve the L<Clang::Index::CursorKind> of the given cursor.

=head2 spelling( )

Retrieve the name for the entity referenced by the given cursor.

=head2 displayname( )

Return the display name for the entity referenced by the given cursor.

=head2 children( )

Retrieve a list of the children of the given cursor. The children are
C<Clang::Index::Cursor> objects too.

=head2 location( )

Retrieve the location of the given cursor. This function returns three values,
a string containing the source file name, an integer containing the line number
and another integer containing the column number.

=head1 AUTHOR

Alessandro Ghedini <alexbio@cpan.org>

=head1 LICENSE AND COPYRIGHT

Copyright 2012 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of Clang::Index::Cursor
