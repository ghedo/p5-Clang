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
