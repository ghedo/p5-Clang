#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <clang-c/Index.h>

MODULE = Clang				PACKAGE = Clang::Index

CXIndex
new(class, exclude_decls)
	SV *class
	int exclude_decls

	CODE:
		RETVAL = clang_createIndex(exclude_decls, 0);

	OUTPUT:
		RETVAL

void
DESTROY(self)
	CXIndex self

	CODE:
		clang_disposeIndex(self);

CXTranslationUnit
parse(self, file, ...)
	CXIndex self
	SV *file

	CODE:
		STRLEN len;
		const char *path = SvPVbyte(file, len);

		RETVAL= clang_parseTranslationUnit(
			self, path, NULL, 0, NULL, 0, 0
		);

	OUTPUT:
		RETVAL

MODULE = Clang				PACKAGE = Clang::Index::TUnit

CXCursor *
cursor(self)
	CXTranslationUnit self

	CODE:
		CXCursor *retval = malloc(sizeof(CXCursor));
		CXCursor cursor = clang_getTranslationUnitCursor(self);
		*retval = cursor;
		RETVAL = retval;

	OUTPUT:
		RETVAL

SV *
spelling(self)
	CXTranslationUnit self

	CODE:
		CXString spelling = clang_getTranslationUnitSpelling(self);
		RETVAL = newSVpv(clang_getCString(spelling), 0);

	OUTPUT:
		RETVAL

MODULE = Clang				PACKAGE = Clang::Index::Cursor

enum CXCursorKind
kind(self)
	CXCursor *self

	CODE:
		RETVAL = clang_getCursorKind(*self);

	OUTPUT:
		RETVAL

SV *
spelling(self)
	CXCursor *self

	CODE:
		CXString spelling = clang_getCursorSpelling(*self);
		RETVAL = newSVpv(clang_getCString(spelling), 0);

	OUTPUT:
		RETVAL

SV *
displayname(self)
	CXCursor *self

	CODE:
		CXString dname = clang_getCursorDisplayName(*self);
		RETVAL = newSVpv(clang_getCString(dname), 0);

	OUTPUT:
		RETVAL

void
DESTROY(self)
	CXCursor *self

	CODE:
		free(self);

MODULE = Clang				PACKAGE = Clang::Index::CursorKind

SV *
spelling(self)
	enum CXCursorKind self

	CODE:
		CXString spelling = clang_getCursorKindSpelling(self);
		RETVAL = newSVpv(clang_getCString(spelling), 0);

	OUTPUT:
		RETVAL
