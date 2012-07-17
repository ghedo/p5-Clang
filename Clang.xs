#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <clang-c/Index.h>

enum CXChildVisitResult visitor(CXCursor cursor, CXCursor parent, CXClientData data) {
	SV *child;
	AV *children = data;

	CXCursor *ref = malloc(sizeof(CXCursor));
	*ref = cursor;

	child = sv_setref_pv(newSV(0), "Clang::Cursor", (void *) ref);

	av_push(children, child);

	return CXChildVisit_Continue;
}

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
		CXTranslationUnit tu = clang_parseTranslationUnit(
			self, path, NULL, 0, NULL, 0, 0
		);

		RETVAL = tu;

	OUTPUT:
		RETVAL

MODULE = Clang				PACKAGE = Clang::TUnit

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

void
DESTROY(self)
	CXTranslationUnit self

	CODE:
		clang_disposeTranslationUnit(self);

MODULE = Clang				PACKAGE = Clang::Cursor

enum CXCursorKind
kind(self)
	CXCursor *self

	CODE:
		RETVAL = clang_getCursorKind(*self);

	OUTPUT:
		RETVAL

CXType *
type(self)
	CXCursor *self

	CODE:
		CXType *retval = malloc(sizeof(CXType));
		CXType type = clang_getCursorType(*self);
		*retval = type;
		RETVAL = retval;

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

AV *
children(self)
	CXCursor *self

	CODE:
		AV *children = newAV();

		CXString spelling = clang_getCursorSpelling(*self);
		puts(clang_getCString(spelling));
		clang_visitChildren(*self, visitor, children);

		RETVAL = children;

	OUTPUT:
		RETVAL

void
location(self)
	CXCursor *self

	INIT:
		CXFile file;
		const char *filename;
		unsigned int line, column, offset;

	PPCODE:
		CXSourceLocation loc = clang_getCursorLocation(*self);

		clang_getSpellingLocation(loc, &file, &line, &column, NULL);

		filename = clang_getCString(clang_getFileName(file));

		if (filename != NULL)
			mXPUSHp(filename, strlen(filename));
		else
			mXPUSHp("", 0);

		mXPUSHi(line);
		mXPUSHi(column);

void
DESTROY(self)
	CXCursor *self

	CODE:
		free(self);

MODULE = Clang				PACKAGE = Clang::CursorKind

SV *
spelling(self)
	enum CXCursorKind self

	CODE:
		CXString spelling = clang_getCursorKindSpelling(self);
		RETVAL = newSVpv(clang_getCString(spelling), 0);

	OUTPUT:
		RETVAL

SV *
is_declaration(self)
	enum CXCursorKind self

	CODE:
		RETVAL = clang_isDeclaration(self) ? &PL_sv_yes : &PL_sv_no;

	OUTPUT:
		RETVAL

SV *
is_reference(self)
	enum CXCursorKind self

	CODE:
		RETVAL = clang_isReference(self) ? &PL_sv_yes : &PL_sv_no;

	OUTPUT:
		RETVAL

SV *
is_expression(self)
	enum CXCursorKind self

	CODE:
		RETVAL = clang_isExpression(self) ? &PL_sv_yes : &PL_sv_no;

	OUTPUT:
		RETVAL

SV *
is_statement(self)
	enum CXCursorKind self

	CODE:
		RETVAL = clang_isStatement(self) ? &PL_sv_yes : &PL_sv_no;

	OUTPUT:
		RETVAL

SV *
is_attribute(self)
	enum CXCursorKind self

	CODE:
		RETVAL = clang_isAttribute(self) ? &PL_sv_yes : &PL_sv_no;

	OUTPUT:
		RETVAL

SV *
is_invalid(self)
	enum CXCursorKind self

	CODE:
		RETVAL = clang_isInvalid(self) ? &PL_sv_yes : &PL_sv_no;

	OUTPUT:
		RETVAL

SV *
is_tunit(self)
	enum CXCursorKind self

	CODE:
		RETVAL = clang_isTranslationUnit(self) ? &PL_sv_yes : &PL_sv_no;

	OUTPUT:
		RETVAL

SV *
is_preprocessing(self)
	enum CXCursorKind self

	CODE:
		RETVAL = clang_isPreprocessing(self) ? &PL_sv_yes : &PL_sv_no;

	OUTPUT:
		RETVAL

SV *
is_unexposed(self)
	enum CXCursorKind self

	CODE:
		RETVAL = clang_isUnexposed(self) ? &PL_sv_yes : &PL_sv_no;

	OUTPUT:
		RETVAL

MODULE = Clang				PACKAGE = Clang::Type

CXCursor *
declaration(self)
	CXType *self

	CODE:
		CXCursor *retval = malloc(sizeof(CXCursor));
		CXCursor cursor  = clang_getTypeDeclaration(*self);
		*retval = cursor;

		RETVAL = retval;

	OUTPUT:
		RETVAL

enum CXTypeKind
kind(self)
	CXType *self

	CODE:
		RETVAL = self -> kind;
	
	OUTPUT:
		RETVAL

SV *
is_const(self)
	CXType *self

	CODE:
		RETVAL = clang_isConstQualifiedType(*self) ?
			&PL_sv_yes : &PL_sv_no;

	OUTPUT:
		RETVAL

SV *
is_volatile(self)
	CXType *self

	CODE:
		RETVAL = clang_isVolatileQualifiedType(*self) ?
			&PL_sv_yes : &PL_sv_no;

	OUTPUT:
		RETVAL

SV *
is_restrict(self)
	CXType *self

	CODE:
		RETVAL = clang_isRestrictQualifiedType(*self) ?
			&PL_sv_yes : &PL_sv_no;

	OUTPUT:
		RETVAL

void
DESTROY(self)
	CXType *self

	CODE:
		free(self);

MODULE = Clang				PACKAGE = Clang::TypeKind

SV *
spelling(self)
	enum CXTypeKind self

	CODE:
		CXString spelling = clang_getTypeKindSpelling(self);
		RETVAL = newSVpv(clang_getCString(spelling), 0);

	OUTPUT:
		RETVAL
