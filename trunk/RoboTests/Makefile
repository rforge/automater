include  Makevars

DIRS=${shell (ls -p -d -1 * | grep "/" )}

default: tests

tests clean:
	@for f in ${DIRS}"" ; do \
	   (cd $$f ; $(MAKE) $@ );  \
	   done ; 
