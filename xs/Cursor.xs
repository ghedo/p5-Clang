MODULE = Clang				PACKAGE = Clang::Cursor

CursorKind
kind(self)
	Cursor self

	CODE:
		RETVAL = clang_getCursorKind(*self);

	OUTPUT: RETVAL

Type
type(self)
	Cursor self

	CODE:
		CXType *retval = malloc(sizeof(CXType));
		CXType type = clang_getCursorType(*self);
		*retval = type;
		RETVAL = retval;

	OUTPUT: RETVAL

SV *
spelling(self)
	Cursor self

	CODE:
		CXString spelling = clang_getCursorSpelling(*self);
		RETVAL = newSVpv(clang_getCString(spelling), 0);

	OUTPUT: RETVAL

SV *
displayname(self)
	Cursor self

	CODE:
		CXString dname = clang_getCursorDisplayName(*self);
		RETVAL = newSVpv(clang_getCString(dname), 0);

	OUTPUT: RETVAL

AV *
children(self)
	Cursor self

	CODE:
		AV *children = newAV();

		clang_visitChildren(*self, visitor, children);

		RETVAL = children;

	OUTPUT: RETVAL

void
location(self)
	Cursor self

	INIT:
		CXFile file;
		const char *filename;
		unsigned int line, column, offset,line_end,column_end;

	PPCODE:
		CXSourceLocation loc = clang_getCursorLocation(*self);

		CXSourceRange range = clang_getCursorExtent(*self);
	
		CXSourceLocation locEnd = clang_getRangeEnd(range);
		
		clang_getSpellingLocation(loc, &file, &line, &column, NULL);

		clang_getSpellingLocation(locEnd,NULL,&line_end,&column_end,NULL);		

		filename = clang_getCString(clang_getFileName(file));

		if (filename != NULL)
			mXPUSHp(filename, strlen(filename));
		else
			mXPUSHp("", 0);

		mXPUSHi(line);
		mXPUSHi(column);
		mXPUSHi(line_end);

SV * 
get_access_specifier(self)
	Cursor self
	
	CODE:
		enum CX_CXXAccessSpecifier access = clang_getCXXAccessSpecifier(*self);			
		
		const char *accessStr = 0;

	      	switch (access) {
			case CX_CXXInvalidAccessSpecifier:
		  		accessStr = "invalid"; break;
			case CX_CXXPublic:
		  		accessStr = "public"; break;
			case CX_CXXProtected:
		  		accessStr = "protected"; break;
			case CX_CXXPrivate:
		  		accessStr = "private"; break;
	      	}
      
		RETVAL = newSVpv(accessStr,0);

	OUTPUT: RETVAL


void
DESTROY(self)
	Cursor self

	CODE:
		free(self);
