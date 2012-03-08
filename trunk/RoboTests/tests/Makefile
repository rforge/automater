include  Makevars

DIRS=${shell (ls -p -d -1 * | grep "/" )}

default: tests

update tests clean updateclean:
	@for f in ${DIRS}"" ; do \
	   (cd $$f ; $(MAKE) $@ );  \
	   done ; 
