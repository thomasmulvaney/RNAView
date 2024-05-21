CC     = cc

# By default we install into /usr/local
PREFIX = /usr/local

#----------------------------------------------------------------------------
# Project specific path defintions.
#----------------------------------------------------------------------------
PROJDIR    = .

SRC        = $(PROJDIR)/src
INCL       = $(PROJDIR)/include
OBJ        = $(PROJDIR)/obj
BIN        = $(PROJDIR)/bin
TEST       = $(PROJDIR)/test

LDEFINES    = -DNO_RANGE_CHECK
LINCLUDES      =  -I$(INCL)

#----------------------------------------------------------------------------
# Target files
#----------------------------------------------------------------------------
RNAVIEW    = $(BIN)/rnaview

HFILES = $(wildcard $(INCL)/*.h)
SRCFILES = $(wildcard $(SRC)/*.c)

# Every C file should be made into and Object file.
OBJ_FILES = $(patsubst $(SRC)/%.c, $(OBJ)/%.o, $(SRCFILES))

# Rule to compile source to object.
$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(CFLAGS) -c -o $@ $^


all: $(RNAVIEW)

install: $(RNAVIEW)
	mkdir -p $(PREFIX)/bin
	mkdir -p $(PREFIX)/share/RNAVIEW
	cp bin/rnaview $(PREFIX)/bin/rnaview
	cp -r BASEPARS $(PREFIX)/share/RNAVIEW/

CFLAGS  = -g -Wall  $(LINCLUDES) -DPREFIX='"$(PREFIX)"'
LDFLAGS = -lm


$(RNAVIEW): $(OBJ_FILES) 
	$(CC) $(CFLAGS) $(MALLOCLIB) -o $@ $^ $(LDFLAGS)


clean:
	@rm -f $(OBJ_FILES)
	@rm -f $(RNAVIEW)

export:
	mkdir -p $(EXPORT_DIR)
	@cd $(EXPORT_DIR); mkdir -p $(INCL)
	$(EXPORT) $(EXPORT_LIST) $(HFILES) $(EXPORT_DIR)/$(INCL)
	@cd $(EXPORT_DIR); mkdir -p $(SRC)
	$(EXPORT) $(EXPORT_LIST) $(SRCFILES) $(TARGETSRC) $(EXPORT_DIR)/$(SRC)
	@cd $(EXPORT_DIR); mkdir -p $(BIN)
	@cd $(EXPORT_DIR); mkdir -p $(LIB)
	@cd $(EXPORT_DIR); mkdir -p $(OBJ)
	@cd $(EXPORT_DIR); mkdir -p $(TEST)
	@cp $(TESTFILES) $(EXPORT_DIR)/$(TEST)
	@cp Makefile $(EXPORT_DIR)




