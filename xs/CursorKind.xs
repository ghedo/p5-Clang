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
